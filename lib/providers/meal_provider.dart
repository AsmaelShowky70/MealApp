import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegin': false,
    'vegetarin': false,
  };
  List<Meal> avalibaleMeals = DUMMY_MEALS;
  //to favorite List
  List<Meal> favoriteMeal = [];

  void setFilters() async {
    avalibaleMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) return false;
      if (filters['lactose']! && !meal.isLactoseFree) return false;
      if (filters['vegin']! && !meal.isVegan) return false;
      if (filters['vegetarin']! && !meal.isVegetarian) return false;
      return true;
    }).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']!);
    prefs.setBool('lactose', filters['lactose']!);
    prefs.setBool('vegin', filters['vegin']!);
    prefs.setBool('vegetarin', filters['vegetarin']!);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegin'] = prefs.getBool('vegin') ?? false;
    filters['vegetarin'] = prefs.getBool('vegetarin') ?? false;
    notifyListeners();
  }

  void toggleFavorite(String mealId) {
    final exitingIndex = favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (exitingIndex >= 0) {
      favoriteMeal.removeAt(exitingIndex);
    } else {
      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      notifyListeners();
    }
  }

  bool isMealFavorit(String id) {
    return favoriteMeal.any((meal) => meal.id == id);
  }
}
