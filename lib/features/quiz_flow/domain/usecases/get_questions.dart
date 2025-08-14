import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions(this.repository);

  Future<List<QuestionModel>> call(QuizCategory category) async {
    return await repository.getQuizData(category);
  }
}