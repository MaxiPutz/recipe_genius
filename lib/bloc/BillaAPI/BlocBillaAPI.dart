import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIResponse.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:http/http.dart' as http;

import 'event/EventBillaAPI.dart';

class BlocBillaAPI extends Bloc<EventBillaAPI, StateBillaAPI> {
  BlocBillaAPI() : super(StateBillaAPI()) {
    on<EventBillaAPISearch>((event, emit) async {
      var res = await http.get(event.uri);
      var json = jsonDecode(res.body);
      var billaRes = BillaAPISearchResponse.fromJson(json);
      print(billaRes.results);

      billaRes.results.forEach((element) {
        print(element.articleId);
        event.context
            .read<BlocBillaAPI>()
            .add(EventBillaArticleDetails(element.articleId));
      });
    });
    on<EventBillaArticleDetails>(
      (event, emit) async {
        var res = await http.get(event.uri);
        print(res.body);
      },
    );
  }
}
