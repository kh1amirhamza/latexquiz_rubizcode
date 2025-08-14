
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

abstract class QuizRepository {
  Future<List<QuestionModel>> getQuizData(QuizCategory category);
}