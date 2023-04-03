import 'dart:convert';
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

  @override
  String toString() {
    return hits.map((menu) => menu.toString()).join('\n');
  }
}

class Menu {
  String label;
  String image;
  String url;
  List<Ingredient> ingredients;
  double calories;

  Menu({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['ingredientLines'] as List;
    List<Ingredient> ingredients =
        ingredientsList.map((i) => Ingredient(name: i)).toList();

    return Menu(
      label: json['label'],
      image: json['image'],
      url: json['url'],
      ingredients: ingredients,
      calories: json['calories'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'Recipe: $label\nImage URL: $url\nCalories: $calories\nIngredients: ${ingredients.map((i) => i.toString()).join(', ')}\n';
  }
}

class Ingredient {
  String name;

  Ingredient({required this.name});

  @override
  String toString() {
    return name;
  }
}
