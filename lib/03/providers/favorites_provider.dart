import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/03/models/meal.dart';

class FavoritesNotifier extends StateNotifier {
  FavoritesNotifier() : super([]);

  void toggleFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id);
    } else {
      state = [...state, meal];
    }
  }
}

final favoritesProvider = StateNotifierProvider((ref) {
  return FavoritesNotifier();
});
