import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/06/models/meal.dart';

class FavoritesProvider extends StateNotifier<List<Meal>> {
  FavoritesProvider() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal,
      ];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoritesProvider, List<Meal>>((ref) {
  return FavoritesProvider();
});
