import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/attribute_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/character/character_bloc.dart';
import '../../widgets/character/power_level_card.dart';
import '../../widgets/character/attribute_mini_card.dart';
import '../../widgets/character/streak_indicator.dart';
import '../../widgets/common/zero_card.dart';

/// Home screen - main dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadCharacter();
  }

  void _loadCharacter() {
    final userId = context.read<AuthBloc>().state.user.id;
    context.read<CharacterBloc>().add(CharacterLoadRequested(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state.status == CharacterStatus.loading ||
                state.status == CharacterStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state.status == CharacterStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load character',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _loadCharacter,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final character = state.character;
            if (character == null) {
              return const Center(
                child: Text('No character found'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                _loadCharacter();
              },
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ZERO',
                              style: AppTypography.headlineMedium.copyWith(
                                letterSpacing: 4,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'Welcome back',
                              style: AppTypography.bodyMedium,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: AppColors.textSecondary,
                          onPressed: () {
                            // TODO: Notifications
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Power Level Card
                    PowerLevelCard(
                      powerLevel: character.powerLevel,
                      rank: character.rank,
                      progress: character.rankProgress,
                      title: character.equippedTitle,
                    ),

                    const SizedBox(height: 24),

                    // Today's Progress
                    Text(
                      "Today's Progress",
                      style: AppTypography.headlineSmall,
                    ),

                    const SizedBox(height: 12),

                    // Attribute mini cards grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.0,
                      children: AttributeType.values.map((type) {
                        final attr = character.getAttribute(type);
                        return AttributeMiniCard(
                          type: type,
                          level: attr.level,
                          progress: attr.progressToNextLevel,
                          todayXp: 0, // TODO: Calculate from today's activities
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Streak
                    StreakIndicator(
                      currentStreak: character.currentStreak,
                      longestStreak: character.longestStreak,
                    ),

                    const SizedBox(height: 24),

                    // Daily Quests Preview
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Quests',
                          style: AppTypography.headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to quests
                          },
                          child: Text(
                            'View All',
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Quest placeholder
                    ZeroCard(
                      child: Column(
                        children: [
                          _QuestItem(
                            title: 'Complete 3 activities',
                            progress: 0,
                            target: 3,
                            reward: 50,
                          ),
                          const Divider(color: AppColors.border),
                          _QuestItem(
                            title: 'Earn 50 Vitality XP',
                            progress: 0,
                            target: 50,
                            reward: 30,
                          ),
                          const Divider(color: AppColors.border),
                          _QuestItem(
                            title: 'Maintain your streak',
                            progress: character.currentStreak > 0 ? 1 : 0,
                            target: 1,
                            reward: 25,
                            isComplete: character.currentStreak > 0,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quick Log
                    Text(
                      'Quick Log',
                      style: AppTypography.headlineSmall,
                    ),

                    const SizedBox(height: 12),

                    // Quick log buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _QuickLogButton(
                            icon: Icons.fitness_center,
                            label: 'Workout',
                            color: AttributeColors.vitality,
                            xp: 25,
                            onTap: () {
                              // TODO: Quick log workout
                            },
                          ),
                          const SizedBox(width: 12),
                          _QuickLogButton(
                            icon: Icons.menu_book,
                            label: 'Read',
                            color: AttributeColors.intellect,
                            xp: 15,
                            onTap: () {
                              // TODO: Quick log reading
                            },
                          ),
                          const SizedBox(width: 12),
                          _QuickLogButton(
                            icon: Icons.savings,
                            label: 'Save',
                            color: AttributeColors.prosperity,
                            xp: 20,
                            onTap: () {
                              // TODO: Quick log saving
                            },
                          ),
                          const SizedBox(width: 12),
                          _QuickLogButton(
                            icon: Icons.directions_walk,
                            label: 'Walk',
                            color: AttributeColors.agility,
                            xp: 10,
                            onTap: () {
                              // TODO: Quick log walk
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100), // Bottom padding for nav bar
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _QuestItem extends StatelessWidget {
  const _QuestItem({
    required this.title,
    required this.progress,
    required this.target,
    required this.reward,
    this.isComplete = false,
  });

  final String title;
  final int progress;
  final int target;
  final int reward;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (progress / target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Checkbox
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isComplete ? AppColors.success : Colors.transparent,
              border: Border.all(
                color: isComplete ? AppColors.success : AppColors.border,
                width: 2,
              ),
            ),
            child: isComplete
                ? const Icon(
                    Icons.check,
                    color: AppColors.backgroundPrimary,
                    size: 16,
                  )
                : null,
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: isComplete
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                    decoration:
                        isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progressPercent,
                  backgroundColor: AppColors.backgroundTertiary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isComplete ? AppColors.success : AppColors.primary,
                  ),
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Reward
          if (isComplete)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'CLAIM',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.success,
                ),
              ),
            )
          else
            Text(
              '+$reward XP',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
        ],
      ),
    );
  }
}

class _QuickLogButton extends StatelessWidget {
  const _QuickLogButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.xp,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final int xp;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '+$xp',
              style: AppTypography.labelSmall.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
