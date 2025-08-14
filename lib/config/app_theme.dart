// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// Theme mode provider (Light / Dark / System)
// final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// /// Light Theme – Vibrant & Fresh
// final lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primaryColor: const Color(0xFF4A90E2),
//   scaffoldBackgroundColor: const Color(0xFFF9FAFB),
//   colorScheme: ColorScheme.light(
//     primary: const Color(0xFF4A90E2),
//     secondary: const Color(0xFFFFA726),
//     tertiary: const Color(0xFF66BB6A),
//   ),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF4A90E2),
//     foregroundColor: Colors.white,
//     elevation: 4,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xFF4A90E2),
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//     ),
//   ),
//   cardTheme: CardThemeData(
//     color: Colors.white,
//     elevation: 3,
//     shadowColor: Colors.black26,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   ),
//   progressIndicatorTheme: const ProgressIndicatorThemeData(
//     color: Color(0xFFFFA726),
//   ),
// );

// /// Dark Theme – Sleek & Modern Neon
// final darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: const Color(0xFF1E88E5),
//   scaffoldBackgroundColor: const Color(0xFF121212),
//   colorScheme: ColorScheme.dark(
//     primary: const Color(0xFF1E88E5),
//     secondary: const Color(0xFFFF7043),
//     tertiary: const Color(0xFF81C784),
//   ),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF1E88E5),
//     foregroundColor: Colors.white,
//     elevation: 4,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xFF1E88E5),
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//     ),
//   ),
//   cardTheme: CardThemeData(
//     color: const Color(0xFF1E1E1E),
//     elevation: 3,
//     shadowColor: Colors.black54,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   ),
//   progressIndicatorTheme: const ProgressIndicatorThemeData(
//     color: Color(0xFFFF7043),
//   ),
// );

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latexquiz_rubizcode/main.dart';

/// Theme mode provider (Light / Dark / System)
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final context = globalNavigatorKey.currentContext;

  if (context == null) {
    return ThemeMode.light;
  }

  final brightness = MediaQuery.platformBrightnessOf(context);

  if (brightness == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

/// Light Theme - Modern & Vibrant
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF6C63FF), // Vibrant purple
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6C63FF),
    secondary: Color(0xFFFF6584), // Energetic pink
    tertiary: Color(0xFF42A5F5), // Calming blue
    surface: Colors.white,
    error: Color(0xFFEF5350),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF2A2D3E),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF6C63FF)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF6C63FF),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6C63FF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      shadowColor: Colors.black12,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6C63FF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF2A2D3E),
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF2A2D3E)),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black87),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  ),
);

/// Dark Theme - Deep & Modern
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF7B4DFF), // Brighter purple
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF7B4DFF),
    secondary: Color(0xFFFF7096), // Softer pink
    tertiary: Color(0xFF64B5F6), // Brighter blue
    surface: Color(0xFF1E1E1E),
    error: Color(0xFFEF5350),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF7B4DFF)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF7B4DFF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black38,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF7B4DFF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  ),
  cardTheme: const CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 4,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
);
