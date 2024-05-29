import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/07/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterProvider extends StateNotifier<Map<Filter, bool>> {
  FilterProvider()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FilterProvider, Map<Filter, bool>>((ref) {
  return FilterProvider();
});

final filteredMealsProvider = Provider((ref) {
  final currentFilters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);
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
