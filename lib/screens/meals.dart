import 'package:flutter/material.dart';
import 'package:meals_navigation/models/meal.dart';
import 'package:meals_navigation/screens/meal_details.dart';
import 'package:meals_navigation/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });

  final String? title;
  final List<Meal> meals;

  void _onMealDetails(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = meals[index];
        return MealItem(
            meal: meal,
            onMealDetails: (meal) {
              _onMealDetails(context, meal);
            });
      },
      itemCount: meals.length,
    );
    if (meals.isEmpty) {
      body = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oh, nothing found here...',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting different category!",
              style: TextStyle(fontSize: 16, color: Colors.white),
              // style: Theme.of(context),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: body,
    );
  }
}
