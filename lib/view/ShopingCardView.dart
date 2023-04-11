import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

//big issue in the fiew
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
          List<Ingredient> ingredientsList = [];
          var tmp = state.menuplans.values.map((e) => e.ingredients).toList();

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

          ingredientsList = ingredientMap.values.toList();

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

  FoodContent(this.ingredient);

  @override
  Widget build(BuildContext context) {
    _expandedTileController.expand();
    return ExpandedTile(
      title: Text(ingredient.food),
      controller: _expandedTileController,
      content: Text(ingredient.foodId),
    );
  }
}
