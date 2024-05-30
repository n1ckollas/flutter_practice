import 'package:flutter/material.dart';
import 'package:meals/10/models/meal.dart';
import 'package:meals/10/screens/meal_details.dart';
import 'package:meals/10/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(context) {
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Uh Oh. Nothing is here.",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          "Try selecteing a different Category",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        )
      ],
    ));

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                _selectMeal(context, meal);
              }));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
