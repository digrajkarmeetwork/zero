import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/attribute_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/character/character_bloc.dart';
import '../../widgets/common/zero_card.dart';

/// Predefined activities for quick logging
class QuickActivity {
  final String name;
  final IconData icon;
  final AttributeType attribute;
  final int baseXp;
  final String description;

  const QuickActivity({
    required this.name,
    required this.icon,
    required this.attribute,
    required this.baseXp,
    required this.description,
  });
}

const List<QuickActivity> _quickActivities = [
  // Vitality
  QuickActivity(
    name: 'Gym Workout',
    icon: Icons.fitness_center,
    attribute: AttributeType.vitality,
    baseXp: 30,
    description: 'Weight training session',
  ),
  QuickActivity(
    name: 'Cardio',
    icon: Icons.directions_run,
    attribute: AttributeType.vitality,
    baseXp: 25,
    description: 'Running, cycling, etc.',
  ),
  QuickActivity(
    name: 'Healthy Meal',
    icon: Icons.restaurant,
    attribute: AttributeType.vitality,
    baseXp: 10,
    description: 'Ate nutritious food',
  ),
  QuickActivity(
    name: 'Good Sleep',
    icon: Icons.bedtime,
    attribute: AttributeType.vitality,
    baseXp: 20,
    description: '7-8 hours of sleep',
  ),

  // Intellect
  QuickActivity(
    name: 'Reading',
    icon: Icons.menu_book,
    attribute: AttributeType.intellect,
    baseXp: 20,
    description: 'Read books or articles',
  ),
  QuickActivity(
    name: 'Learning',
    icon: Icons.school,
    attribute: AttributeType.intellect,
    baseXp: 30,
    description: 'Course or tutorial',
  ),
  QuickActivity(
    name: 'Problem Solving',
    icon: Icons.psychology,
    attribute: AttributeType.intellect,
    baseXp: 25,
    description: 'Puzzles, coding, etc.',
  ),

  // Prosperity
  QuickActivity(
    name: 'Saved Money',
    icon: Icons.savings,
    attribute: AttributeType.prosperity,
    baseXp: 25,
    description: 'Put money in savings',
  ),
  QuickActivity(
    name: 'Side Hustle',
    icon: Icons.work,
    attribute: AttributeType.prosperity,
    baseXp: 35,
    description: 'Extra income work',
  ),
  QuickActivity(
    name: 'Investment',
    icon: Icons.trending_up,
    attribute: AttributeType.prosperity,
    baseXp: 30,
    description: 'Invested in assets',
  ),

  // Agility
  QuickActivity(
    name: 'Morning Routine',
    icon: Icons.wb_sunny,
    attribute: AttributeType.agility,
    baseXp: 15,
    description: 'Completed morning routine',
  ),
  QuickActivity(
    name: 'Task Completed',
    icon: Icons.task_alt,
    attribute: AttributeType.agility,
    baseXp: 10,
    description: 'Finished a task on time',
  ),
  QuickActivity(
    name: 'No Procrastination',
    icon: Icons.timer,
    attribute: AttributeType.agility,
    baseXp: 20,
    description: 'Stayed focused all day',
  ),

  // Charisma
  QuickActivity(
    name: 'Networking',
    icon: Icons.people,
    attribute: AttributeType.charisma,
    baseXp: 25,
    description: 'Met new people',
  ),
  QuickActivity(
    name: 'Helped Someone',
    icon: Icons.volunteer_activism,
    attribute: AttributeType.charisma,
    baseXp: 20,
    description: 'Acts of kindness',
  ),
  QuickActivity(
    name: 'Public Speaking',
    icon: Icons.record_voice_over,
    attribute: AttributeType.charisma,
    baseXp: 35,
    description: 'Presented or spoke publicly',
  ),
];

/// Log activity screen
class LogActivityScreen extends StatefulWidget {
  const LogActivityScreen({super.key});

  @override
  State<LogActivityScreen> createState() => _LogActivityScreenState();
}

class _LogActivityScreenState extends State<LogActivityScreen> {
  AttributeType? _selectedCategory;
  bool _isLogging = false;

  List<QuickActivity> get _filteredActivities {
    if (_selectedCategory == null) {
      return _quickActivities;
    }
    return _quickActivities
        .where((a) => a.attribute == _selectedCategory)
        .toList();
  }

  Future<void> _logActivity(QuickActivity activity) async {
    setState(() => _isLogging = true);

    try {
      final characterBloc = context.read<CharacterBloc>();

      // Add XP for this activity
      characterBloc.add(CharacterXpAdded(
        attribute: activity.attribute,
        amount: activity.baseXp,
      ));

      // Show success feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(activity.icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${activity.name} logged! +${activity.baseXp} ${activity.attribute.shortName} XP',
                  ),
                ),
              ],
            ),
            backgroundColor: AttributeColors.forAttribute(activity.attribute),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

        // Go back after logging
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to log activity: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLogging = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Log Activity'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: _isLogging
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 16),
                  Text('Logging activity...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category filter
                  Text(
                    'Filter by Attribute',
                    style: AppTypography.labelMedium,
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _CategoryChip(
                          label: 'All',
                          isSelected: _selectedCategory == null,
                          onTap: () =>
                              setState(() => _selectedCategory = null),
                        ),
                        const SizedBox(width: 8),
                        ...AttributeType.values.map((type) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _CategoryChip(
                              label: type.shortName,
                              color: AttributeColors.forAttribute(type),
                              isSelected: _selectedCategory == type,
                              onTap: () =>
                                  setState(() => _selectedCategory = type),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Activities grid
                  Text(
                    'Quick Activities',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to log and earn XP',
                    style: AppTypography.bodySmall,
                  ),

                  const SizedBox(height: 16),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: _filteredActivities.length,
                    itemBuilder: (context, index) {
                      final activity = _filteredActivities[index];
                      return _ActivityCard(
                        activity: activity,
                        onTap: () => _logActivity(activity),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : chipColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: chipColor.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? Colors.white : chipColor,
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.activity,
    required this.onTap,
  });

  final QuickActivity activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AttributeColors.forAttribute(activity.attribute);

    return ZeroCard(
      onTap: onTap,
      isHighlighted: false,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity.icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            activity.name,
            style: AppTypography.labelLarge,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '+${activity.baseXp} XP',
              style: AppTypography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
