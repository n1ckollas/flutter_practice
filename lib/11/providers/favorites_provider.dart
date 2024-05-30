import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/11/models/meal.dart';
import 'package:meals/11/providers/filters_provider.dart';
import 'package:meals/11/providers/meals_provider.dart';

class FavoritesProvider extends StateNotifier<List<Meal>> {
  FavoritesProvider() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesProvider, List<Meal>>((ref) {
  return FavoritesProvider();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final currentFilters = ref.watch(filtersProvier);

  return meals.where((meal) {
    if (currentFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (currentFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (currentFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (currentFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
