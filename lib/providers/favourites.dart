import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_navigation/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool markAsFavourite(Meal meal) {
    final alreadyMarked = state.contains(meal);

    if (alreadyMarked) {
      state = state.where((el) => el.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouriteMealsNotifier,List<Meal>>((ref) => FavouriteMealsNotifier());
