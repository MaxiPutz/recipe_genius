import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/Menu/MenuCard.dart';

class MenuBookView extends StatelessWidget {
  void clearMenuPlan(BuildContext context) {
    context.read<BlocMenuPlan>().add(EventMenuPlanClear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MenuBookView"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              clearMenuPlan(context);
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<BlocMenuPlan, StateMenuPlan>(
          builder: (context, state) {
            var ele = state.menuplans
                .map((key, value) => MapEntry(key, value.menu))
                .values
                .toList();

            return ListView.builder(
              itemBuilder: (context, index) => MenuCard(menu: ele[index]),
              itemCount: ele.length,
            );
          },
        ),
      ),
    );
  }
}
