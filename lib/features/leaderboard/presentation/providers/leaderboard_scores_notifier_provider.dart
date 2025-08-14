import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latexquiz_rubizcode/core/db/leaderboard_db.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

class LeaderboardAsyncNotifier
    extends FamilyAsyncNotifier<List<Map<String, dynamic>>, QuizCategory?> {
  @override
  Future<List<Map<String, dynamic>>> build(QuizCategory? category) async {
    return getAllScores(category: category);
  }

  Future<List<Map<String, dynamic>>> getAllScores({
    QuizCategory? category,
  }) async {
    return await LeaderboardDB.getAllScores(category: category?.name);
  }

  Future<void> refreshAllScores({QuizCategory? category}) async {
    state = await AsyncValue.guard(() async {
      return await getAllScores();
    });
  }
}

final leaderboardScoresNotifierProvider =
    AsyncNotifierProviderFamily<
      LeaderboardAsyncNotifier,
      List<Map<String, dynamic>>,
      QuizCategory?
    >(LeaderboardAsyncNotifier.new);
