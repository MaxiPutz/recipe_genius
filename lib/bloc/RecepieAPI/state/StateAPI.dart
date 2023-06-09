import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/bloc/RecepieAPI/key/EdmamKey.dart';

class StateAPI {
  late APIKey recepieKey;
  ResponseMenu? responseMenu;

  StateAPI() {
    recepieKey = APIKey();
  }

  StateAPI copyStateAPI() {
    var newAPIState = StateAPI();
    newAPIState.recepieKey = recepieKey;
    newAPIState.responseMenu = responseMenu;

    return newAPIState;
  }

  StateAPI setRecepieKey(APIKey recepieKey) {
    var newApiState = copyStateAPI();

    newApiState.recepieKey = recepieKey;
    return newApiState;
  }

  StateAPI setResponseMenue(ResponseMenu responseMenu) {
    var newApiState = copyStateAPI();
    newApiState.responseMenu = responseMenu;
    return newApiState;
  }

  Map<String, dynamic> toJson() => {
        'APIKey': recepieKey.toJson(),
        'ResponseMenu': responseMenu?.toJson(),
      };
}
