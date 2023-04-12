import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/YandayKey.dart/Key.dart';
import 'package:http/http.dart' as http;

const int PAGESIZE = 2;

abstract class EventBillaAPI {}

class EventBillaAPISearch extends EventBillaAPI {
  late Uri uri;
  BuildContext context;
  String key;
  String product;
  EventBillaAPISearch(this.product, this.key, this.context) {
    String tmp =
        "https://www.billa.at/api/products/search/$product?page=0&pageSize=$PAGESIZE";
    uri = Uri.parse(tmp);
  }

  Future<Uri> getGermanUri() async {
    var res = await http.get(Yanday().uriEnglischtoGerman(this.product));
    var yandayRes = YandexResponse.fromJson(jsonDecode(res.body));
    var product = yandayRes.translations.first;

    return Uri.parse(
        "https://www.billa.at/api/products/search/$product?page=0&pageSize=$PAGESIZE");
  }
}

class EventBillaArticleDetails extends EventBillaAPI {
  late Uri uri;
  String foodId;
  EventBillaArticleDetails(this.foodId, String articleId) {
    String tmp =
        "https://shop.billa.at/api/articles/$articleId?includeDetails=true";
    uri = Uri.parse(tmp);
  }
}

class EventBillaAPIAddToBascet extends EventBillaAPI {}
