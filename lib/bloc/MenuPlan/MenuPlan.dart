import 'dart:convert';

import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' as io;

import 'package:recipe_genius/platform/platform.dart';

class BlocMenuPlan extends Bloc<EventMenuPlan, StateMenuPlan> {
  BlocMenuPlan()
      : super(StateMenuPlan(<String, MenuPlan>{}, <String, double>{})) {
    on<EventMenuPlanAdd>((event, emit) async {
      var tmp = state.addMenuPlan(event.key, event.menuPlan, event.servings);
      emit(tmp);
      var file = await readFileMenuPlanJson();

      var encoder = const JsonEncoder.withIndent("    ");
      file.writeAsStringSync(encoder.convert(tmp));
    });
    on<EventMenuPlanInit>(
      (event, emit) => emit(event.stateMenuPlan.copy()),
    );
    on<EventMenuPlanClear>((event, emit) async {
      var tmp = state.clearMenuPlan();
      emit(tmp);
      var file = await readFileMenuPlanJson();

      var encoder = const JsonEncoder.withIndent("    ");
      file.writeAsStringSync(encoder.convert(tmp));
    });
  }
}
