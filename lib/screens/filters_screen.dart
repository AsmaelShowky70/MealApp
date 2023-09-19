import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../wedgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  static const routeName = 'filterRoute';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: (newValue) => updateValue(newValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilter =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adject Your Meal Selection',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile(
                  'Gluten-Free',
                  'Only Include Gluten Free Meal',
                  currentFilter['gluten']!,
                  (newValu) {
                    setState(() {
                      currentFilter['gluten'] = newValu;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchTile(
                  'Lactose-Free',
                  'Only Include Lactose Free Meal',
                  currentFilter['lactose']!,
                  (newValu) {
                    setState(() {
                      currentFilter['lactose'] = newValu;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchTile(
                  'Vegane',
                  'Only Include Vegane Meal',
                  currentFilter['vegin']!,
                  (newValu) {
                    setState(() {
                      currentFilter['vegin'] = newValu;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchTile(
                  'Vegetarian',
                  'Only Include isVegetarian Meal',
                  currentFilter['vegetarin']!,
                  (newValu) {
                    setState(() {
                      currentFilter['vegetarin'] = newValu;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
