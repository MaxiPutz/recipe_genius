import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';

class BlocBillaShoppingcart
    extends Bloc<EventBillaShoppingCart, StateBillaShoppingCart> {
  BlocBillaShoppingcart() : super(StateBillaShoppingCart()) {
    on<EventBillaShoppingCartAdd>(
        (event, emit) => emit(state.addArticle(event.article)));
    on<EventBillaShoppingCartRemove>(
      (event, emit) => emit(state.removeArticle(event.article)),
    );
  }
}
