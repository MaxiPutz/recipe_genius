import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/api/Response/Menu.dart';

class IngredientCard extends StatelessWidget {
  Ingredient ingredient;
  IngredientCard(this.ingredient, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              ingredient.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () => print("dere"),
                      icon: const Icon(Icons.arrow_drop_down)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Food Name"),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Food Weight in gramm"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
