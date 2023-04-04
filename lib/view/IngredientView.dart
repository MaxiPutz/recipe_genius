import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/api/Response/Menu.dart';
import 'package:recipe_genius/widget/IngredientCard/IngredientCard.dart';

class IngredientView extends StatefulWidget {
  Menu menu;
  IngredientView(this.menu);

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    IngredientCard(widget.menu.ingredients[index]),
                childCount: widget.menu.ingredients.length))
      ],
    );
  }
}
