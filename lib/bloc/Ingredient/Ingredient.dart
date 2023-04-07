import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/event/EventIngredient.dart';
import 'package:recipe_genius/bloc/Ingredient/state/StateIngredient.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';

class BlocIngredient extends Bloc<EventIngredient, StateIngredientAdd> {
  BlocIngredient() : super(StateIngredientAdd(<String, Ingredient>{})) {
    on<EventIngredientEdit>((event, emit) {
      state.ingredients.entries.forEach((element) {
        print(element.value.food);
        print(element.value.weight);
      });
      emit(state.editIngredient(event.key, event.ingredients));
    });
    on<EventIngredientAdd>((event, emit) {
      state.editIngredient(event.key, event.ingredients);
    });

    on<EventIngredientNew>(
      (event, emit) => emit(state.initIngredients(event.ingredients)),
    );
    on<EventIngredientScaleQuntity>(
      (event, emit) => emit(state.scaleQuantity(event.scale)),
    );
  }
}
