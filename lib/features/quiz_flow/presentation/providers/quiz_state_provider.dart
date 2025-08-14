import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';

class QuizState {
  final int currentIndex;
  final List<int?> selectedAnswers;
  final int score;
  final int remainingSeconds;

  QuizState({
    required this.currentIndex,
    required this.selectedAnswers,
    required this.score,
    required this.remainingSeconds,
  });

  QuizState copyWith({
    int? currentIndex,
    List<int?>? selectedAnswers,
    int? score,
    int? remainingSeconds,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      score: score ?? this.score,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  final List<QuestionModel> questions;
  Timer? _timer;
  final int durationPerQuestion;

  QuizNotifier({required this.questions, this.durationPerQuestion = 15})
    : super(
        QuizState(
          currentIndex: 0,
          selectedAnswers: List.filled(questions.length, null),
          score: 0,
          remainingSeconds: durationPerQuestion,
        ),
      ) {
    _startTimer();
  }

  void selectAnswer(int index) {
    if (state.selectedAnswers[state.currentIndex] != null) {
      return; // single selection
    }

    final updatedAnswers = List<int?>.from(state.selectedAnswers);
    updatedAnswers[state.currentIndex] = index;

    state = state.copyWith(
      selectedAnswers: updatedAnswers,
      score: calculateNewScore(index),
    );
  }

  int calculateNewScore(int index) {
    final isCorrect = questions[state.currentIndex].answerIndex == index;
    return state.score + (isCorrect ? 1 : 0);
  }

  void nextQuestion() {
    _timer?.cancel();
    if (state.currentIndex < questions.length - 1) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        remainingSeconds: durationPerQuestion,
      );
      _startTimer();
    } else {
      // Quiz completed
      _timer?.cancel();
    }
  }

  void resetState() {
    disposeTimer();
    state = QuizState(
      currentIndex: 0,
      selectedAnswers: List.filled(questions.length, null),
      score: 0,
      remainingSeconds: durationPerQuestion,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        nextQuestion();
      }
    });
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}

final quizStateNotifierProvider =
    StateNotifierProvider.family.autoDispose<QuizNotifier, QuizState, List<QuestionModel>>(
      (ref, questions) => QuizNotifier(questions: questions),
    );
