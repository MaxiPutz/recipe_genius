import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/EventBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class ShopingCardView extends StatelessWidget {
  late Map<String, Ingredient> ingredients;

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShoppingCard"),
      ),
      body: BlocBuilder<BlocMenuPlan, StateMenuPlan>(
        builder: (context, state) {
          ingredients = state.getIngridents();

          ingredients.forEach((key, value) {
            print("ShoppinCardView");
            print(value.food);
            context
                .read<BlocBillaAPI>()
                .add(EventBillaAPISearch(value.food, value.foodId, context));
          });

          var ingredientsList = ingredients.values.toList();
          return ListView.builder(
              itemCount: ingredientsList.length,
              itemBuilder: (context, index) =>
                  FoodContent(ingredientsList[index]));
        },
      ),
    );
  }
}

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
                  Text("data"),
              price
            ],
          );
        },
      ),
    );
  }
}
