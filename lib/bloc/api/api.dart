import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/api/Response/Menu.dart';
import 'package:recipe_genius/bloc/api/key/EdmamKey.dart';
import 'package:recipe_genius/bloc/api/event/event.dart';
import 'package:recipe_genius/bloc/api/state/Recepie.dart';
import 'package:http/http.dart' as http;

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

      print(res.toString());
      emit(state.setResponseMenue(res));
    }));
  }
}
