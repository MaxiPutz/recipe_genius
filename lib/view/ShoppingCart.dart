import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/BlocBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShoppingCart")),
      body: BlocBuilder<BlocBillaShoppingcart, StateBillaShoppingCart>(
        builder: (BuildContext context, state) {
          if (state.articles.isEmpty) {
            return Text("no Articles in the shoppincart");
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Image.network(state.articles[index].articleUrl, height: 250),
                  Text(state.articles[index].articleName),
                  Text(state.articles[index].articleId),
                ],
              );
            },
            itemCount: state.articles.length,
          );
        },
      ),
    );
  }
}
