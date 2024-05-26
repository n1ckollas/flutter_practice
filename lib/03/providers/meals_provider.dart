import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/03/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
