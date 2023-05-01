import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/BlocBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/state/StateEventBillaShoppingCart.dart';
import 'package:recipe_genius/view/QRCodeView.dart';

class ShoppingCart extends StatelessWidget {
  double totalPrice = 0;

  void toQRCodeView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeView(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBillaShoppingCart, StateBillaShoppingCart>(
      builder: (BuildContext context, state) {
        if (state.articles.isEmpty) {
          return Text("no Articles in the shoppincart");
        }

        state.articles.forEach(
          (element) {
            totalPrice += element.count * element.price;
          },
        );

        return Scaffold(
          appBar: AppBar(
              title: Row(
            children: [
              Expanded(child: Text("ShoppingCart")),
              Expanded(
                  child: Text(
                "Price\t $totalPrice",
                textAlign: TextAlign.end,
              )),
            ],
          )),
          body: ListView.builder(
            itemBuilder: (context, index) {
              totalPrice +=
                  state.articles[index].price * state.articles[index].count;

              return Row(
                children: [
                  Expanded(
                      child: Image.network(state.articles[index].articleUrl,
                          height: 250)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.articles[index].articleName),
                        Text("count\t" +
                            state.articles[index].count.toString() +
                            "\t€"),
                        Text(
                            "total price\t${state.articles[index].price * state.articles[index].count}\t€")
                      ],
                    ),
                  )
                ],
              );
            },
            itemCount: state.articles.length,
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => toQRCodeView(context),
              child: Icon(Icons.shopping_cart_checkout)),
        );
      },
    );
  }
}
