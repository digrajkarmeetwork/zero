import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../widgets/common/zero_card.dart';

/// Quests screen
class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Quests'),
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Epic'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DailyQuestsTab(),
          _WeeklyQuestsTab(),
          _EpicQuestsTab(),
        ],
      ),
    );
  }
}

class _DailyQuestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timer
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: AppColors.textSecondary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Resets in 8 hours',
                style: AppTypography.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Quests
          _QuestCard(
            title: 'Complete 3 activities',
            description: 'Log any 3 activities today',
            progress: 0,
            target: 3,
            xpReward: 50,
          ),

          const SizedBox(height: 12),

          _QuestCard(
            title: 'Earn 50 Vitality XP',
            description: 'Do physical activities',
            progress: 0,
            target: 50,
            xpReward: 30,
          ),

          const SizedBox(height: 12),

          _QuestCard(
            title: 'Maintain your streak',
            description: 'Log at least 1 activity',
            progress: 0,
            target: 1,
            xpReward: 25,
          ),

          const SizedBox(height: 12),

          _QuestCard(
            title: 'Log 2 different types',
            description: 'Diversify your activities',
            progress: 0,
            target: 2,
            xpReward: 40,
          ),
        ],
      ),
    );
  }
}

class _WeeklyQuestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: AppColors.textSecondary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Resets Monday',
                style: AppTypography.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _QuestCard(
            title: 'Workout 4 times',
            description: 'Stay consistent with fitness',
            progress: 0,
            target: 4,
            xpReward: 150,
          ),

          const SizedBox(height: 12),

          _QuestCard(
            title: 'Earn 500 total XP',
            description: 'Across all attributes',
            progress: 0,
            target: 500,
            xpReward: 100,
          ),

          const SizedBox(height: 12),

          _QuestCard(
            title: '7 day streak',
            description: 'Log activities every day',
            progress: 0,
            target: 7,
            xpReward: 200,
          ),
        ],
      ),
    );
  }
}

class _EpicQuestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Epic Quests',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Reach Steel Rank to unlock month-long epic challenges',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestCard extends StatelessWidget {
  const _QuestCard({
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.xpReward,
  });

  final String title;
  final String description;
  final int progress;
  final int target;
  final int xpReward;

  @override
  Widget build(BuildContext context) {
    final isComplete = progress >= target;
    final progressPercent = (progress / target).clamp(0.0, 1.0);

    return ZeroCard(
      isHighlighted: isComplete,
      highlightColor: AppColors.success,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              if (isComplete)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'CLAIM',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.backgroundPrimary,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+$xpReward XP',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progressPercent,
                  backgroundColor: AppColors.backgroundTertiary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isComplete ? AppColors.success : AppColors.primary,
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$progress / $target',
                style: AppTypography.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
