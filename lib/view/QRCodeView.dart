import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform/platform.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/BlocBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/platform/platform.dart';

class QRCodeView extends StatelessWidget {
  TextEditingController nameTextController = TextEditingController();

  void sendToBilla(BuildContext context) async {
    print("nameTextController.text");
    print(nameTextController.text);
    print("nameTextController.text");

    var file = (await readFileBaskedId());
    file.writeAsStringSync(nameTextController.text);
    context.read<BlocBillaShoppingCart>().add(EventBillaShoppingCartSend());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Billa basked number")),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: readFileBaskedId(),
                  builder: (context, snapshot) {
                    nameTextController = TextEditingController(
                        text: snapshot.data?.readAsStringSync() ?? "");

                    return TextField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "BaskedId"),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () => sendToBilla(context),
      ),
    );
  }
}
