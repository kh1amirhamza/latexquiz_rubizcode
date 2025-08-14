// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:latexquiz_rubizcode/config/router/route_const.dart';
// import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';

// class LeaderboardScreen extends ConsumerWidget {
//   const LeaderboardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scores =
//         ref.watch(leaderboardScoresNotifierProvider(null)).value ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leaderboard'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         elevation: 4,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.goNamed(RouteConst.root),
//         ),
//       ),
//       body: scores.isEmpty
//           ? const Center(
//               child: Text(
//                 "No scores yet!",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//             )
//           : ListView.builder(
//               itemCount: scores.length,
//               padding: const EdgeInsets.all(12),
//               itemBuilder: (context, index) {
//                 final score = scores[index];
//                 final rank = index + 1;
//                 final isTop = rank == 1;
    
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   color: isTop ? Colors.amber.shade100 : Colors.white,
//                   elevation: isTop ? 6 : 2,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 22,
//                       backgroundColor: isTop
//                           ? Colors.orange
//                           : Colors.deepPurple.shade200,
//                       child: Text(
//                         "$rank",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     title: Text(
//                       score['name'] ?? "Unknown",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: isTop ? FontWeight.bold : FontWeight.w500,
//                       ),
//                     ),
//                     trailing: Text(
//                       "${score['score']} pts",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: isTop ? Colors.orange.shade700 : Colors.black87,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/config/router/route_const.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/widgets/theme_toggle_button.dart';
import 'package:latexquiz_rubizcode/features/leaderboard/presentation/providers/leaderboard_scores_notifier_provider.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    final scores = ref.watch(leaderboardScoresNotifierProvider(null)).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard', style: textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(RouteConst.root),
        ),
        actions: [
          ThemeToggleButton()
        ],
      ),
      body: SafeArea(
        child: scores.isEmpty
            ? _buildEmptyState(context, colorScheme, textTheme)
            : Column(
                children: [
                  _buildTopPerformers(scores, colorScheme, textTheme),
                  Expanded(
                    child: _buildScoreList(scores, colorScheme, textTheme),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context, 
    ColorScheme colorScheme, 
    TextTheme textTheme
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard_outlined,
              size: 72,
              color: colorScheme.onSurface.withAlpha(70),
            ),
            const SizedBox(height: 24),
            Text(
              "No Scores Yet",
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface.withAlpha(200),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Complete a quiz to appear on the leaderboard",
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withAlpha(132),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteConst.root),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Start a Quiz",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPerformers(
    List<Map<String, dynamic>> scores, 
    ColorScheme colorScheme, 
    TextTheme textTheme
  ) {
    // Get top 3 scores
    final topScores = scores.length > 3 ? scores.sublist(0, 3) : scores;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              "Top Performers",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: topScores.asMap().entries.map((entry) {
              final index = entry.key;
              final score = entry.value;
              final rank = index + 1;
              
              // Different styling for top 3 positions
              double size;
              Color medalColor;
              EdgeInsets padding;
              
              switch (rank) {
                case 1:
                  size = 100;
                  medalColor = const Color(0xFFFFD700); // Gold
                  padding = const EdgeInsets.only(bottom: 24);
                  break;
                case 2:
                  size = 85;
                  medalColor = const Color(0xFFC0C0C0); // Silver
                  padding = const EdgeInsets.only(bottom: 12);
                  break;
                case 3:
                  size = 75;
                  medalColor = const Color(0xFFCD7F32); // Bronze
                  padding = EdgeInsets.zero;
                  break;
                default:
                  size = 70;
                  medalColor = colorScheme.primary;
                  padding = EdgeInsets.zero;
              }
              
              return Padding(
                padding: padding,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: medalColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(30),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "$rank",
                              style: TextStyle(
                                fontSize: size * 0.3,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        if (rank <= 3)
                          Positioned(
                            top: 0,
                            child: Icon(
                              Icons.emoji_events,
                              size: size * 0.4,
                              color: medalColor,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: size,
                      child: Text(
                        score['name'] ?? "Unknown",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${score['score']} pts",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreList(
    List<Map<String, dynamic>> scores, 
    ColorScheme colorScheme, 
    TextTheme textTheme
  ) {
    return ListView.builder(
      itemCount: scores.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final score = scores[index];
        final rank = index + 1;
        final isTopThree = rank <= 3;
        
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isTopThree ? colorScheme.primary.withAlpha(100) : null,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isTopThree 
                  ? colorScheme.primaryContainer 
                  : Colors.blueGrey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "$rank",
                  style: TextStyle(
                    fontSize: 16,
                    color: isTopThree 
                      ? colorScheme.onPrimaryContainer 
                      : colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              score['name'] ?? "Unknown",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              score['category'] ?? "General",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha((0.7 * 255).round()),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${score['score']} pts",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
