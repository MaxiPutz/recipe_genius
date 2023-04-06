import 'package:flutter/material.dart';

class ShoppingProductsDart extends StatelessWidget {
  String productName;

  ShoppingProductsDart(this.productName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productName);
    return Column(
      children: [
        Text(productName),
      ],
    );
  }
}
