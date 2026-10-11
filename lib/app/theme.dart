import 'package:flutter/material.dart';

/// Design tokens Flyer.
///
/// Palette chaleureuse (orange « flash » + vert profond) pensée pour un usage
/// mobile à une main et des visuels d'événements animaliers.
abstract final class FlyerColors {
  static const Color primary = Color(0xFFE8632B); // orange flash
  static const Color secondary = Color(0xFF1F5F5B); // vert profond
  static const Color tertiary = Color(0xFFF2B33D); // jaune doré
  static const Color surface = Color(0xFFFFFBF7);
}

abstract final class FlyerSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

abstract final class FlyerTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: FlyerColors.primary,
      secondary: FlyerColors.secondary,
      tertiary: FlyerColors.tertiary,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: const AppBarTheme(centerTitle: false),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
