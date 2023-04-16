import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/Ingredient/event/EventIngredient.dart';
import 'package:recipe_genius/bloc/Ingredient/state/StateIngredient.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class ShoppingProductsDart extends StatefulWidget {
  Ingredient ingredient;
  int id;
  ShoppingProductsDart({super.key, required this.ingredient, required this.id});

  @override
  State<ShoppingProductsDart> createState() => _ShoppingProductsDartState();
}

class _ShoppingProductsDartState extends State<ShoppingProductsDart> {
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
      print(weight);
      print("in listener");
      _buildContext.read<BlocIngredient>().add(EventIngredientEdit(
          widget.id.toString(),
          Ingredient.setInitWeight(_ingredient, widget.ingredient.weight)));
    });

    super.initState();
  }

  @override
  void dispose() {
    weightTextController.dispose();
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      _buildContext = context;
      return BlocListener<BlocIngredient, StateIngredientAdd>(
        listener: (context, state) {
          setState(() {
            weight = state.ingredients[widget.id.toString()]!.weight;
            weightTextController.value = weightTextController.value
                .copyWith(text: weight.toStringAsFixed(2));
          });
          print(weight);
          print("state weight setstate");
        },
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Food Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: weightTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Food Weight"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
