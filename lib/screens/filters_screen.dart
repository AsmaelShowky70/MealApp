import 'package:flutter/material.dart';
import '../wedgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.saveFilters, this.currentFilter, {super.key});

  static const routeName = 'filterRoute';
  final void Function(Map<String, bool>) saveFilters; // Change this line
  final Map<String, bool> currentFilter;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegetarian = false;

  @override
  void initState() {
    isGlutenFree = widget.currentFilter['gluten']!;
    isLactoseFree = widget.currentFilter['lactose']!;
    isVegan = widget.currentFilter['vegin']!;
    isVegetarian = widget.currentFilter['vegetarin']!;
    super.initState();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilter = {
                'gluten': isGlutenFree,
                'lactose': isLactoseFree,
                'vegin': isVegan,
                'vegetarin': isVegetarian,
              };
              widget.saveFilters(selectedFilter);
            },
            icon: const Icon(Icons.save),
          ),
        ],
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
                  isGlutenFree,
                  (newValu) {
                    setState(() {
                      isGlutenFree = newValu;
                    });
                  },
                ),
                buildSwitchTile(
                  'Lactose-Free',
                  'Only Include Lactose Free Meal',
                  isLactoseFree,
                  (newValu) {
                    setState(() {
                      isLactoseFree = newValu;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegane',
                  'Only Include Vegane Meal',
                  isVegan,
                  (newValu) {
                    setState(() {
                      isVegan = newValu;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegetarian',
                  'Only Include isVegetarian Meal',
                  isVegetarian,
                  (newValu) {
                    setState(() {
                      isVegetarian = newValu;
                    });
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
