import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/auth/auth_bloc.dart';

/// Splash screen with animated logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check auth state after a brief delay for animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        context.read<AuthBloc>().add(const AuthCheckRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.glowPrimary,
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '0',
                  style: AppTypography.displayLarge.copyWith(
                    fontSize: 64,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // App name
            Text(
              'ZERO',
              style: AppTypography.displayLarge.copyWith(
                letterSpacing: 8,
                color: AppColors.textPrimary,
              ),
            )
                .animate(delay: 300.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'From Zero to Legendary',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1,
              ),
            )
                .animate(delay: 500.ms)
                .fadeIn(duration: 500.ms),

            const SizedBox(height: 60),

            // Loading indicator
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
                .animate(delay: 800.ms)
                .fadeIn(duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
