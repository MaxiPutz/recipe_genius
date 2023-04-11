import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ResponseMenu> getMenuData(Uri uri) async {
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
    return ResponseMenu.fromJson(data);
  } else {
    throw Exception("Error: Could not retrieve recipe data.");
  }
}

class ResponseMenu {
  List<Menu> hits;

  ResponseMenu({required this.hits});

  factory ResponseMenu.fromJson(Map<String, dynamic> json) {
    var hitsList = json['hits'] as List;
    List<Menu> menuList =
        hitsList.map((i) => Menu.fromJson(i['recipe'])).toList();

    return ResponseMenu(hits: menuList);
  }

  factory ResponseMenu.fromJsonState(Map<String, dynamic> json) {
    var hitsList = json['hits'] as List;

    List<Menu> menuList = hitsList.map((i) => Menu.fromJsonState(i)).toList();

    return ResponseMenu(hits: menuList);
  }

  @override
  String toString() {
    return hits.map((menu) => menu.toString()).join('\n');
  }

  Map<String, dynamic> toJson() => {
        'hits': hits.map((menu) => menu.toJson()).toList(),
      };
}

class Menu {
  // String foodId; // in response  foodId: food_aq6acefaz2zqp1anqb7iiatc27q6,
  double servings;
  String label;
  String image;
  String url;
  List<IngredientLine> ingredientLine;
  List<Ingredient> ingredients;
  double calories;

  Menu(
      {required this.label,
      required this.image,
      required this.url,
      required this.ingredientLine,
      required this.calories,
      required this.servings,
      required this.ingredients});

  factory Menu.fromJson(Map<String, dynamic> json) {
    var ingredientsLineList = json['ingredientLines'] as List;
    var ingredientsList = json["ingredients"] as List;

    List<IngredientLine> ingredientLine =
        ingredientsLineList.map((i) => IngredientLine(name: i)).toList();

    print("");
    print("");
    print("");
    print("");
    print("");

    print(ingredientsList);
    print(json["food"]);
    List<Ingredient> ingredients = ingredientsList
        .map((ele) => Ingredient(
            measure: ele["measure"] ?? "Null",
            food: ele["food"] ?? (ele["name"] ?? "not found"),
            weight: (ele["weight"] ?? ele["quantity"] ?? 0),
            imageUrl: ele["image"],
            foodId: ele["foodId"]))
        .toList();

    return Menu(
        label: json['label'],
        image: json['image'],
        url: json['url'],
        ingredientLine: ingredientLine,
        calories: json['calories'],
        servings: json['yield'],
        ingredients: ingredients);
  }

  factory Menu.fromJsonState(Map<String, dynamic> json) {
    print("this is a function");
    var ingredientLineList = json['ingredientLines'] as List;
    var ingredientList = json["ingredients"] as List;

    print(ingredientLineList);
    List<IngredientLine> ingredientLine =
        ingredientLineList.map((i) => IngredientLine.fromJsonState(i)).toList();

    List<Ingredient> ingredients =
        ingredientList.map((i) => Ingredient.fromJsonState(i)).toList();

    return Menu(
        label: json['label'],
        image: json['image'],
        url: json['url'],
        ingredientLine: ingredientLine,
        ingredients: ingredients,
        calories: json['calories'],
        servings: json["yield"]);
  }

  @override
  String toString() {
    return 'Recipe: $label\nImage URL: $url\nCalories: $calories\nIngredients: ${ingredientLine.map((i) => i.toString()).join(', ')}\n';
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'image': image,
        'url': url,
        'ingredientLines': ingredientLine.map((i) => i.toJson()).toList(),
        "ingredients": ingredients.map((e) => e.toJson()).toList(),
        'calories': calories,
        'yield': servings
      };
}

class IngredientLine {
  String name;

  IngredientLine({required this.name});

  factory IngredientLine.fromJsonState(Map<String, dynamic> json) {
    var tmp = IngredientLine(name: json["name"]);

    return tmp;
  }

  @override
  String toString() {
    return name;
  }

  Map<String, dynamic> toJson() => {'name': name};
}

class Ingredient {
  String food;
  double weight;
  String imageUrl;
  String measure; // in response measure: gram,
  String foodId;
  late double _initWeight;

  double getInitWeight() => this._initWeight;
  Ingredient(
      {required this.food,
      required this.weight,
      required this.imageUrl,
      required this.measure,
      required this.foodId}) {
    _initWeight = this.weight;
  }

  factory Ingredient.setInitWeight(Ingredient ingredient, double initWeight) {
    var newIngredient = Ingredient(
        food: ingredient.food,
        weight: ingredient.weight,
        imageUrl: ingredient.imageUrl,
        measure: ingredient.measure,
        foodId: ingredient.foodId);

    newIngredient._initWeight = initWeight;
    return newIngredient;
  }

  Ingredient copy() {
    return Ingredient(
        food: food,
        imageUrl: imageUrl,
        weight: weight,
        measure: measure,
        foodId: foodId);
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
        food: json["food"],
        weight: json["weight"],
        imageUrl: json["image"],
        measure: json["measure"],
        foodId: json["foodId"]);
  }

  factory Ingredient.fromJsonState(Map<String, dynamic> json) {
    return Ingredient(
        food: json["food"],
        weight: json["weight"],
        imageUrl: json["image"],
        measure: json["measure"],
        foodId: json["foodId"]);
  }

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "food": food,
        "image": imageUrl,
        "measure": measure,
        "foodId": foodId
      };
}
