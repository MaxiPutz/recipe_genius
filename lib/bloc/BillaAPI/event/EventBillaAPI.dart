import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/translation/GoogleTranslator.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/YandayKey.dart/Key.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_genius/translation/translation.dart';

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
    var val = await getTranslation(foodId);

    if (val.german.length > 1) {
      print("should not here");
      return Uri.parse(
          "https://www.billa.at/api/products/search/${val.german}?page=0&pageSize=$PAGESIZE");
    }

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

class EventBillaAPIAddToBascet extends EventBillaAPI {}
