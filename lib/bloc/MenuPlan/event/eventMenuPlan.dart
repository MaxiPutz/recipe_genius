import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

abstract class EventMenuPlan {}

class EventMenuPlanAddIngredient extends EventMenuPlan {
  Ingredient ingredient;
  EventMenuPlanAddIngredient(this.ingredient);
}

class EventMenuPlanAdd extends EventMenuPlan {
  MenuPlan menuPlan;
  String key;
  EventMenuPlanAdd(this.key, this.menuPlan);
}
