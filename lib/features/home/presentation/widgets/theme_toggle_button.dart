import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/config/app_theme.dart';

class ThemeToggleButton extends HookConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
      ),
      onPressed: () {
        ref.read(themeModeProvider.notifier).state = themeMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
      },
    );
  }
}
