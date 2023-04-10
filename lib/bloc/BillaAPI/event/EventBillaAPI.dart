import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';

abstract class EventBillaAPI {}

class EventBillaAPISearch extends EventBillaAPI {
  late Uri uri;
  BuildContext context;
  EventBillaAPISearch(String product, this.context) {
    String tmp =
        "https://www.billa.at/api/products/search/$product?page=0&pageSize=2";
    uri = Uri.parse(tmp);
  }
}

class EventBillaArticleDetails extends EventBillaAPI {
  late Uri uri;
  EventBillaArticleDetails(String articleId) {
    String tmp =
        "https://shop.billa.at/api/articles/$articleId?includeDetails=true";
    uri = Uri.parse(tmp);
  }
}

class EventBillaAPIAddToBascet extends EventBillaAPI {}
