import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/datasources/quiz_local_data_source.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);

  @override
  Future<List<QuestionModel>> getQuizData(QuizCategory category) async {
    return dataSource.loadQuestions(category);
  }
}

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(ref.watch(quizLocalDataSourceProvider));
});
