import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class StateIngredientAdd {
  Map<String, Ingredient> ingredients;
  StateIngredientAdd(this.ingredients);

  StateIngredientAdd copy() {
    var tmp = newState();

    tmp.ingredients = this.ingredients;
    return tmp;
  }

  StateIngredientAdd newState() {
    return StateIngredientAdd(<String, Ingredient>{});
  }

  StateIngredientAdd editIngredient(String key, Ingredient val) {
    var tmp = copy();

    tmp.ingredients[key] = val;

    return tmp;
  }
}
