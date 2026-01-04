import 'package:equatable/equatable.dart';
import '../../core/constants/attribute_constants.dart';

/// Quest type enumeration
enum QuestType {
  daily('Daily'),
  weekly('Weekly'),
  epic('Epic'),
  legendary('Legendary');

  const QuestType(this.displayName);
  final String displayName;
}

/// Quest requirement type
enum QuestRequirementType {
  completeActivities,
  earnAttributeXp,
  maintainStreak,
  logDifferentTypes,
  custom,
}

/// Quest requirement
class QuestRequirement extends Equatable {
  const QuestRequirement({
    required this.type,
    required this.target,
    this.attribute,
    this.description,
  });

  final QuestRequirementType type;
  final int target;
  final AttributeType? attribute;
  final String? description;

  @override
  List<Object?> get props => [type, target, attribute, description];
}

/// Quest reward
class QuestReward extends Equatable {
  const QuestReward({
    required this.xp,
    this.attribute,
    this.title,
  });

  final int xp;
  final AttributeType? attribute;
  final String? title;

  @override
  List<Object?> get props => [xp, attribute, title];
}

/// Quest entity
class Quest extends Equatable {
  const Quest({
    required this.id,
    required this.title,
    required this.type,
    required this.requirements,
    required this.reward,
    this.description,
    this.startsAt,
    this.expiresAt,
    this.isActive = true,
  });

  final String id;
  final String title;
  final String? description;
  final QuestType type;
  final List<QuestRequirement> requirements;
  final QuestReward reward;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final bool isActive;

  /// Check if quest is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        requirements,
        reward,
        startsAt,
        expiresAt,
        isActive,
      ];
}

/// User quest status
enum UserQuestStatus {
  active,
  completed,
  claimed,
  expired,
}

/// User's progress on a quest
class UserQuest extends Equatable {
  const UserQuest({
    required this.id,
    required this.userId,
    required this.quest,
    required this.progress,
    this.status = UserQuestStatus.active,
    this.completedAt,
    this.claimedAt,
    this.assignedAt,
  });

  final String id;
  final String userId;
  final Quest quest;
  final List<int> progress; // Progress for each requirement
  final UserQuestStatus status;
  final DateTime? completedAt;
  final DateTime? claimedAt;
  final DateTime? assignedAt;

  /// Check if all requirements are met
  bool get isComplete {
    if (progress.length != quest.requirements.length) return false;
    for (int i = 0; i < progress.length; i++) {
      if (progress[i] < quest.requirements[i].target) return false;
    }
    return true;
  }

  /// Overall progress (0.0 - 1.0)
  double get overallProgress {
    if (quest.requirements.isEmpty) return 0.0;
    double total = 0.0;
    for (int i = 0; i < quest.requirements.length; i++) {
      final target = quest.requirements[i].target;
      final current = i < progress.length ? progress[i] : 0;
      total += (current / target).clamp(0.0, 1.0);
    }
    return total / quest.requirements.length;
  }

  UserQuest copyWith({
    String? id,
    String? userId,
    Quest? quest,
    List<int>? progress,
    UserQuestStatus? status,
    DateTime? completedAt,
    DateTime? claimedAt,
    DateTime? assignedAt,
  }) {
    return UserQuest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      quest: quest ?? this.quest,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      claimedAt: claimedAt ?? this.claimedAt,
      assignedAt: assignedAt ?? this.assignedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        quest,
        progress,
        status,
        completedAt,
        claimedAt,
        assignedAt,
      ];
}
