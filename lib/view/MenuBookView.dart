import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/Menu/MenuCard.dart';
import 'package:recipe_genius/view/webview/RecepiUrlView.dart';

class MenuBookView extends StatelessWidget {
  late BuildContext context;
  void clearMenuPlan(BuildContext context) {
    context.read<BlocMenuPlan>().add(EventMenuPlanClear());
  }

  void goToUrl(String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewExample(url: url),
        ));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
            var values = state.menuplans
                .map((key, value) => MapEntry(key, value.menu))
                .values
                .toList();

            var keys = state.menuplans
                .map((key, value) => MapEntry(key, value.menu))
                .keys
                .toList();

            return ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  MenuCard(menu: values[index]),
                  ElevatedButton(
                    onPressed: () => goToUrl(keys[index]),
                    child: Text(
                      keys[index].toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              itemCount: values.length,
            );
          },
        ),
      ),
    );
  }
}
