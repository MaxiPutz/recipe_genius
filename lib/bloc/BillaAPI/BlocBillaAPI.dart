import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIArticleDetail.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIResponse.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';

import 'event/EventBillaAPI.dart';

//events comes now from main.dart search for spinach and get article informatino
class BlocBillaAPI extends Bloc<EventBillaAPI, StateBillaAPI> {
  BlocBillaAPI() : super(StateBillaAPI()) {
    on<EventBillaAPISearch>((event, emit) async {
      var gerUri = await event.getGermanUri();
      var res = await http.get(gerUri);
      var json = jsonDecode(res.body);
      var billaRes = BillaAPISearchResponse.fromJson(json);
      print(billaRes.results);

      billaRes.results.forEach((element) {
        print(element.articleId);
        event.context
            .read<BlocBillaAPI>()
            .add(EventBillaArticleDetails(event.key, element.articleId));
      });
      emit(state.setData(event.key, billaRes));
    });
    on<EventBillaArticleDetails>(
      (event, emit) async {
        var res = await http.get(event.uri);
        var jsonRes = jsonDecode(res.body);
        var product = BillaProduct.fromJson(jsonRes);
        print("BlocBillaAPI");
        print(product.name);
        print(product.price.normal);

        emit(state.setProductInfo(event.articleId, product));
      },
    );
  }
}
