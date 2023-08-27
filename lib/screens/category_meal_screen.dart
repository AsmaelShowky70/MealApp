import 'package:flutter/material.dart';
import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';
  const CategoryMealScreen({super.key});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  @override
  Widget build(BuildContext context) {
    //لفك البيانات ال موجودة في argument
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    final categoryTitle = routeArg['title'];
    //عمل فلترة بدالة where لمعرفة id
    final categoryMeals = DUMMY_MEALS.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text(categoryMeals[index].title);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
