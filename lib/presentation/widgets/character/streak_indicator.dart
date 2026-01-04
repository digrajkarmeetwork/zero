import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../common/zero_card.dart';

/// Streak indicator widget
class StreakIndicator extends StatelessWidget {
  const StreakIndicator({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
  });

  final int currentStreak;
  final int longestStreak;

  @override
  Widget build(BuildContext context) {
    final isActive = currentStreak > 0;
    final color = isActive ? AppColors.warning : AppColors.textTertiary;

    return ZeroCard(
      isHighlighted: isActive,
      highlightColor: color,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Fire icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? Icons.local_fire_department : Icons.local_fire_department_outlined,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Streak info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$currentStreak Day Streak',
                      style: AppTypography.titleMedium.copyWith(
                        color: isActive ? color : AppColors.textPrimary,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8),
                      Text(
                        '!',
                        style: AppTypography.titleMedium.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isActive
                      ? 'Keep it going! Log an activity to maintain.'
                      : 'Start a streak by logging activities daily.',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),

          // Longest streak badge
          if (longestStreak > 0)
            Column(
              children: [
                Text(
                  'Best',
                  style: AppTypography.labelSmall,
                ),
                Text(
                  '$longestStreak',
                  style: AppTypography.headlineMedium.copyWith(
                    color: currentStreak >= longestStreak && isActive
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
