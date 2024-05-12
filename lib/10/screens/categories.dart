import 'package:flutter/material.dart';
import 'package:meals/10/screens/meals.dart';
import 'package:meals/10/widgets/category_grid_item.dart';
import 'package:meals/10/data/dummy_data.dart';
import 'package:meals/10/models/category.dart';
import 'package:meals/10/models/meal.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category){
    final filteredMeals = availableMeals.where(
      (meal) => meal.categories.contains(category.id)
    ).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals, 
          onToggleFavorite: onToggleFavorite,
        )
      )
    );
  }

  @override
  Widget build(context){
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        for(final category in availableCategories)
          CategoryGridItem(
            category: category, 
            onSelectCategory: (){
              _selectCategory(context, category);
            })
      ],
    );
  }
}