import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/10/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersProvider extends StateNotifier<Map<Filter, bool>> {
  FiltersProvider()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProvider, Map<Filter, bool>>((ref) {
  return FiltersProvider();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final currentFilters = ref.watch(filtersProvider);
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
