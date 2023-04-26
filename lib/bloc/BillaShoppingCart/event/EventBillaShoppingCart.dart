import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';

abstract class EventBillaShoppingCart {}

class EventBillaShoppingCartAdd extends EventBillaShoppingCart {
  Article article;
  EventBillaShoppingCartAdd(this.article);
}

class EventBillaShoppingCartRemove extends EventBillaShoppingCart {
  Article article;
  EventBillaShoppingCartRemove(this.article);
}
