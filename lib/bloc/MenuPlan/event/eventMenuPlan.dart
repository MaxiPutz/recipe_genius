import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

abstract class EventMenuPlan {}

class EventMenuPlanAddIngredient extends EventMenuPlan {
  IngredientLine ingredient;
  EventMenuPlanAddIngredient(this.ingredient);
}

class EventMenuPlanAdd extends EventMenuPlan {
  MenuPlan menuPlan;
  String key;
  EventMenuPlanAdd(this.key, this.menuPlan);
}

class EventMenuPlanInit extends EventMenuPlan {
  StateMenuPlan stateMenuPlan;
  EventMenuPlanInit(this.stateMenuPlan);
}
