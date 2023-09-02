import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detal_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filter = {
    'gluten': false,
    'lactose': false,
    'vegin': false,
    'vegetarin': false,
  };
  List<Meal> avalibaleMeals = DUMMY_MEALS;
  //to favorite List
  List<Meal> favoriteMeal = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      filter = filterData;
      avalibaleMeals = DUMMY_MEALS.where((meal) {
        if (filter['gluten']! && !meal.isGlutenFree) return false;
        if (filter['lactose']! && !meal.isLactoseFree) return false;
        if (filter['vegin']! && !meal.isVegan) return false;
        if (filter['vegetarin']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final exitingIndex = favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (exitingIndex >= 0) {
      setState(() {
        favoriteMeal.removeAt(exitingIndex);
      });
    } else {
      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool isMealFavorit(String id) {
    return favoriteMeal.any((meal) => meal.id == id);
  }

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
        '/': (context) => TapsScreen(favoriteMeal),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(
              avalibaleMeals,
            ),
        MealDetalScreen.routeName: (context) =>
            MealDetalScreen(toggleFavorite, isMealFavorit),
        FiltersScreen.routeName: (context) => FiltersScreen(_setFilter, filter),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: null,
    );
  }
}
