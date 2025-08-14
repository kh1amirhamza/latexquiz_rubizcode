import 'package:flutter_test/flutter_test.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_state_provider.dart';

void main() {
  group('Score Calculation Tests', () {
    late QuizNotifier quizNotifier;
    final questions = [
      QuestionModel(
        question: "What is 2+2?",
        options: ["3", "4", "5"],
        answerIndex: 1,
      ),
      QuestionModel(
        question: "What is 3+3?",
        options: ["5", "6", "7"],
        answerIndex: 1,
      ),
    ];

    setUp(() {
      quizNotifier = QuizNotifier(questions: questions);
    });

    test('Correct answer increases score by 1', () {
      quizNotifier.state = quizNotifier.state.copyWith(score: 2);

      final newScore = quizNotifier.calculateNewScore(1);

      expect(newScore, 3);
    });

    test('Incorrect answer does not increase score', () {
      quizNotifier.state = quizNotifier.state.copyWith(score: 2);

      final newScore = quizNotifier.calculateNewScore(0);

      expect(newScore, 2);
    });

    test('Score calculation with multiple questions', () {
      quizNotifier.state = quizNotifier.state.copyWith(
        currentIndex: 0,
        score: 0,
      );
      var newScore = quizNotifier.calculateNewScore(1);
      expect(newScore, 1);

      quizNotifier.state = quizNotifier.state.copyWith(
        currentIndex: 1,
        score: newScore,
      );
      newScore = quizNotifier.calculateNewScore(0);
      expect(newScore, 1);
    });
  });
}
