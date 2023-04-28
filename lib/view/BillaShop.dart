import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/EventBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/state/StateBillaAPI.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:recipe_genius/view/ShoppingCart.dart';
import 'package:recipe_genius/widget/FoodContent/FoodContend.dart';

class BillaShop extends StatelessWidget {
  late Map<String, Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BillaShop"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()));
              },
              icon: Icon(Icons.shopping_cart))
        ],
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
                  FoodContentList(ingredientsList[index]));
        },
      ),
    );
  }
}
