// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:latexquiz_rubizcode/config/router/route_const.dart';
// import 'package:latexquiz_rubizcode/core/common/services/popup_service.dart';
// import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
// import 'package:latexquiz_rubizcode/features/home/presentation/widgets/theme_toggle_button.dart';
// import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';
// import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';
// import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_data_notifier_provider.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final selectedCategory = ref.watch(categoryNotifierProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Quiz Home"),
//         actions: [
//           IconButton(
//             tooltip: "Leaderboard",
//             onPressed: () {
//               ref
//                   .read(leaderboardScoresNotifierProvider(null).notifier)
//                   .refreshAllScores();
//               context.pushNamed(RouteConst.leaderboard);
//             },
//             icon: Icon(Icons.workspace_premium, color: Colors.amber, size: 28),
//           ),

//           ThemeToggleButton(),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Select Subject",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),

//             ...QuizCategory.values.map((category) {
//               return RadioListTile<QuizCategory>(
//                 title: Text(
//                   category.displayName,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 value: category,
//                 groupValue: selectedCategory,
//                 onChanged: (value) {
//                   if (value == null) {
//                     return;
//                   }
//                   ref
//                       .read(categoryNotifierProvider.notifier)
//                       .updateCategory(value);
//                 },
//               );
//             }),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () async {
//                 showLoading();
//                 await ref.read(quizDataProvider(selectedCategory).future);
//                 dismissLoading();
//                 if (context.mounted) {
//                   context.pushNamed(RouteConst.quizFlow);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text("Start Quiz", style: TextStyle(fontSize: 18)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/config/router/route_const.dart';
import 'package:latexquiz_rubizcode/core/common/services/popup_service.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/widgets/theme_toggle_button.dart';
import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_data_notifier_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    final selectedCategory = ref.watch(categoryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App", style: textTheme.titleLarge),
        centerTitle: true,
        actions: [
          // Leaderboard button
          IconButton(
            tooltip: "Leaderboard",
            onPressed: () {
              ref
                  .read(leaderboardScoresNotifierProvider(null).notifier)
                  .refreshAllScores();
              context.pushNamed(RouteConst.leaderboard);
            },
            icon: Badge(
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.leaderboard,
                color: colorScheme.onSurface,
                size: 28,
              ),
            ),
          ),
          
          // Theme toggle
          const ThemeToggleButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                "Test Your Knowledge",
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Select a subject to begin",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withAlpha(150),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Category grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: QuizCategory.values.map((category) {
                    final isSelected = category == selectedCategory;
                    return _buildCategoryCard(
                      context,
                      category,
                      isSelected,
                      colorScheme,
                      textTheme,
                    );
                  }).toList(),
                ),
              ),
              
              // Start button
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    showLoading();
                    await ref.read(quizDataProvider(selectedCategory).future);
                    dismissLoading();
                    if (context.mounted) {
                      context.pushNamed(RouteConst.quizFlow);
                    }
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                  ),),
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: colorScheme.onPrimary,
                    size: 28,
                  ),
                  label: Text(
                    "Start Quiz",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    QuizCategory category,
    bool isSelected,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    // Define icons and colors for each category
    IconData icon;
    Color color;
    Color bgColor;
    
    switch (category) {
      case QuizCategory.math:
        icon = Icons.calculate;
        color = Colors.purple;
        bgColor = Colors.purple.shade100;
        break;
      case QuizCategory.biology:
        icon = Icons.emoji_nature_outlined;
        color = Colors.green;
        bgColor = Colors.green.shade100;
        break;
      case QuizCategory.physics:
        icon = Icons.bolt;
        color = Colors.blue;
        bgColor = Colors.blue.shade100;
        break;
      case QuizCategory.chemistry:
        icon = Icons.liquor;
        color = Colors.orange;
        bgColor = Colors.orange.shade100;
        break;

    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ref
            .read(categoryNotifierProvider.notifier)
            .updateCategory(category);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with selection indicator
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(
                    icon,
                    size: 48,
                    color: color,
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                category.displayName,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}