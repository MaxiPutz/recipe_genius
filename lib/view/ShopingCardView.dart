import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';

class ShopingCardView extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShoppingCard"),
      ),
      body: BlocBuilder<BlocMenuPlan, StateMenuPlan>(
        builder: (context, state) => Container(),
      ),
    );
  }
}
