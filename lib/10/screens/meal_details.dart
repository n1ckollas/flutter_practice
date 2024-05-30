import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/10/models/meal.dart';
import 'package:meals/10/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(context, WidgetRef ref) {
    final favorites = ref.watch(favoriteMeals);
    final isFavorite = favorites.contains(meal);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded =
                ref.read(favoriteMeals.notifier).toggleFavoriteMealStatus(meal);

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(wasAdded
                    ? "Meal marked ad favorite"
                    : "Meal removed from favorite")));
          },
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final ingredient in meal.ingredients) Text(ingredient),
            const SizedBox(height: 24),
            for (final step in meal.steps)
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ))
          ],
        ),
      ),
    );
  }
}
