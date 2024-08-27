import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:meals_navigation/providers/favourites.dart';
import 'package:meals_navigation/screens/categories.dart';
import 'package:meals_navigation/screens/filters.dart';
import 'package:meals_navigation/screens/meals.dart';
import 'package:meals_navigation/widgets/main_drawer.dart';
import "package:meals_navigation/providers/filters.dart";

final kDefaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veg: false,
  Filter.vegun: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int tabIndex = 0;
  // Map<Filter, bool> currentFilters = kDefaultFilters;

  _onSelectTab(index) {
    setState(() {
      tabIndex = index;
    });
  }

  // _markAsFavourite(Meal meal) {
  //   final isExisting = favouriteMeals.contains(meal);
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   if (isExisting) {
  //     setState(() {
  //       favouriteMeals.remove(meal);
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Removing ${meal.title} from favourites")));
  //   } else {
  //     favouriteMeals.add(meal);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Adding ${meal.title} to favourites")));
  //   }
  // }

  _navigateToScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      // final results = await Navigator.of(context).push<Map<Filter, bool>>(
      //     MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));

      // setState(() {
      //   currentFilters = results ?? kDefaultFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final meals = ref.watch(mealsProvider);
    final favouriteMeals = ref.watch(favouritesProvider);
    final availableMeals = ref.watch(availableMealsProvider);
    // final availableMeals = meals.where((meal) {
    //   final currentFilters = ref.watch(filtersProvider);
    //   if (currentFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (currentFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (currentFilters[Filter.veg]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (currentFilters[Filter.vegun]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    // }).toList();
    String title = 'Categories';
    Widget body = CategoriesScreen(availableMeals: availableMeals);
    if (tabIndex == 1) {
      body = MealsScreen(
        meals: favouriteMeals,
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
