import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/Ingredient/Ingredient.dart';
import 'package:recipe_genius/bloc/MenuPlan/MenuPlan.dart';
import 'package:recipe_genius/bloc/RecepieAPI/RecepieAPI.dart';
import 'package:recipe_genius/bloc/RecepieAPI/state/StateAPI.dart';
import 'package:recipe_genius/view/MenuView.dart';
import 'package:recipe_genius/view/ShopingCardView.dart';

import 'package:recipe_genius/widget/IngredientCard/ShoppingProducts.dart.dart';
import 'bloc/AppBlocObserver.dart';
import 'package:recipe_genius/bloc/RecepieAPI/event/event.dart';

const String imgURL =
    "RX-Amz-Security-Token=IQoJb3JpZ2luX2VjEOn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQCwuZTylREhEryQgdc5CxzIyhnhr5yXOVHO1RDIRkqiSwIhAM2lvk4dW7yxHAzzgubD%2BB03q8TuVrza8JZqyjSshfAXKsIFCML%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyi1xG35xCxuInsO%2BYqlgVwLAdElNyijkjMZEAUWg0pjvw84L8VwTuXbBxLd3HhnsAvCOwBy8sVWWR2KUYqTrGiVezgcWQ%2FUz00VoSdTOn5kWdUt0im7kRSm8G9o330R2DFQAtRNGlV29w83qW3CC%2F70p4W1SSWClbu9bvhmIdm9qDt4HzsApVBHCnU0y%2B0mVNMPRzs6qNbY9w7cHTnl%2Bxd8LU2ulROizmHjkOOJVwH6oldPvkDj%2FJv8QrIFUbvWIBvyXHlLpIAh9Elg7MRlCI4oFR7VtVYz9sm0oJT69X4esCfcrYM10yEOQedBgETp0%2BpoDgzD7M6bo9DGZRrJivESDgq%2BIKixhsnjguNTKnq%2BJ8DoPBfQh9aQvCitwpdbOkCx0jracwng35fcrX%2BjLo%2Bhn%2Fu1qLMwQVpAzcRlghcEjDweEgRLbHR%2Bz8Goa0a%2F%2FvJeClJK1aNSNGmEKygg2wWPxn41MDt0BsQFPP4vq9yeiujG9R%2FlFNSECiZCl20nMg%2Bn1oA0UlE4bneWeONOrWOdiPcgvYbAOANoAfbbsqIcErFTR5w4yRjtTO2kR5ZgJPOtKxaLxaAFRACzmYz3Vixo9H8LWpEaCqb%2FUFiO%2FVnYyQC%2BrM7mHMRQM%2BgP9oTDl%2Fwma7GMxA71BBggyiD8naaFVjAEr67qr1c8owhku5lb8kBZeV%2FdC0UUUxA3wU4VuS04t2X%2FIZTtbvMAGEJfM%2BTP6DTIcYgpefLRlRGZqplo%2F8d054T0OJ2jh%2Bg7hcm3nvX%2BMSev2Oo6AKoQZ0DloXs8go7zHA%2BZpOHu%2B32Hhi%2Bq%2F7Yi%2BKC%2BkQubZUUIAZiG4dtOIqpSs5swjllfW5r%2Fdq9xnwnUiNGoxW%2BdeJMQbxh9hCmhbJCWsrmgsOTWY1vSkwoH5CmFDCb6qahBjqwAQV7Wk22B%2BhSvr129cxXHG0pCS2ZMuNRq9L9wQZByxyMRJbuZaQC4pa8qEU5A2qy3kp3Agf8UUAnPPW8G4d3o0XzYgB1Ojjo%2B63FDFttL8JSTN%2F%2B7kh8s8x7XJacVnNs%2F5xWsJ4wZmIR1KTXNhahhK4BR9js304kocICrVuXfr61OibfAnQEf66rym%2BiR4VbkbUVhEwIUuAAAXV93pk%2BQcy0kU0YJl41LcqCzJW51aAC&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230402T174320Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=ASIASXCYXIIFNB2ESSUP%2F20230402%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=68de2d6b0983ee4b2a1c7ef78352240db05f06ca57fd7ec0175d2ef3534ec47c";

void main() {
  Bloc.observer = const AppBlocObserver();
  // print(imgURL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAPI>(create: (context) => BlocAPI()),
        BlocProvider<BlocMenuPlan>(create: (context) => BlocMenuPlan()),
        BlocProvider<BlocIngredient>(create: (context) => BlocIngredient())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: "RecipeGenius"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<BlocAPI>().add(EventInitTestData());

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShopingCardView())),
                icon: Icon(Icons.shopping_cart_checkout)),
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
            onPressed: () =>
                context.read<BlocAPI>().add(EventFindRecepies("spinach"))));
  }
}
