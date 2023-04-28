import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_genius/platform/platform.dart';
import 'package:recipe_genius/translation/GoogleTranslator.dart';

const int PAGESIZE = 4;

abstract class EventBillaAPI {}

class EventBillaAPISearch extends EventBillaAPI {
  late Uri uri;
  BuildContext context;
  String foodId;
  String product;
  EventBillaAPISearch(this.product, this.foodId, this.context) {
    String tmp =
        "https://www.billa.at/api/products/search/$product?page=0&pageSize=$PAGESIZE";
    uri = Uri.parse(tmp);
  }

  Future<Uri> getGermanUri() async {
    product = await translateFromEnToDe(product);
    return Uri.parse(
        "https://www.billa.at/api/products/search/$product?page=0&pageSize=$PAGESIZE");
  }
}

class EventBillaArticleDetails extends EventBillaAPI {
  late Uri uri;
  String foodId;
  String articleId;
  EventBillaArticleDetails(this.foodId, this.articleId) {
    String tmp =
        "https://shop.billa.at/api/articles/$articleId?includeDetails=true";
    uri = Uri.parse(tmp);
  }
}

class EventBillaAPIAddToBascet extends EventBillaAPI {
  int quantity;
  String articleId;

  EventBillaAPIAddToBascet({required this.articleId, required this.quantity});

  Future<String> _getBaskedId() async {
    var file = await readFileBaskedId();
    return file.readAsStringSync();
  }

  Future<Uri> _getUri() async {
    var baskedId = await _getBaskedId();
    print("baskedId");
    print(baskedId);
    return Uri.parse("https://shop.billa.at/api/basket/$baskedId/items");
  }

  Future<PostBilla> getPostRequest() async {
    final uri = await _getUri();
    return PostBilla(uri: uri, articleId: articleId, quantity: quantity);
  }
}

class PostBilla {
  Uri uri;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json;charset=utf-8"
  };
  late Object body;
  PostBilla({
    required this.uri,
    required String articleId,
    required int quantity,
  }) {
    body = jsonEncode([
      {
        "articleId": articleId,
        "quantity": quantity,
      }
    ]);
  }
}
