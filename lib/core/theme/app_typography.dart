import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App typography using Google Fonts fallback
class AppTypography {
  AppTypography._();

  // Using system fonts as fallback (Google Fonts can be added later)
  static const String _displayFont = 'Rajdhani';
  static const String _bodyFont = 'Inter';

  // Display styles (for headlines, stats, ranks)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _displayFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _displayFont,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _displayFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _displayFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _displayFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _displayFont,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Label styles (buttons, tabs)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  // Special styles
  static const TextStyle statNumber = TextStyle(
    fontFamily: _displayFont,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 1,
  );

  static const TextStyle xpGain = TextStyle(
    fontFamily: _displayFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
    letterSpacing: 0.5,
  );

  static const TextStyle rankTitle = TextStyle(
    fontFamily: _displayFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
  );
}
