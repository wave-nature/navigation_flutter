import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_navigation/providers/favourites.dart';
import 'package:meals_navigation/providers/meals.dart';

enum Filter { glutenFree, lactoseFree, veg, vegun }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.veg: false,
          Filter.vegun: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final availableMealsProvider = Provider((ref) {
  final meals = ref.read(mealsProvider);
  final availableMeals = meals.where((meal) {
    final currentFilters = ref.watch(filtersProvider);

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

  return availableMeals;
});
