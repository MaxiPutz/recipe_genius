import 'dart:convert';

import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' as io;

class BlocMenuPlan extends Bloc<EventMenuPlan, StateMenuPlan> {
  BlocMenuPlan() : super(StateMenuPlan(<String, MenuPlan>{})) {
    on<EventMenuPlanAdd>((event, emit) {
      var tmp = state.addMenuPlan(event.key, event.menuPlan);
      emit(tmp);
      var file = io.File("./MenuPlan.json");

      var encoder = const JsonEncoder.withIndent("    ");
      file.writeAsStringSync(encoder.convert(tmp));
    });

    on<EventMenuPlanInit>(
      (event, emit) => emit(event.stateMenuPlan.copy()),
    );
  }
}
