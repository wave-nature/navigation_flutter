import 'package:flutter/material.dart';
import 'package:meals_navigation/models/meal.dart';
import 'package:meals_navigation/widgets/meal_detail.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(
      {super.key, required this.meal, required this.markAsFavourite});
  final Meal meal;

  final void Function(Meal meal) markAsFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                markAsFavourite(meal);
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: MealDetail(
        meal: meal,
      ),
    );
  }
}
