import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latexquiz_rubizcode/config/app_theme.dart';
import 'package:latexquiz_rubizcode/config/router/app_router.dart';
import 'package:latexquiz_rubizcode/core/constants/app_const.dart';

class LatexQuiz extends ConsumerWidget {
  const LatexQuiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(goRouterProvider);

    if (globalStatusBarHeight == 0.0) {
      globalStatusBarHeight = MediaQuery.of(context).viewPadding.top;
    }

    final themeMode = ref.watch(themeModeProvider);

    print("ThemeMode: ${themeMode.name}");

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Latex Quiz',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: goRouter,
      builder: EasyLoading.init(),
    );
  }
}
