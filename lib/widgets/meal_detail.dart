import 'package:flutter/material.dart';
import 'package:meals_navigation/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetail extends StatelessWidget {
  const MealDetail({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: meal.imageUrl,
            height: 200,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Ingredients",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: const TextStyle(color: Colors.white),
            ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Steps",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          for (final step in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            )
        ],
      ),
    );
  }
}
