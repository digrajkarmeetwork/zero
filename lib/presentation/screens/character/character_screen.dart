import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/attribute_constants.dart';
import '../../../core/constants/rank_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/character/character_bloc.dart';
import '../../widgets/common/zero_card.dart';

/// Character detail screen
class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Character'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.loading ||
              state.character == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final character = state.character!;
          final rank = character.rank;
          final rankColor = RankColors.forRank(rank);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Avatar with aura
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: RankColors.gradientForRank(rank).take(2).toList(),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: rankColor.withValues(alpha: 0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundSecondary,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 56,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                if (character.equippedTitle != null)
                  Text(
                    '"${character.equippedTitle}"',
                    style: AppTypography.titleMedium.copyWith(
                      color: rankColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                const SizedBox(height: 8),

                // Rank badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: RankColors.gradientForRank(rank).take(2).toList(),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${rank.displayName} Rank',
                    style: AppTypography.labelLarge.copyWith(
                      color: rank.tier <= 3
                          ? AppColors.textPrimary
                          : AppColors.backgroundPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Power Level
                ZeroCard(
                  child: Column(
                    children: [
                      Text(
                        'POWER LEVEL',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        character.powerLevel.toString(),
                        style: AppTypography.statNumber.copyWith(
                          fontSize: 56,
                          color: rankColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${character.powerLevelToNextRank} to next rank',
                        style: AppTypography.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: character.rankProgress,
                        backgroundColor: AppColors.backgroundTertiary,
                        valueColor: AlwaysStoppedAnimation<Color>(rankColor),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Attributes
                Text(
                  'Attributes',
                  style: AppTypography.headlineSmall,
                ),

                const SizedBox(height: 12),

                ...AttributeType.values.map((type) {
                  final attr = character.getAttribute(type);
                  final color = AttributeColors.forAttribute(type);
                  final icon = AttributeColors.iconForAttribute(type);
                  final isPrimary = type == character.buildPath.primaryAttribute;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ZeroCard(
                      isHighlighted: isPrimary,
                      highlightColor: color,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(icon, color: color, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          type.displayName,
                                          style: AppTypography.titleMedium,
                                        ),
                                        if (isPrimary) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: color.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '+20%',
                                              style: AppTypography.labelSmall.copyWith(
                                                color: color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      type.description,
                                      style: AppTypography.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Level ${attr.level}',
                                    style: AppTypography.titleLarge.copyWith(
                                      color: color,
                                    ),
                                  ),
                                  Text(
                                    '${attr.totalXp} XP',
                                    style: AppTypography.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: attr.progressToNextLevel,
                                  backgroundColor: AppColors.backgroundTertiary,
                                  valueColor: AlwaysStoppedAnimation<Color>(color),
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${attr.xpToNextLevel} to Lv.${attr.level + 1}',
                                style: AppTypography.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Build Path
                ZeroCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.route,
                        color: AttributeColors.forAttribute(
                          character.buildPath.primaryAttribute,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Build Path',
                              style: AppTypography.bodySmall,
                            ),
                            Text(
                              character.buildPath.displayName,
                              style: AppTypography.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Change build path
                        },
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}
