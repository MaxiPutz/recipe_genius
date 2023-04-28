import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'dart:io';

class StateMenuPlan {
  Map<String, MenuPlan> menuplans;
  StateMenuPlan(this.menuplans);

  StateMenuPlan copy() {
    var newState = StateMenuPlan(menuplans);
    return newState;
  }

  StateMenuPlan clearMenuPlan() {
    var newState = copy();
    newState.menuplans = <String, MenuPlan>{};

    return newState;
  }

  StateMenuPlan addMenuPlan(String key, MenuPlan menuPlan) {
    var newState = copy();
    newState.menuplans[key] = menuPlan;

    return newState;
  }

  Map<String, Ingredient> getIngridents() {
    menuplans.values.toList();
    List<Ingredient> ingredientsList = [];
    var tmp = menuplans.values.map((e) => e.ingredients).toList();

    for (int i = 0; i < tmp.length; i++) {
      ingredientsList.addAll(tmp[i]);
    }

    Map<String, Ingredient> ingredientMap = <String, Ingredient>{};

    ingredientsList.forEach((element) {
      if (ingredientMap[element.foodId] != null) {
        print(element.weight);
        ingredientMap[element.foodId]!.weight += element.weight;
      } else {
        ingredientMap[element.foodId] = element;
      }
    });

    return ingredientMap;
  }

  factory StateMenuPlan.fromJson(Map<String, dynamic> json) {
    Map<String, MenuPlan> menuplansMap = {};

    menuplansMap = (json["menuplans"] as Map<String, dynamic>)
        .map<String, MenuPlan>((key, value) {
      return MapEntry(key, MenuPlan.fromJson(value));
    });

    return StateMenuPlan(menuplansMap);
  }

  Map<String, dynamic> toJson() {
    var val = menuplans
        .map<String, dynamic>((key, value) => MapEntry(key, value.toJson()));

    return {
      "menuplans": val,
    };
  }
}

class MenuPlan {
  List<Ingredient> ingredients;
  Menu menu;
  MenuPlan(this.menu, this.ingredients);

  Map<String, dynamic> toJson() => {
        "ingredients": ingredients.map((e) => e.toJson()).toList(),
        "menu": menu.toJson()
      };

  factory MenuPlan.fromJson(Map<String, dynamic> json) {
    var tmp = (json["ingredients"] as List)
        .map((ele) => Ingredient.fromJson(ele))
        .toList();

    return MenuPlan(Menu.fromJsonState(json["menu"]), tmp);
  }
}
