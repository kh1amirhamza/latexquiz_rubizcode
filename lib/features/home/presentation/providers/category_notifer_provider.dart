import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

class CategoryNotifier extends StateNotifier<QuizCategory> {
  CategoryNotifier() : super(QuizCategory.math);

  void updateCategory(QuizCategory id) {
    state = id;
  }
}

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, QuizCategory>(
      (ref) => CategoryNotifier(),
    );
