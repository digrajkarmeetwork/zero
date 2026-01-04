import 'package:equatable/equatable.dart';
import '../../core/constants/attribute_constants.dart';
import '../../core/constants/rank_constants.dart';
import 'attribute.dart';

/// Character entity representing user's game progress
class Character extends Equatable {
  const Character({
    required this.userId,
    required this.attributes,
    this.buildPath = BuildPath.warrior,
    this.equippedTitle,
    this.titles = const [],
    this.achievements = const [],
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActivityDate,
    this.createdAt,
    this.updatedAt,
  });

  final String userId;
  final Map<AttributeType, Attribute> attributes;
  final BuildPath buildPath;
  final String? equippedTitle;
  final List<String> titles;
  final List<String> achievements;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Calculate total power level from all attributes
  int get powerLevel {
    int total = 0;
    for (final attr in attributes.values) {
      total += attr.level;
    }
    return total;
  }

  /// Get current rank based on power level
  Rank get rank => Rank.fromPowerLevel(powerLevel);

  /// Progress to next rank (0.0 - 1.0)
  double get rankProgress => rank.progressToNext(powerLevel);

  /// Power level needed for next rank
  int get powerLevelToNextRank => rank.powerLevelForNextRank - powerLevel;

  /// Get total XP across all attributes
  int get totalXp {
    int total = 0;
    for (final attr in attributes.values) {
      total += attr.totalXp;
    }
    return total;
  }

  /// Get a specific attribute
  Attribute getAttribute(AttributeType type) {
    return attributes[type] ?? Attribute(type: type);
  }

  /// Create initial character with default attributes
  factory Character.initial(String userId, BuildPath buildPath) {
    return Character(
      userId: userId,
      buildPath: buildPath,
      attributes: {
        AttributeType.vitality: const Attribute(type: AttributeType.vitality),
        AttributeType.intellect: const Attribute(type: AttributeType.intellect),
        AttributeType.prosperity: const Attribute(type: AttributeType.prosperity),
        AttributeType.agility: const Attribute(type: AttributeType.agility),
        AttributeType.charisma: const Attribute(type: AttributeType.charisma),
      },
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Add XP to an attribute with build path bonus
  Character addXp(AttributeType type, int baseXp) {
    final multiplier = type == buildPath.primaryAttribute
        ? buildPath.xpMultiplier
        : 1.0;
    final actualXp = (baseXp * multiplier).round();

    final currentAttr = getAttribute(type);
    final newAttr = currentAttr.addXp(actualXp);

    final newAttributes = Map<AttributeType, Attribute>.from(attributes);
    newAttributes[type] = newAttr;

    return copyWith(
      attributes: newAttributes,
      updatedAt: DateTime.now(),
    );
  }

  /// Update streak
  Character updateStreak({required bool completed}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (!completed) {
      // Streak broken
      return copyWith(
        currentStreak: 0,
        lastActivityDate: today,
        updatedAt: now,
      );
    }

    if (lastActivityDate == null) {
      // First activity ever
      return copyWith(
        currentStreak: 1,
        longestStreak: 1,
        lastActivityDate: today,
        updatedAt: now,
      );
    }

    final lastDate = DateTime(
      lastActivityDate!.year,
      lastActivityDate!.month,
      lastActivityDate!.day,
    );
    final daysDiff = today.difference(lastDate).inDays;

    if (daysDiff == 0) {
      // Already logged today
      return this;
    } else if (daysDiff == 1) {
      // Consecutive day
      final newStreak = currentStreak + 1;
      return copyWith(
        currentStreak: newStreak,
        longestStreak: newStreak > longestStreak ? newStreak : longestStreak,
        lastActivityDate: today,
        updatedAt: now,
      );
    } else {
      // Streak broken, start fresh
      return copyWith(
        currentStreak: 1,
        lastActivityDate: today,
        updatedAt: now,
      );
    }
  }

  Character copyWith({
    String? userId,
    Map<AttributeType, Attribute>? attributes,
    BuildPath? buildPath,
    String? equippedTitle,
    List<String>? titles,
    List<String>? achievements,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActivityDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Character(
      userId: userId ?? this.userId,
      attributes: attributes ?? this.attributes,
      buildPath: buildPath ?? this.buildPath,
      equippedTitle: equippedTitle ?? this.equippedTitle,
      titles: titles ?? this.titles,
      achievements: achievements ?? this.achievements,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        attributes,
        buildPath,
        equippedTitle,
        titles,
        achievements,
        currentStreak,
        longestStreak,
        lastActivityDate,
        createdAt,
        updatedAt,
      ];
}
