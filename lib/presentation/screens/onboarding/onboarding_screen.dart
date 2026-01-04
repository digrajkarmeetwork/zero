import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../widgets/common/zero_button.dart';

/// Onboarding screen with intro slides
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.trending_up,
      title: 'Level Up Your Life',
      description:
          'Transform everyday activities into experience points. Watch yourself grow from Zero to Legendary.',
    ),
    _OnboardingPage(
      icon: Icons.auto_graph,
      title: 'Track Every Dimension',
      description:
          'Build your character across 5 attributes: Vitality, Intellect, Prosperity, Agility, and Charisma.',
    ),
    _OnboardingPage(
      icon: Icons.emoji_events,
      title: 'Compete & Conquer',
      description:
          'Join guilds, challenge rivals, and climb the leaderboards. Your journey is just beginning.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutes.characterCreation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go(AppRoutes.characterCreation),
                child: Text(
                  'Skip',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primary
                        : AppColors.backgroundTertiary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ZeroButton(
                onPressed: _nextPage,
                label: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Continue',
                width: double.infinity,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              page.icon,
              size: 56,
              color: AppColors.primary,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOut,
              )
              .fadeIn(duration: 300.ms),

          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style: AppTypography.displaySmall,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 100.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 200.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
