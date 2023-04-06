import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/Ingredient/event/EventIngredient.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/IngredientCard/ShoppingProducts.dart.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class IngredientCard extends StatefulWidget {
  Ingredient ingredient;
  int id;
  IngredientCard(this.ingredient, this.id, {super.key});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  final _expandedTileController = ExpandedTileController();

  String name = "";
  String weight = "";
  Ingredient ingredient = Ingredient(name: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _expandedTileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.ingredient.name,
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
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            this.name = value;
                          });
                          this.ingredient.name = value;
                          context.read<BlocIngredient>().add(EventIngredientAdd(
                              widget.id.toString(), this.ingredient));
                        },
                        onSubmitted: (value) =>
                            _expandedTileController.expand(),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Food Name"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        onChanged: (value) {
                          this.ingredient.weight = value;
                          context.read<BlocIngredient>().add(EventIngredientAdd(
                              widget.id.toString(), this.ingredient));
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Food Weight in gramm"),
                      ),
                    ),
                  )
                ],
              ),
              content: ShoppingProductsDart(name),
              controller: _expandedTileController,
              enabled: name.length > 0,
            ),
          )
        ],
      ),
    );
  }
}
