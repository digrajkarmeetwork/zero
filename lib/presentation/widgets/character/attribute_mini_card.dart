import 'package:flutter/material.dart';

import '../../../core/constants/attribute_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Mini attribute card for grid display
class AttributeMiniCard extends StatelessWidget {
  const AttributeMiniCard({
    super.key,
    required this.type,
    required this.level,
    required this.progress,
    this.todayXp = 0,
  });

  final AttributeType type;
  final int level;
  final double progress;
  final int todayXp;

  @override
  Widget build(BuildContext context) {
    final color = AttributeColors.forAttribute(type);
    final icon = AttributeColors.iconForAttribute(type);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon and level
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Text(
                'Lv.$level',
                style: AppTypography.labelMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Attribute name
          Text(
            type.shortName,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundTertiary,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 4,
            ),
          ),

          if (todayXp > 0) ...[
            const SizedBox(height: 4),
            Text(
              '+$todayXp',
              style: AppTypography.labelSmall.copyWith(
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
