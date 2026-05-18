import 'package:flutter/material.dart';

class AppColors {
  // Primary purple gradient colors
  static const Color primaryPurple = Color(0xFF6B5CE7);
  static const Color lightPurple = Color(0xFF9B8FF5);
  static const Color softPurple = Color(0xFFEEEBFF);

  // Accent
  static const Color accentViolet = Color(0xFF8B6FE8);

  // Neutrals
  static const Color backgroundWhite = Color(0xFFF8F8FC);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color textMedium = Color(0xFF555566);
  static const Color dividerColor = Color(0xFFEEEEF5);

  // Status
  static const Color successGreen = Color(0xFF4CAF7D);
  static const Color warningOrange = Color(0xFFFF8C42);
  static const Color errorRed = Color(0xFFE53935);

  // Gradient presets
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6B5CE7), Color(0xFF9B8FF5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient1 = LinearGradient(
    colors: [Color(0xFF6B5CE7), Color(0xFF8B6FE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    colors: [Color(0xFF9B59B6), Color(0xFFAA7FE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMedium,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static const TextStyle labelBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: 0.3,
  );

  static const TextStyle amountLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.3,
  );

  static const TextStyle amountSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle cardLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 100.0;
}

class AppShadows {
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.primaryPurple.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}