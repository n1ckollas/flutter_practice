import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/08/models/meal.dart';
import 'package:meals/08/providers/filters_provider.dart';
import 'package:meals/08/providers/meals_provider.dart';

class FavoritesProvider extends StateNotifier<List<Meal>> {
  FavoritesProvider() : super([]);

  bool toggleFavoriteMealStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) {
        return m.id != meal.id;
      }).toList();
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

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
