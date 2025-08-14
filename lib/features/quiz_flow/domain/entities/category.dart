enum QuizCategory {
  chemistry,
  math,
  physics,
  biology,
}

extension QuizCategoryExtension on QuizCategory {
  String get displayName {
    switch (this) {
      case QuizCategory.chemistry:
        return 'Chemistry';
      case QuizCategory.math:
        return 'Mathematics';
      case QuizCategory.physics:
        return 'Physics';
      case QuizCategory.biology:
        return 'Biology';
    }
  }

  String get assetPath {
    switch (this) {
      case QuizCategory.chemistry:
        return 'assets/questions/questions_chemistry.json';
      case QuizCategory.math:
        return 'assets/questions/questions_math.json';
      case QuizCategory.physics:
        return 'assets/questions/questions_physics.json';
      case QuizCategory.biology:
        return 'assets/questions/questions_biology.json';
    }
  }
}
