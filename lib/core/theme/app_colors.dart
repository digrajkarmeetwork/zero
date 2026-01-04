import 'package:flutter/material.dart';

/// App color palette - "Neon RPG" design language
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color backgroundPrimary = Color(0xFF0A0A0F);
  static const Color backgroundSecondary = Color(0xFF12121A);
  static const Color backgroundTertiary = Color(0xFF1A1A25);
  static const Color surface = Color(0xFF12121A);
  static const Color surfaceElevated = Color(0xFF1E1E2A);

  // Primary accent - Electric blue
  static const Color primary = Color(0xFF00D4FF);
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color primaryLight = Color(0xFF66E5FF);

  // Secondary accent - Gold
  static const Color secondary = Color(0xFFFFD700);
  static const Color secondaryDark = Color(0xFFCCAA00);
  static const Color secondaryLight = Color(0xFFFFE44D);

  // Semantic colors
  static const Color success = Color(0xFF00FF88);
  static const Color successDark = Color(0xFF00CC6A);
  static const Color warning = Color(0xFFFFB800);
  static const Color warningDark = Color(0xFFCC9300);
  static const Color error = Color(0xFFFF4757);
  static const Color errorDark = Color(0xFFCC3945);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0B0);
  static const Color textTertiary = Color(0xFF606070);
  static const Color textDisabled = Color(0xFF404050);

  // Border colors
  static const Color border = Color(0xFF2A2A35);
  static const Color borderLight = Color(0x0DFFFFFF); // 5% white
  static const Color borderFocused = primary;

  // Glow effects
  static const Color glowPrimary = Color(0x4D00D4FF); // 30% primary
  static const Color glowSuccess = Color(0x4D00FF88);
  static const Color glowWarning = Color(0x4DFFB800);
  static const Color glowError = Color(0x4DFF4757);
  static const Color glowGold = Color(0x4DFFD700);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF00CC88)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [backgroundSecondary, Color(0xFF0F0F17)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
