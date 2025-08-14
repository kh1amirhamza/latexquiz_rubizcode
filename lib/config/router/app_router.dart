import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:latexquiz_rubizcode/features/home/presentation/screens/home_screen.dart';
import 'package:latexquiz_rubizcode/features/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/domain/entities/question.dart';
import 'package:latexquiz_rubizcode/features/quiz_flow/presentation/screens/quiz_flow_screen.dart';
import 'package:latexquiz_rubizcode/features/result/presentation/screens/result_screen.dart';
import 'package:latexquiz_rubizcode/main.dart';

import 'route_const.dart';

Page<dynamic> _buildAdaptivePage(Widget child) {
  if (Platform.isIOS) {
    return CupertinoPage(child: child);
  } else {
    return _buildPageWithDefaultTransition(child);
  }
}

Page<dynamic> _buildPageWithDefaultTransition(Widget child) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    child: child,
  );
}

GoRoute defaultTransitionRoute({
  required String path,
  required String name,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (context, state) =>
        _buildAdaptivePage(builder(context, state)),
  );
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,

    initialLocation: RouteConst.root,
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) {
      debugPrint("Current Route: ${state.uri.toString()}");
      return null;
    },

    routes: [
      GoRoute(
        path: RouteConst.root,
        name: RouteConst.root,
        pageBuilder: (context, state) => _buildAdaptivePage(const HomeScreen()),
      ),
      GoRoute(
        path: RouteConst.quizFlow,
        name: RouteConst.quizFlow,
        pageBuilder: (context, state) {

          return _buildAdaptivePage(QuizFlowScreen());
        },
      ),
      GoRoute(
        path: RouteConst.result,
        name: RouteConst.result,
        pageBuilder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final score = extras?['score'] ;
          final totalQuestions = extras?['totalQuestions'];
          return _buildAdaptivePage(ResultsScreen(score: score, totalQuestions: totalQuestions));
        },
      ),
      GoRoute(
        path: RouteConst.leaderboard,
        name: RouteConst.leaderboard,
        pageBuilder: (context, state) =>
            _buildAdaptivePage(const LeaderboardScreen()),
      ),
    ],
  );
});
