import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIArticleDetail.dart';
import 'package:recipe_genius/bloc/BillaAPI/response/BillaAPIResponse.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/BlocBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class FoodContentList extends StatelessWidget {
  final _expandedTileController = ExpandedTileController();

  late Ingredient ingredient;

  FoodContentList(this.ingredient, {super.key});

  void initState() {}

  @override
  Widget build(BuildContext context) {
    _expandedTileController.expand();

    return ExpandedTile(
      title: Row(
        children: [
          Image.network(
            ingredient.imageUrl,
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ingredient.food),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${ingredient.weight.ceil()} g"),
          ),
          BlocBuilder<BlocBillaShoppingCart, StateBillaShoppingCart>(
              builder: (context, state) {
            var articles = state.articles
                .where(((element) => element.foodId == ingredient.foodId))
                .toList();

            if (articles.isEmpty) {
              return Text("");
            }

            var price = articles
                .map((e) => e.price * e.count)
                .reduce((value, element) => value + element);

            var weight = articles
                .map((e) => e.getWeight() * e.count)
                .reduce((value, element) => value + element);

            return Column(
              children: [Text("$price\t€"), Text("${weight}")],
            );
          }),
        ],
      ),
      content: BlocBuilder<BlocBillaAPI, StateBillaAPI>(
        builder: (context, state) {
          if (state.data[ingredient.foodId]?.results == null ||
              state.data[ingredient.foodId]!.results.isEmpty) {
            return const Text("not found");
          }

          var results =
              state.data[ingredient.foodId]!.results.map((e) => e).toList();

          var dataResults =
              results.map((ele) => state.dataResult[ele.articleId]).toList();
          var ele = results[0];
          var ele2 = dataResults[0];
          // List<Widget> prices = dataResults
          //         .isNotEmpty // state.dataResult[ele.articleId] != null
          //     ? dataResults
          //         .map((ele) => Text(
          //             "${state.dataResult[ele?.articleId]?.price.normal}\t€"))
          //         .toList() //Text("${state.dataResult[ele.articleId]!.price.normal}\t€")
          //     : const [Text("price not found")];

          List<double> prices = dataResults.isNotEmpty
              ? dataResults
                  .map((ele) =>
                      state.dataResult[ele?.articleId]?.price.normal ?? 0)
                  .toList()
              : [0];

          final ScrollController controller = ScrollController();

          return SizedBox(
            height: 150,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollBehavior: MyCustomScrollBehavior(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => FoodContend(
                          foodId: ingredient.foodId,
                          dataResult: dataResults[index],
                          price: prices[index],
                          result: results[index]),
                      childCount:
                          dataResults.length > 4 ? 4 : dataResults.length,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      controller: _expandedTileController,
    );
  }
}

class FoodContend extends StatefulWidget {
  BillaProduct? dataResult;
  BillaAPISearchResult result;
  double price;
  String foodId;

  FoodContend(
      {super.key,
      required this.dataResult,
      required this.price,
      required this.result,
      required this.foodId});

  @override
  State<FoodContend> createState() => _FoodContendState();
}

class _FoodContendState extends State<FoodContend> {
  int count = 0;

  void addArticle(BuildContext context) {
    setState(() {
      count++;
    });
    context.read<BlocBillaShoppingCart>().add(EventBillaShoppingCartAdd(Article(
        articleName: widget.dataResult!.name,
        articleUrl: widget.result.images[0],
        articleId: widget.dataResult!.articleId,
        foodId: widget.foodId,
        price: widget.price,
        weightStr: widget.dataResult!.grammage,
        count: 1)));
  }

  void removeArticle(BuildContext context) {
    if (count == 0) {
      return;
    }
    setState(() {
      count--;
    });
    context.read<BlocBillaShoppingCart>().add(EventBillaShoppingCartRemove(
        Article(
            articleName: widget.dataResult!.name,
            articleUrl: widget.result.images[0],
            articleId: widget.dataResult!.articleId,
            foodId: widget.foodId,
            price: widget.price,
            weightStr: widget.dataResult!.grammage,
            count: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Column(
            children: [
              Text(widget.dataResult?.name ?? "load",
                  overflow: TextOverflow.ellipsis),
              Text(widget.dataResult?.grammage ?? "load"),
              Text(widget.dataResult?.price.unit ?? "load"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.price}"),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        addArticle(context);
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      splashColor: Colors.amber,
                      focusColor: Colors.blueGrey,
                      onPressed: () {
                        removeArticle(context);
                      },
                      icon: const Icon(Icons.remove)),
                ],
              )
            ],
          ),
        ),
        Stack(
          children: [
            Image.network(
                  widget.result.images[0],
                  height: 150,
                ) ??
                const Text("data"),
            Text(count.toString()),
          ],
        ),
      ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
