import 'package:flutter/material.dart';
import 'package:meals/02/screens/meal_details.dart';
import 'package:meals/02/models/meal.dart';
import 'package:meals/02/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });
  final String? title;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) =>
          MealDetailsScreen(meal: meal, onToggleFavorite: onToggleFavorite),
    ));
  }

  @override
  Widget build(context) {
    Widget content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        "Uh oh. Nothing is here.",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      Text(
        "Try selecting a differen category.",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      )
    ]));

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              }));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
