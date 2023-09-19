import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';
import '../providers/meal_provider.dart';

class MealDetalScreen extends StatelessWidget {
  static const routeName = 'mealdetals';

  const MealDetalScreen({super.key});
  Widget buildSectionRitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      width: 300,
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionRitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).hintColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionRitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${index + 1}'),
                  ),
                  title: Text(selectedMeal.steps[index]),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
          ],
        ),
      ),
      //لحذف الوجبة
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
        child: Icon(
          Provider.of<MealProvider>(context, listen: true).isMealFavorit(mealId)
              ? Icons.star
              : Icons.star_border,
          color: Colors.black,
        ),
      ),
    );
  }
}
