import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

abstract class EventIngredient {}

class EventIngredientAdd extends EventIngredient {
  String key;
  Ingredient ingredients;
  EventIngredientAdd(this.key, this.ingredients);
}

class EventIngredientNew extends EventIngredient {}
