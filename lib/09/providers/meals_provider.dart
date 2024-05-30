import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/09/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
