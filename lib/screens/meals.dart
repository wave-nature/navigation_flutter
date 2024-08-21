import 'package:flutter/material.dart';
import 'package:meals_navigation/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, required this.title});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = meals[index];
        return Text(meal.title);
      },
      itemCount: meals.length,
    );
    if (meals.isEmpty) {
      body = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Oh, nothing found here...'),
            SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting different category!",
              // style: Theme.of(context),
            )
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}
