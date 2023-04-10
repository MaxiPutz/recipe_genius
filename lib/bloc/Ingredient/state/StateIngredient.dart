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

  StateIngredientAdd initIngredients(List<Ingredient> ingredients) {
    var temp = newState();

    for (var i = 0; i < ingredients.length; i++) {
      final ele = ingredients[i];
      temp.ingredients[i.toString()] = ele;
    }
    return temp;
  }

  StateIngredientAdd scaleQuantity(double val) {
    print(val);
    var tmp = newState();
    tmp.ingredients = ingredients;

    ingredients.forEach((key, value) {
      tmp.ingredients[key]!.weight = value.getInitWeight() * val;
    });

    return tmp;
  }
}
