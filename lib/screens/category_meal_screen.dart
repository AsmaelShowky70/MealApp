import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/wedgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  const CategoryMealScreen({super.key});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String categoryTitle;
  late List<Meal> displayMeal;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final List<Meal> avalibaleMeals =
        Provider.of<MealProvider>(context, listen: true).avalibaleMeals;
    if (_isInit) {
      final routeArg =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArg['id'];
      categoryTitle = routeArg['title']!;
      displayMeal = avalibaleMeals.where(
        (meal) {
          return meal.categories.contains(categoryId);
        },
      ).toList();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  // rest of your code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeal[index].id,
            title: displayMeal[index].title,
            imageUrl: displayMeal[index].imageUrl,
            duration: displayMeal[index].duration,
            complexity: displayMeal[index].complexity,
            affordability: displayMeal[index].affordability,
          );
        },
        itemCount: displayMeal.length,
      ),
    );
  }
}
