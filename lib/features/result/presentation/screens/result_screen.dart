// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:latexquiz_rubizcode/config/router/route_const.dart';
// import 'package:latexquiz_rubizcode/core/common/services/popup_service.dart';
// import 'package:latexquiz_rubizcode/core/db/leaderboard_db.dart';
// import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
// import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';
// import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

// class ResultsScreen extends HookConsumerWidget {
//   final int score;
//   final int totalQuestions;

//   const ResultsScreen({
//     Key? key,
//     required this.score,
//     required this.totalQuestions,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final nameController = useTextEditingController();
//     final category = ref.read(categoryNotifierProvider);

//     Future<void> saveScore() async {
//       final name = nameController.text.trim();
//       if (name.isEmpty) {
//         showInfo(message: "Please enter your name");
//         return;
//       }

//       showLoading();

//       await LeaderboardDB.insertScore(name, category.displayName, score);
//       await ref
//           .read(leaderboardScoresNotifierProvider(null).notifier)
//           .refreshAllScores();
//       dismissLoading();

//       if (context.mounted) {
//         context.goNamed(RouteConst.leaderboard);
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('Quiz Results')),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Your Score: $score / $totalQuestions',
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter your name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: saveScore,
//               child: const Text('Save & View Leaderboard'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/config/router/route_const.dart';
import 'package:latexquiz_rubizcode/core/common/services/popup_service.dart';
import 'package:latexquiz_rubizcode/core/constants/app_sizes.dart';
import 'package:latexquiz_rubizcode/core/db/leaderboard_db.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/widgets/theme_toggle_button.dart';
import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';

class ResultsScreen extends HookConsumerWidget {
  final int score;
  final int totalQuestions;

  const ResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final nameController = useTextEditingController();
    final category = ref.read(categoryNotifierProvider);
    final percentage = (score / totalQuestions * 100).round();

    // Determine performance level
    String performanceText;
    IconData performanceIcon;
    Color performanceColor;

    if (percentage >= 90) {
      performanceText = "Excellent!";
      performanceIcon = Icons.emoji_events;
      performanceColor = colorScheme.tertiary;
    } else if (percentage >= 70) {
      performanceText = "Great Job!";
      performanceIcon = Icons.thumb_up;
      performanceColor = colorScheme.primary;
    } else if (percentage >= 50) {
      performanceText = "Good Effort!";
      performanceIcon = Icons.done_all;
      performanceColor = colorScheme.secondary;
    } else {
      performanceText = "Keep Trying!";
      performanceIcon = Icons.autorenew;
      performanceColor = colorScheme.error;
    }

    Future<void> saveScore() async {
      final name = nameController.text.trim();
      if (name.isEmpty) {
        showInfo(message: "Please enter your name");
        return;
      }

      showLoading();
      await LeaderboardDB.insertScore(name, category.displayName, score);
      await ref
          .read(leaderboardScoresNotifierProvider(null).notifier)
          .refreshAllScores();
      dismissLoading();

      if (context.mounted) {
        context.goNamed(RouteConst.leaderboard);
      }
    }

    Future<void> retryQuiz() async {
      await ref
          .read(leaderboardScoresNotifierProvider(null).notifier)
          .refreshAllScores();
      if (context.mounted) {
        context.goNamed(RouteConst.root);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results', style: textTheme.titleLarge),
        centerTitle: true,
        actions: [ThemeToggleButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Performance indicator
              kGapXXL,
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 12,
                      backgroundColor: colorScheme.surfaceVariant,
                      color: performanceColor,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(performanceIcon, size: 36, color: performanceColor),
                      const SizedBox(height: 8),
                      Text(
                        '$percentage%',
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
        
              // Performance text
              Text(
                performanceText,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: performanceColor,
                ),
              ),
              kGapXL,
        
              // Score details
              Text(
                '$score out of $totalQuestions correct',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
              kGapXXXXL,
        
              // Name input
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(Icons.person, color: colorScheme.primary),
                ),
              ),
              kGapXXXXL,
        
              // Action buttons
              Row(
                children: [
                  // Retry button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: retryQuiz,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Try Again',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
        
                  // Save button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: saveScore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save Score',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
