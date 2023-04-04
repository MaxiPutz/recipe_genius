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

  factory Menu.fromJsonState(Map<String, dynamic> json) {
    print("this is a function");
    var ingredientsList = json['ingredientLines'] as List;

    print(ingredientsList);
    List<Ingredient> ingredients =
        ingredientsList.map((i) => Ingredient.fromJsonState(i)).toList();

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

  Map<String, dynamic> toJson() => {
        'label': label,
        'image': image,
        'url': url,
        'ingredientLines': ingredients.map((i) => i.toJson()).toList(),
        'calories': calories,
      };
}

class Ingredient {
  String name;

  Ingredient({required this.name});

  factory Ingredient.fromJsonState(Map<String, dynamic> json) {
    return Ingredient(name: json["name"]);
  }

  @override
  String toString() {
    return name;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
