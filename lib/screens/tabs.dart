import 'package:flutter/material.dart';
import 'package:meals_navigation/data/dummy_data.dart';

import 'package:meals_navigation/models/meal.dart';
import 'package:meals_navigation/screens/categories.dart';
import 'package:meals_navigation/screens/filters.dart';
import 'package:meals_navigation/screens/meals.dart';
import 'package:meals_navigation/widgets/main_drawer.dart';

final kDefaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veg: false,
  Filter.vegun: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int tabIndex = 0;
  List<Meal> favouriteMeals = [];
  Map<Filter, bool> currentFilters = kDefaultFilters;

  _onSelectTab(index) {
    setState(() {
      tabIndex = index;
    });
  }

  _markAsFavourite(Meal meal) {
    final isExisting = favouriteMeals.contains(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    if (isExisting) {
      setState(() {
        favouriteMeals.remove(meal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Removing ${meal.title} from favourites")));
    } else {
      favouriteMeals.add(meal);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Adding ${meal.title} to favourites")));
    }
  }

  _navigateToScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      final results = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
              builder: (ctx) => FiltersScreen(currentFilters: currentFilters)));

      setState(() {
        currentFilters = results ?? kDefaultFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (currentFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (currentFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (currentFilters[Filter.veg]! && !meal.isVegetarian) {
        return false;
      }
      if (currentFilters[Filter.vegun]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    String title = 'Categories';
    Widget body = CategoriesScreen(
        markAsFavourite: _markAsFavourite, availableMeals: availableMeals);
    if (tabIndex == 1) {
      body = MealsScreen(
        meals: favouriteMeals,
        markAsFavourite: _markAsFavourite,
      );
      title = "Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(onNavigate: _navigateToScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectTab,
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          )
        ],
      ),
      body: body,
    );
  }
}
