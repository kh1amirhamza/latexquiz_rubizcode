import 'package:latexquiz_rubizcode/features/quiz_flow/data/models/question_model.dart';

class QuizState {
  final List<QuestionModel> questions;
  final int currentIndex;
  final int? selectedAnswerIndex;
  final int score;
  final int timeRemaining;
  final bool isCompleted;

  QuizState({
    required this.questions,
    this.currentIndex = 0,
    this.selectedAnswerIndex,
    this.score = 0,
    this.timeRemaining = 15,
    this.isCompleted = false,
  });

  // Add copyWith method for immutability
  QuizState copyWith({
    List<QuestionModel>? questions,
    int? currentIndex,
    int? selectedAnswerIndex,
    int? score,
    int? timeRemaining,
    bool? isCompleted,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      score: score ?? this.score,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  
}