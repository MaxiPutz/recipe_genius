import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/Ingredient/event/EventIngredient.dart';
import 'package:recipe_genius/bloc/Ingredient/state/StateIngredient.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/IngredientCard/IngredientCard.dart';

class IngredientView extends StatefulWidget {
  Menu menu;
  IngredientView(this.menu) {}

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  // monkey test in plus minus butten issue
  var ingredients = <String, Ingredient>{};

  late double selectedServings;

  @override
  void initState() {
    selectedServings = widget.menu.servings;
    ingredients = widget.menu.ingredients.asMap().map<String, Ingredient>(
        (key, value) => MapEntry(key.toString(), value));
    super.initState();
  }

  void scaleServingsUp(BuildContext context) {
    setState(() {
      selectedServings++;
    });
    context.read<BlocIngredient>().add(
        // the state is in bloc false if you press more then 1 time
        EventIngredientScaleQuntity(selectedServings / widget.menu.servings));
  }

  void scaleServingsDown(BuildContext context) {
    if (selectedServings <= 1) {
      return;
    }
    setState(() {
      selectedServings--;
    });
    context.read<BlocIngredient>().add(
        EventIngredientScaleQuntity(selectedServings / widget.menu.servings));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BlocIngredient, StateIngredientAdd>(
        listener: (context, state) {
          print(state.ingredients);
          setState(() {
            ingredients = state.ingredients;
          });
          state.ingredients.values.toList().forEach((element) {
            print(element);
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Ingredient"),
              pinned: false,
              expandedHeight: 450,
              flexibleSpace: Image(
                image: Image.network(widget.menu.image).image,
                fit: BoxFit.fitWidth,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Servings:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedServings.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () => scaleServingsUp(context),
                          icon: const Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () => scaleServingsDown(context),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ),
                childCount: 1,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => IngredientCard(
                        ingredient: widget.menu.ingredients[index],
                        ingredientLine: widget.menu.ingredientLine[index],
                        id: index),
                    childCount: widget.menu.ingredientLine.length))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("ingrediensts bevor bloc");
            print(ingredients.values.toList().length);
            context.read<BlocMenuPlan>().add(EventMenuPlanAdd(
                "key007", MenuPlan(widget.menu, ingredients.values.toList())));
          },
          child: const Icon(Icons.add)),
    );
  }
}
