import 'package:flutter/material.dart';
import 'package:meals/03/data/dummy_data.dart';
import 'package:meals/03/models/meal.dart';
import 'package:meals/03/screens/meals.dart';
import 'package:meals/03/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggelFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggelFavorite;
  final List<Meal> availableMeals;
  void _selectCategory(context, category) {
    final filterdMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filterdMeals,
            onToggleFavorite: onToggelFavorite)));
  }

  @override
  Widget build(context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map((category) => CategoryGridItem(
                category: category,
                onSelecteCategory: () {
                  _selectCategory(context, category);
                },
              ))
        ]);
  }
}
