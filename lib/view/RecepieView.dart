import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translator/google_translator.dart';
import 'package:recipe_genius/bloc/BillaAPI/BlocBillaAPI.dart';
import 'package:recipe_genius/bloc/BillaAPI/event/EventBillaAPI.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/event/eventMenuPlan.dart';
import 'package:recipe_genius/bloc/MenuPlan/state/StateMenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/RecepieAPI.dart';
import 'package:recipe_genius/bloc/RecepieAPI/event/event.dart';
import 'package:recipe_genius/bloc/RecepieAPI/state/StateAPI.dart';
import 'package:recipe_genius/platform/platform.dart';
import 'package:recipe_genius/translation/GoogleTranslator.dart';
import 'package:recipe_genius/view/MenuView.dart';
import 'package:recipe_genius/view/BillaShop.dart';
import 'dart:io' as io;

class RecepieView extends StatefulWidget {
  const RecepieView({super.key, required this.title});

  final String title;

  @override
  State<RecepieView> createState() => _RecepieViewState();
}

class _RecepieViewState extends State<RecepieView> {
  void toolBarAction(BuildContext context) {
    context.read<BlocBillaAPI>().add(EventBillaAPISearch(
        "spinach", "food_aoceuc6bshdej1bbsdammbnj6l6o", context));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BillaShop()));
  }

  void floatingActionButton(BuildContext context) {
    context.read<BlocAPI>().add(EventFindRecepies("spinach"));
  }

  @override
  void initState() {
    (() async {
      final val = await translateFromEnToDe("creamed spinach");
      print("tranllate");
      print(val);
      print("translate end");
    })();

    context.read<BlocAPI>().add(EventInitTestData());
    readFileMenuPlanJson().then((file) {
      var json = file.readAsStringSync();
      StateMenuPlan plan = StateMenuPlan.fromJson(jsonDecode(json));
      context.read<BlocMenuPlan>().add(EventMenuPlanInit(plan));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => toolBarAction(context),
              icon: const Icon(Icons.shop)),
        ],
      ),
      body: BlocBuilder<BlocAPI, StateAPI>(builder: (context, data) {
        if (data.responseMenu != null) {
          if (data.responseMenu?.hits != null) {
            data.responseMenu?.hits.forEach((element) {
              var temp = element.image;
            });
            return MenuView(data.responseMenu!.hits);
          }
        }

        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => floatingActionButton(context),
      ),
    );
  }
}
