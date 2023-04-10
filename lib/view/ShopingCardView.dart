import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class ShopingCardView extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShoppingCard"),
      ),
      body: BlocBuilder<BlocMenuPlan, StateMenuPlan>(
        builder: (context, state) {
          print(state.menuplans.values.toList());
          List<Ingredient> ingredients = [];
          var tmp = state.menuplans.values.map((e) => e.ingredients).toList();

          for (int i = 0; i < tmp.length; i++) {
            ingredients.addAll(tmp[i]);
          }

          return ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) => FoodContent(ingredients[index]));
        },
      ),
    );
  }
}

class FoodContent extends StatelessWidget {
  final _expandedTileController = ExpandedTileController();
  Ingredient ingredient;

  FoodContent(this.ingredient);

  @override
  Widget build(BuildContext context) {
    _expandedTileController.expand();
    return ExpandedTile(
      title: Text(ingredient.food),
      controller: _expandedTileController,
      content: Text(ingredient.food),
    );
  }
}
