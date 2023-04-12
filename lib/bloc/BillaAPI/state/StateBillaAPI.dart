import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIArticleDetail.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIResponse.dart';

class StateBillaAPI {
  Map<String, BillaAPISearchResponse> data = <String, BillaAPISearchResponse>{};
  Map<String, BillaProduct> dataResult = <String, BillaProduct>{};

  StateBillaAPI();

  StateBillaAPI copy() {
    var newState = StateBillaAPI();
    newState.data = data;
    newState.dataResult = dataResult;
    return newState;
  }

  StateBillaAPI setData(String key, BillaAPISearchResponse res) {
    var newState = copy();
    newState.data[key] = res;

    return newState;
  }

  StateBillaAPI setProductInfo(String key, BillaProduct res) {
    var newState = copy();
    newState.dataResult[key] = res;

    return newState;
  }
}
