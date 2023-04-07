import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

abstract class EventIngredient {}

class EventIngredientEdit extends EventIngredient {
  String key;
  Ingredient ingredients;
  EventIngredientEdit(this.key, this.ingredients);
}

class EventIngredientAdd extends EventIngredient {
  String key;
  Ingredient ingredients;
  EventIngredientAdd(this.key, this.ingredients);
}

class EventIngredientNew extends EventIngredient {
  List<Ingredient> ingredients;
  EventIngredientNew(this.ingredients);
}

class EventIngredientScaleQuntity extends EventIngredient {
  double scale;
  EventIngredientScaleQuntity(this.scale);
}
