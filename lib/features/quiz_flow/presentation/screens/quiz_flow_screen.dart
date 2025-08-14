// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:latexquiz_rubizcode/config/router/route_const.dart';
// import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
// import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_data_notifier_provider.dart';
// import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_state_provider.dart';

// class QuizFlowScreen extends HookConsumerWidget {
//   const QuizFlowScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final category = ref.watch(categoryNotifierProvider);

//     final questions = ref.read(quizDataProvider(category)).value ?? [];
//     final quizState = ref.watch(quizStateNotifierProvider(questions));

//     final quizNotifier = ref.read(
//       quizStateNotifierProvider(questions).notifier,
//     );

//     final currentQuestion = questions[quizState.currentIndex];
//     final selectedIndex = quizState.selectedAnswers[quizState.currentIndex];
//     final isAnswered = selectedIndex != null;
//     final isLastQuestion = quizState.currentIndex == questions.length - 1;

//     List<InlineSpan> parseText(String text) {
//       final spans = <InlineSpan>[];
//       final regex = RegExp(r'\$\$(.*?)\$\$');
//       int lastIndex = 0;
//       for (final match in regex.allMatches(text)) {
//         if (match.start > lastIndex) {
//           spans.add(
//             TextSpan(
//               text: text.substring(lastIndex, match.start),
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//                 fontStyle: FontStyle.normal,
//               ),
//             ),
//           );
//         }
//         spans.add(
//           WidgetSpan(
//             alignment: PlaceholderAlignment.middle,
//             child: Math.tex(
//               match.group(1)!,
//               textStyle: const TextStyle(fontSize: 18),
//             ),
//           ),
//         );
//         lastIndex = match.end;
//       }
//       if (lastIndex < text.length) {
//         spans.add(
//           TextSpan(
//             text: text.substring(lastIndex),
//             style: const TextStyle(
//               fontSize: 18,
//               color: Colors.black,
//               fontStyle: FontStyle.normal,
//             ),
//           ),
//         );
//       }
//       return spans;
//     }

//     Widget renderText(String text) =>
//         RichText(text: TextSpan(children: parseText(text)));

//     Color optionColor(int idx) {
//       if (!isAnswered) return Colors.white;
//       if (idx == currentQuestion.answerIndex) return Colors.green.shade300;
//       if (idx == selectedIndex) return Colors.red.shade300;
//       return Colors.white;
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: Text("Quiz - ${category.name}"),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(28),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: LinearProgressIndicator(
//               value: (quizState.currentIndex + 1) / questions.length,
//               color: Colors.yellowAccent,
//               backgroundColor: Colors.white24,
//               minHeight: 6,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 500),
//                   transitionBuilder: (child, anim) => FadeTransition(
//                     opacity: anim,
//                     child: SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(1, 0),
//                         end: Offset.zero,
//                       ).animate(anim),
//                       child: child,
//                     ),
//                   ),
//                   child: Container(
//                     key: ValueKey<int>(quizState.currentIndex),
//                     padding: const EdgeInsets.all(20),
//                     margin: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 12,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: renderText(currentQuestion.question),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ...currentQuestion.options.asMap().entries.map((entry) {
//                 final idx = entry.key;
//                 final optText = entry.value;
//                 return GestureDetector(
//                   onTap: isAnswered
//                       ? null
//                       : () => quizNotifier.selectAnswer(idx),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: optionColor(idx),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: renderText(optText),
//                   ),
//                 );
//               }),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: isAnswered
//                     ? () {
//                         if (isLastQuestion) {
//                           ref
//                               .read(
//                                 quizStateNotifierProvider(questions).notifier,
//                               )
//                               .disposeTimer();
//                           ref.invalidate(quizStateNotifierProvider(questions));
//                           context.goNamed(
//                             RouteConst.result,
//                             extra: {
//                               'score': quizState.score,
//                               'totalQuestions': questions.length,
//                             },
//                           );
//                         } else {
//                           quizNotifier.nextQuestion();
//                         }
//                       }
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   isLastQuestion ? "Finish" : "Next",
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// quiz_flow_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/config/router/route_const.dart';
import 'package:latexquiz_rubizcode/core/constants/app_sizes.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/providers/category_notifer_provider.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/category.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_data_notifier_provider.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/providers/quiz_state_provider.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/widgets/quiz_option_card.dart';

class QuizFlowScreen extends HookConsumerWidget {
  const QuizFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final category = ref.watch(categoryNotifierProvider);
    final questions = ref.read(quizDataProvider(category)).value ?? [];
    final quizState = ref.watch(quizStateNotifierProvider(questions));
    final quizNotifier = ref.read(
      quizStateNotifierProvider(questions).notifier,
    );

    final currentQuestion = questions[quizState.currentIndex];
    final selectedIndex = quizState.selectedAnswers[quizState.currentIndex];
    final isAnswered = selectedIndex != null;
    final isLastQuestion = quizState.currentIndex == questions.length - 1;

    Widget renderLatex(String text) {
      return RichText(
        text: TextSpan(
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          children: _parseLatex(text, context),
        ),
      );
    }

    Color getOptionBackgroundColor(int index) {
      if (!isAnswered) {
        return colorScheme.surface;
      }
      if (index == currentQuestion.answerIndex) {
        return colorScheme.tertiary.withAlpha((0.2 * 255).round());
      }
      if (index == selectedIndex) {
        return colorScheme.error.withAlpha((0.2 * 255).round());
      }
      return colorScheme.surface;
    }

    Color getOptionBorderColor(int index) {
      if (!isAnswered) {
        return Colors.transparent;
      }
      if (index == currentQuestion.answerIndex) {
        return colorScheme.tertiary;
      }
      if (index == selectedIndex) {
        return colorScheme.error;
      }
      return Colors.transparent;
    }

    IconData? getOptionIcon(int index) {
      if (!isAnswered) return null;
      if (index == currentQuestion.answerIndex) {
        return Icons.check_circle;
      }
      if (index == selectedIndex) {
        return Icons.cancel;
      }
      return null;
    }

    Color getOptionIconColor(int index) {
      if (!isAnswered) return Colors.transparent;
      if (index == currentQuestion.answerIndex) {
        return colorScheme.tertiary;
      }
      if (index == selectedIndex) {
        return colorScheme.error;
      }
      return Colors.transparent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${category.displayName} Quiz",
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(12),
          child: LinearProgressIndicator(
            value: (quizState.currentIndex + 1) / questions.length,
            minHeight: 6,
            color: colorScheme.primary,
            backgroundColor: colorScheme.surface,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  value: quizState.remainingSeconds / 15.0,
                  strokeWidth: 8,

                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                ),
              ),

              Center(
                child: Text(
                  "${quizState.remainingSeconds}",
                  style: textTheme.bodyLarge?.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),

          kGapL,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question counter
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Question ${quizState.currentIndex + 1} of ${questions.length}",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Question card
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: Container(
                        key: ValueKey<int>(quizState.currentIndex),
                        child: renderLatex(currentQuestion.question),
                      ),
                    ),
                  ),
                ),
                kGapM,
                // Options
                ListView.builder(
                  itemCount: currentQuestion.options.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  // separatorBuilder: (context, index) => const SizedBox(height: 0 ),
                  itemBuilder: (context, index) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: index%2==0?
                          Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(anim):
                           Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: QuizOptionCard(
                        key: ValueKey<int>(quizState.currentIndex),

                        index: index,
                        option: currentQuestion.options[index],
                        isSelected: index == selectedIndex,
                        isAnswered: isAnswered,
                        backgroundColor: getOptionBackgroundColor(index),
                        borderColor: getOptionBorderColor(index),
                        icon: getOptionIcon(index),
                        iconColor: getOptionIconColor(index),
                        onTap: isAnswered
                            ? null
                            : () => quizNotifier.selectAnswer(index),
                      ),
                    );
                  },
                ),
                kGapXXL,
                // Next button
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: isAnswered || (isLastQuestion && quizState.remainingSeconds == 0)
                        ? () {
                            if (isLastQuestion) {
                              quizNotifier.disposeTimer();
                              ref.invalidate(
                                quizStateNotifierProvider(questions),
                              );
                              context.goNamed(
                                RouteConst.result,
                                extra: {
                                  'score': quizState.score,
                                  'totalQuestions': questions.length,
                                },
                              );
                            } else {
                              quizNotifier.nextQuestion();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isLastQuestion ? "Finish Quiz" : "Next Question",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        //   color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _parseLatex(String text, BuildContext context) {
    final theme = Theme.of(context);
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\$\$(.*?)\$\$');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
          ),
        );
      }
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Math.tex(
            match.group(1)!,
            textStyle: TextStyle(
              fontSize: 18,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      );
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
        ),
      );
    }
    return spans;
  }
}
