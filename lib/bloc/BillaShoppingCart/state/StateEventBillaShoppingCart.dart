import 'package:collection/collection.dart';

class StateBillaShoppingCart {
  List<Article> articles = [];
  StateBillaShoppingCart();

  StateBillaShoppingCart copy() {
    var newState = StateBillaShoppingCart();
    newState.articles = articles.map((e) => e).toList();
    return newState;
  }

  StateBillaShoppingCart addArticle(Article article) {
    var newState = copy();
    print(newState.articles.length);
    print("add");
    var oldEle = articles.firstWhereOrNull((element) =>
        element.articleId == article.articleId &&
        element.foodId == article.foodId);

    if (oldEle == null) {
      newState.articles.add(article);
      return newState;
    }

    oldEle.count++;
    return newState;
  }

  StateBillaShoppingCart removeArticle(Article article) {
    var newState = copy();
    print(newState.articles.length);
    print("remove");
    var oldEle = articles.firstWhereOrNull((element) =>
        element.articleId == article.articleId &&
        element.foodId == article.foodId);

    if (oldEle == null) {
      oldEle;
      return newState;
    } else if (oldEle.count == 1) {
      var updateList = articles
          .whereNot((element) =>
              element.articleId == article.articleId &&
              element.foodId == article.foodId)
          .toList();
      newState.articles = updateList;
      return newState;
    }

    oldEle.count--;
    return newState;
  }
}

class Article {
  String articleId;
  String foodId;
  String articleName;
  String articleUrl;
  double price;
  String weightStr;
  int count;

  Article(
      {required this.articleId,
      required this.foodId,
      required this.price,
      required this.weightStr,
      required this.count,
      required this.articleName,
      required this.articleUrl});

  double getWeight() {
    final parts = weightStr.split(" ");

    double factor = unitFactors[parts[1].toLowerCase()] ?? 0;

    final weight = (double.tryParse(parts[0]) ?? 0) * factor;

    return weight;
  }
}

final unitFactors = <String, double>{
  'gramm': 1,
  'gram': 1,
  'milliliter': 1,
  'millilitre': 1,
  'liter': 1000,
  'litre': 1000,
  'g': 1,
  'kg': 1000,
  'kilogramm': 1000,
  'kilogram': 1000,
  'packung': 0,
  'becher': 0,
  'unit': 0,
};
