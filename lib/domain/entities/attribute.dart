import 'package:equatable/equatable.dart';
import '../../core/constants/attribute_constants.dart';

/// Represents a single attribute with its current state
class Attribute extends Equatable {
  const Attribute({
    required this.type,
    this.level = 1,
    this.currentXp = 0,
    this.totalXp = 0,
  });

  final AttributeType type;
  final int level;
  final int currentXp; // XP within current level
  final int totalXp; // Total XP earned for this attribute

  /// Progress to next level (0.0 - 1.0)
  double get progressToNextLevel => XpConstants.progressToNextLevel(totalXp);

  /// XP needed to reach next level
  int get xpToNextLevel {
    final nextLevelTotal = XpConstants.totalXpForLevel(level + 1);
    return nextLevelTotal - totalXp;
  }

  /// Add XP and calculate new level
  Attribute addXp(int amount) {
    final newTotalXp = totalXp + amount;
    final newLevel = XpConstants.levelFromTotalXp(newTotalXp);
    final levelStartXp = XpConstants.totalXpForLevel(newLevel);
    final newCurrentXp = newTotalXp - levelStartXp;

    return Attribute(
      type: type,
      level: newLevel,
      currentXp: newCurrentXp,
      totalXp: newTotalXp,
    );
  }

  Attribute copyWith({
    AttributeType? type,
    int? level,
    int? currentXp,
    int? totalXp,
  }) {
    return Attribute(
      type: type ?? this.type,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      totalXp: totalXp ?? this.totalXp,
    );
  }

  @override
  List<Object?> get props => [type, level, currentXp, totalXp];
}
