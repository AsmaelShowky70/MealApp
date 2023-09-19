import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detal_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MealProvider>(
    create: (ctx) => MealProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          hintColor: Colors.amber,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge:
                    const TextStyle(color: Color.fromRGBO(20, 30, 50, 1)),
                bodyMedium:
                    const TextStyle(color: Color.fromRGBO(20, 30, 50, 1)),
                titleMedium: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      routes: {
        '/': (context) => const TapsScreen(),
        CategoryMealScreen.routeName: (context) => const CategoryMealScreen(),
        MealDetalScreen.routeName: (context) => const MealDetalScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen(),
      },
    );
  }
}
