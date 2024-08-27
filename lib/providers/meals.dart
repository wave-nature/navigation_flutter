import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:meals_navigation/data/dummy_data.dart";
import "package:meals_navigation/models/meal.dart";

final mealsProvider = Provider<List<Meal>>((ref) => dummyMeals);
