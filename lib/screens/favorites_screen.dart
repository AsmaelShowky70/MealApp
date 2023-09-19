import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../wedgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeal =
        Provider.of<MealProvider>(context, listen: true).favoriteMeal;
    if (favoriteMeal.isEmpty) {
      return const Center(
        child: Text('Your have not favorite yet-Start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            title: favoriteMeal[index].title,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        },
        itemCount: favoriteMeal.length,
      );
    }
  }
}
