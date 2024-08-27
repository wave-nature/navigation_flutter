import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_navigation/models/meal.dart';
import 'package:meals_navigation/providers/favourites.dart';
import 'package:meals_navigation/providers/filters.dart';
import 'package:meals_navigation/widgets/meal_detail.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouritesProvider);
    final containsMeal = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final marked =
                    ref.read(favouritesProvider.notifier).markAsFavourite(meal);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${marked ? "Adding" : "Removing"} ${meal.title} to favourites")));
              },
              icon:
                  Icon(containsMeal ? Icons.star : Icons.star_border_outlined))
        ],
      ),
      body: MealDetail(
        meal: meal,
      ),
    );
  }
}
