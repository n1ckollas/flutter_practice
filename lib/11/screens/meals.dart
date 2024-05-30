import 'package:flutter/material.dart';
import 'package:meals/11/models/meal.dart';
import 'package:meals/11/screens/meal_details.dart';
import 'package:meals/11/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(context) {
    Widget content = const Center(
        child: Column(children: [
      Text("Looks like there is nothing here."),
      SizedBox(
        height: 16,
      ),
      Text("Try selecting a differen category."),
    ]));
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
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
