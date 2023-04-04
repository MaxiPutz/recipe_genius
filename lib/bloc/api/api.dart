import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/api/Response/Menu.dart';
import 'package:recipe_genius/bloc/api/key/EdmamKey.dart';
import 'package:recipe_genius/bloc/api/event/event.dart';
import 'package:recipe_genius/bloc/api/state/Recepie.dart';
import 'package:http/http.dart' as http;
import "dart:io" as io;

Uri menueRequest(String appId, String appKey, String menuName) {
  var url =
      "https://api.edamam.com/search?q=$menuName&app_id=$appId&app_key=$appKey";

  return Uri.parse(url);
}

class BlocAPI extends Bloc<EventAPI, StateAPI> {
  BlocAPI() : super(StateAPI()) {
    on<EventFindRecepies>(((event, emit) async {
      var res = await getMenuData(menueRequest(
          state.recepieKey.appID, state.recepieKey.appKey, event.menuName));

      var newState = state.setResponseMenue(res);
      print(res.toString());

      var file = io.File("./test.json");
      file.writeAsStringSync(jsonEncode(newState.toJson()));

      emit(newState);
    }));

    on<EventInitTestData>((event, emit) {
      var jsonFile = io.File("./test.json");
      var jsonStr = jsonFile.readAsStringSync();
      var json = jsonDecode(jsonStr);

      print(json["ResponseMenu"]["hits"][1]["ingredientLines"]);

      var resMenue = ResponseMenu.fromJsonState(json["ResponseMenu"]);
      // print("/bloc/api.dart:\t" + resMenue.toString());

      // resMenue.hits.forEach((element) => print(element.calories));

      emit(state.setResponseMenue(resMenue));
    });
  }
}
