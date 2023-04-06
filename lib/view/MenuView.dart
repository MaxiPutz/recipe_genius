import 'package:flutter/material.dart';
import 'package:recipe_genius/bloc/RecepieAPI/Response/Menu.dart';
import 'package:recipe_genius/widget/Menu/MenuCard.dart';

class MenuView extends StatelessWidget {
  List<Menu> menus;
  MenuView(this.menus, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: menus.length,
      itemBuilder: (context, index) => MenuCard(menu: menus[index]),
    );
  }
}
