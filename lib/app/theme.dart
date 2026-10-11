import 'package:flutter/material.dart';

/// Design tokens Flyer (Sprint 0).
///
/// Palette chaleureuse (orange « flash » + vert profond) pensée pour un usage
/// mobile à une main et des visuels d'événements animaliers. Les tokens sont
/// la source de vérité pour l'app ET pour les visuels générés côté serveur
/// (voir `docs/08-design-tokens-et-maquettes-s1.md`).
abstract final class FlyerColors {
  // Marque
  static const Color primary = Color(0xFFE8632B); // orange flash
  static const Color secondary = Color(0xFF1F5F5B); // vert profond
  static const Color tertiary = Color(0xFFF2B33D); // jaune doré
  static const Color surface = Color(0xFFFFFBF7);
  static const Color ink = Color(0xFF1D1B19); // texte principal

  // Sémantique (statuts d'event, de besoin, de publication)
  static const Color success = Color(0xFF2E8B57); // fourni / publié
  static const Color warning = Color(
    0xFFD98E04,
  ); // généré, à relire / programmé
  static const Color danger = Color(0xFFC63C2E); // manquant / échec
  static const Color neutral = Color(0xFF8A8580); // brouillon / archivé
}

abstract final class FlyerSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Hauteur minimale des zones tactiles (Material / Apple HIG).
  static const double touchTarget = 48;
}

abstract final class FlyerRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;
}

abstract final class FlyerDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
}

/// Échelle typographique (Material 3, police système pour l'instant ;
/// une police de marque pourra être injectée via `fontFamily`).
abstract final class FlyerTypography {
  static const TextTheme textTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      height: 1.15,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14, height: 1.5),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
    ),
  );
}

/// Couleurs sémantiques exposées via `Theme.of(context).extension<FlyerSemanticColors>()`.
@immutable
class FlyerSemanticColors extends ThemeExtension<FlyerSemanticColors> {
  const FlyerSemanticColors({
    required this.success,
    required this.warning,
    required this.danger,
    required this.neutral,
  });

  final Color success;
  final Color warning;
  final Color danger;
  final Color neutral;

  static const light = FlyerSemanticColors(
    success: FlyerColors.success,
    warning: FlyerColors.warning,
    danger: FlyerColors.danger,
    neutral: FlyerColors.neutral,
  );

  static const dark = FlyerSemanticColors(
    success: Color(0xFF6CCB8E),
    warning: Color(0xFFF2B33D),
    danger: Color(0xFFF0776A),
    neutral: Color(0xFFB5AFA9),
  );

  @override
  FlyerSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? neutral,
  }) {
    return FlyerSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  FlyerSemanticColors lerp(FlyerSemanticColors? other, double t) {
    if (other == null) return this;
    return FlyerSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
    );
  }
}

extension FlyerThemeX on ThemeData {
  FlyerSemanticColors get semantic =>
      extension<FlyerSemanticColors>() ?? FlyerSemanticColors.light;
}

abstract final class FlyerTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: FlyerColors.primary,
      secondary: FlyerColors.secondary,
      tertiary: FlyerColors.tertiary,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: FlyerTypography.textTheme,
      visualDensity: VisualDensity.standard,
      extensions: [
        isDark ? FlyerSemanticColors.dark : FlyerSemanticColors.light,
      ],
      appBarTheme: const AppBarTheme(centerTitle: false),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FlyerRadius.md),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: FlyerSpacing.md,
          vertical: FlyerSpacing.md,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(FlyerSpacing.touchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FlyerRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(FlyerSpacing.touchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FlyerRadius.md),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FlyerRadius.pill),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FlyerRadius.lg),
        ),
      ),
    );
  }
}
