import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class FoodContent extends StatelessWidget {
  final _expandedTileController = ExpandedTileController();
  Ingredient ingredient;

  FoodContent(this.ingredient, {super.key});

  void initState() {}

  @override
  Widget build(BuildContext context) {
    _expandedTileController.expand();
    return ExpandedTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ingredient.food),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${ingredient.weight} g"),
          )
        ],
      ),
      controller: _expandedTileController,
      content: BlocBuilder<BlocBillaAPI, StateBillaAPI>(
        builder: (context, state) {
          if (state.data[ingredient.foodId]?.results == null ||
              state.data[ingredient.foodId]!.results.isEmpty) {
            return const Text("not found");
          }

          var ele = state.data[ingredient.foodId]!.results[0];
          var ele2 = state.dataResult[ele.articleId];

          Widget price = state.dataResult[ele.articleId] != null
              ? Text("${state.dataResult[ele.articleId]!.price.normal}\t€")
              : const Text("price not found");

          print("ShopingCardView");
          print(state.data[ingredient.foodId]!.results.length);
          print(state.data[ingredient.foodId]!.results);

          return Row(
            children: [
              Column(children: [
                Text(ele2?.name ?? "load"),
                Text(ele2?.grammage ?? "load"),
                Text(ele2?.price.unit ?? "load"),
              ]),
              Image.network(
                    ele.images[0],
                    height: 150,
                  ) ??
                  const Text("data"),
              price
            ],
          );
        },
      ),
    );
  }
}

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
            child: Text("${ingredient.weight} g"),
          )
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
          List<Widget> prices = dataResults
                  .isNotEmpty // state.dataResult[ele.articleId] != null
              ? dataResults
                  .map((ele) => Text(
                      "${state.dataResult[ele?.articleId]?.price.normal}\t€"))
                  .toList() //Text("${state.dataResult[ele.articleId]!.price.normal}\t€")
              : const [Text("price not found")];

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
                      (context, index) => Row(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(dataResults[index]?.name ?? "load",
                                    overflow: TextOverflow.ellipsis),
                                Text(dataResults[index]?.grammage ?? "load"),
                                Text(dataResults[index]?.price.unit ?? "load"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: prices[index],
                                ),
                              ],
                            ),
                          ),
                          Image.network(
                                results[index].images[0],
                                height: 150,
                              ) ??
                              const Text("data"),
                        ],
                      ),
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

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
