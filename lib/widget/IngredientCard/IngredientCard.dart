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

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Image.network(
                  widget.ingredient.imageUrl,
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.ingredientLine.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandedTile(
              theme: const ExpandedTileThemeData(),
              title: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("gramm"), //widget.ingredient.measure#
                ],
              ),
              content: ShoppingProductsDart(
                  ingredient: widget.ingredient, id: widget.id),
              controller: _expandedTileController,
              enabled: true,
            ),
          )
        ],
      ),
    );
  }
}
