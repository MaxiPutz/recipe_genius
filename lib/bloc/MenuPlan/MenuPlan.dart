import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocMenuPlan extends Bloc<EventMenuPlan, StateMenuPlan> {
  BlocMenuPlan() : super(StateMenuPlan(<String, MenuPlan>{})) {
    on<EventMenuPlanAdd>((event, emit) {
      emit(state.addMenuPlan(event.key, event.menuPlan));
    });
  }
}
