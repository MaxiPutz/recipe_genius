import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class StateMenuPlan {
  Map<String, MenuPlan> menuplans;
  StateMenuPlan(this.menuplans);

  StateMenuPlan copy() {
    var newState = StateMenuPlan(menuplans);
    return newState;
  }

  StateMenuPlan addMenuPlan(String key, MenuPlan menuPlan) {
    var newState = copy();
    newState.menuplans[key] = menuPlan;
    return newState;
  }
}

class MenuPlan {
  List<Ingredient> ingredients;
  Menu menu;
  MenuPlan(this.menu, this.ingredients);
}
