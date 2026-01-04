import 'package:flutter/material.dart';

import '../../../core/constants/rank_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../common/zero_card.dart';

/// Power level display card
class PowerLevelCard extends StatelessWidget {
  const PowerLevelCard({
    super.key,
    required this.powerLevel,
    required this.rank,
    required this.progress,
    this.title,
  });

  final int powerLevel;
  final Rank rank;
  final double progress;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final rankColor = RankColors.forRank(rank);
    final gradient = RankColors.gradientForRank(rank);

    return ZeroCard(
      isHighlighted: true,
      highlightColor: rankColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Avatar and info row
          Row(
            children: [
              // Avatar with aura
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: gradient.length > 2
                        ? gradient.take(2).toList()
                        : gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: rankColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backgroundSecondary,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        '"$title"',
                        style: AppTypography.labelMedium.copyWith(
                          color: rankColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradient.length > 2
                                  ? gradient.take(2).toList()
                                  : gradient,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            rank.displayName.toUpperCase(),
                            style: AppTypography.rankTitle.copyWith(
                              color: rank.tier <= 3
                                  ? AppColors.textPrimary
                                  : AppColors.backgroundPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Rank ${rank.tier}',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Power level display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'POWER LEVEL',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            powerLevel.toString(),
            style: AppTypography.statNumber.copyWith(
              fontSize: 48,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // Progress to next rank
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to ${_getNextRankName(rank)}',
                    style: AppTypography.bodySmall,
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: AppTypography.labelSmall.copyWith(
                      color: rankColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.backgroundTertiary,
                  valueColor: AlwaysStoppedAnimation<Color>(rankColor),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${rank.minPowerLevel}',
                    style: AppTypography.labelSmall,
                  ),
                  Text(
                    '${rank.maxPowerLevel + 1}',
                    style: AppTypography.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getNextRankName(Rank current) {
    final index = Rank.values.indexOf(current);
    if (index >= Rank.values.length - 1) {
      return 'MAX';
    }
    return Rank.values[index + 1].displayName;
  }
}
