import 'package:flutter/material.dart';

/// CyberShield AI color system
class AppColors {
  AppColors._();

  // Brand
  static const Color brandNavy = Color(0xFF0B1F3A);
  static const Color brandCyan = Color(0xFF00E5FF);
  static const Color trustWhite = Color(0xFFF5F9FC);

  // Semantic
  static const Color safeGreen = Color(0xFF2ED573);
  static const Color warningAmber = Color(0xFFFFC107);
  static const Color threatRed = Color(0xFFFF3B3B);

  // Neutral text and UI
  static const Color mutedSteel = Color(0xFF8A94A6);
  static const Color textPrimary = Color(0xFF0B1220);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFD9E3EE);
  static const Color surfaceAlt = Color(0xFFEEF4FA);
  static const Color card = Color(0xFFFFFFFF);
  static const Color disabled = Color(0xFFE3EAF2);

  // Overlays
  static const Color overlay = Color(0x990B1F3A);

  // Gradients
  static const Color splashStart = Color(0xFF07152A);
  static const Color splashEnd = Color(0xFF0B1F3A);
}

enum DetectionStatus { safe, suspicious, threat }

extension DetectionStatusColor on DetectionStatus {
  Color get color {
    switch (this) {
      case DetectionStatus.safe:
        return AppColors.safeGreen;
      case DetectionStatus.suspicious:
        return AppColors.warningAmber;
      case DetectionStatus.threat:
        return AppColors.threatRed;
    }
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandCyan,
      brightness: Brightness.light,
      primary: AppColors.brandCyan,
      secondary: AppColors.brandNavy,
      surface: AppColors.trustWhite,
      error: AppColors.threatRed,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.trustWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.brandNavy,
        foregroundColor: AppColors.textOnDark,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        hintStyle: const TextStyle(color: AppColors.mutedSteel),
        labelStyle: const TextStyle(color: AppColors.mutedSteel),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.brandCyan, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.threatRed),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.threatRed, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandCyan,
          foregroundColor: AppColors.textPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.mutedSteel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brandCyan,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.brandNavy,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.brandNavy,
        contentTextStyle: TextStyle(color: AppColors.textOnDark),
      ),
    );
  }
}
