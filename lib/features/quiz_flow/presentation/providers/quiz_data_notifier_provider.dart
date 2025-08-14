import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/repositories_impl/quiz_repository_impl.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

class QuizDataNotifier
    extends FamilyAsyncNotifier<List<QuestionModel>, QuizCategory> {
  @override
  FutureOr<List<QuestionModel>> build(QuizCategory category) async {
    return getQuizData(category);
  }

  //get quiz
  Future<List<QuestionModel>> getQuizData(QuizCategory category) async {
    return await ref.read(quizRepositoryProvider).getQuizData(category);
  }

  //refresh
  Future<void> refreshQuizData(QuizCategory category) async {
    state = await AsyncValue.guard(() async {
      return await getQuizData(category);
    });
  }
}

final quizDataProvider =
    AsyncNotifierProviderFamily<
      QuizDataNotifier,
      List<QuestionModel>,
      QuizCategory
    >(QuizDataNotifier.new);
