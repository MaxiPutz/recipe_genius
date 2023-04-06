import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/Ingredient/state/StateIngredient.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/IngredientCard/IngredientCard.dart';

class IngredientView extends StatefulWidget {
  Menu menu;
  IngredientView(this.menu);

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  var ingredients = <String, Ingredient>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BlocIngredient, StateIngredientAdd>(
        listener: (context, state) {
          print("from view in blocListener");
          ingredients = state.ingredients;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Ingredient"),
              pinned: false,
              expandedHeight: 450,
              flexibleSpace: Image(
                image: Image.network(widget.menu.image).image,
                fit: BoxFit.fitWidth,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        IngredientCard(widget.menu.ingredients[index], index),
                    childCount: widget.menu.ingredients.length))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<BlocMenuPlan>().add(EventMenuPlanAdd(
              "key", MenuPlan(widget.menu, ingredients.values.toList()))),
          child: Icon(Icons.add)),
    );
  }
}
