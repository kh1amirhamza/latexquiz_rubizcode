import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

abstract class QuizLocalDataSource {
  Future<List<QuestionModel>> loadQuestions(QuizCategory category);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  @override
  Future<List<QuestionModel>> loadQuestions(QuizCategory category) async {
    final path = category.assetPath;
    final data = await rootBundle.loadString(path);
    final jsonList = json.decode(data) as List;
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }
}

final quizLocalDataSourceProvider = Provider<QuizLocalDataSource>(
  (ref) => QuizLocalDataSourceImpl(),
);
