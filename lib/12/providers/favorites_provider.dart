import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/12/models/meal.dart';

class FavoritesProvider extends StateNotifier<List<Meal>> {
  FavoritesProvider() : super([]);

  bool toggelMealFavoriteStatus(Meal meal) {
    bool isFavorite = state.contains(meal);

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
