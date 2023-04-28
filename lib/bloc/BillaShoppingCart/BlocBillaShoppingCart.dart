import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/EventBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';
import 'package:http/http.dart' as http;

class BlocBillaShoppingCart
    extends Bloc<EventBillaShoppingCart, StateBillaShoppingCart> {
  BlocBillaShoppingCart() : super(StateBillaShoppingCart()) {
    on<EventBillaShoppingCartAdd>(
        (event, emit) => emit(state.addArticle(event.article)));
    on<EventBillaShoppingCartRemove>(
      (event, emit) => emit(state.removeArticle(event.article)),
    );
    on<EventBillaShoppingCartSend>((event, emit) {
      var future = <Future<PostBilla>>[];
      var posts = state.articles
          .map((ele) => EventBillaAPIAddToBascet(
              articleId: ele.articleId, quantity: ele.count))
          .map((e) => e.getPostRequest())
          .toList();

      future.addAll(posts);

      (() async {
        var postReq = await Future.wait(future);
        postReq.forEach((element) {
          print(element);
          print(element.body);
          print(element.headers);
          print(element.uri);
          http.post(element.uri, body: element.body, headers: element.headers);
        });
      })();

      emit(state.copy());
    });
  }
}
