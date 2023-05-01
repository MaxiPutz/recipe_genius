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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return BlocListener<BlocIngredient, StateIngredientAdd>(
      listener: (context, state) {
        setState(() {
          weight = state.ingredients[widget.id.toString()]!.weight;
        });
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandedTile(
                theme: const ExpandedTileThemeData(),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            widget.ingredient.imageUrl,
                            height: 50,
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.ingredientLine.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                weight.toStringAsFixed(1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text("grams"))
                        ],
                      ),
                    )
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
      ),
    );
  }
}
