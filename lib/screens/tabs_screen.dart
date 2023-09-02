import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites_screen.dart';

import '../wedgets/main_drawer.dart';

class TapsScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;
  const TapsScreen(this.favoriteMeal, {super.key});

  @override
  State<TapsScreen> createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  late List<Map<String, Object>> _page;

  @override
  void initState() {
    _page = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeal),
        'title': 'Your Favorites',
      },
    ];

    super.initState();
  }

  int _seletePageIndex = 0;
  void _selectPage(int value) {
    setState(() {
      _seletePageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_seletePageIndex]['title'] as String),
      ),
      body: _page[_seletePageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        selectedItemColor: Theme.of(context).hintColor,
        unselectedItemColor: Colors.white,
        currentIndex: _seletePageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorits'),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
