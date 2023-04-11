import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/Ingredient/event/EventIngredient.dart';
import 'package:recipe_genius/bloc/Ingredient/state/StateIngredient.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/IngredientCard/ShoppingProducts.dart.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class IngredientCard extends StatefulWidget {
  IngredientLine ingredientLine;
  Ingredient ingredient;
  int id;
  IngredientCard(
      {required this.ingredientLine,
      required this.id,
      required this.ingredient,
      super.key});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  final _expandedTileController = ExpandedTileController();

  String name = "";
  double weight = 0;
  late Ingredient ingredient;

  late TextEditingController nameTextController;
  late TextEditingController weightTextController;
  late BuildContext _buildContext;

  @override
  void initState() {
    ingredient = widget.ingredient;
    name = ingredient.food;
    weight = ingredient.weight;

    nameTextController = TextEditingController(text: ingredient.food);
    weightTextController =
        TextEditingController(text: ingredient.weight.toStringAsFixed(2));

    nameTextController.addListener(() {
      name = nameTextController.value.text;
    });

    weightTextController.addListener(() {
      var _ingredient = Ingredient(
          food: name,
          weight: weight,
          imageUrl: widget.ingredient.imageUrl,
          measure: widget.ingredient.measure,
          foodId: widget.ingredient.foodId);
      weight = double.tryParse(weightTextController.value.text) ?? 0;
      _buildContext.read<BlocIngredient>().add(EventIngredientEdit(
          widget.id.toString(),
          Ingredient.setInitWeight(
              _ingredient, widget.ingredient.getInitWeight())));
    });

    super.initState();
  }

  @override
  void dispose() {
    _expandedTileController.dispose();
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return BlocListener<BlocIngredient, StateIngredientAdd>(
      listener: (context, state) {
        setState(() {
          weight = state.ingredients[widget.id.toString()]!.weight;
          weightTextController.value = weightTextController.value
              .copyWith(text: weight.toStringAsFixed(2));
        });
        print(weight);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                widget.ingredientLine.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandedTile(
                theme: const ExpandedTileThemeData(),
                title: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: (Colors.white),
                          child: Image.network(
                            widget.ingredient.imageUrl,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: nameTextController,
                          onSubmitted: (value) =>
                              _expandedTileController.expand(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Food Name"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: weightTextController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Food Weight"),
                        ),
                      ),
                    ),
                    Text("gramm"), //widget.ingredient.measure#
                  ],
                ),
                content: ShoppingProductsDart(name),
                controller: _expandedTileController,
                enabled: name.length > 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
