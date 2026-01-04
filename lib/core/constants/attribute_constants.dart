import 'package:flutter/material.dart';

/// Character attributes
enum AttributeType {
  vitality('VIT', 'Vitality', 'Physical health and fitness'),
  intellect('INT', 'Intellect', 'Mental growth and learning'),
  prosperity('PRS', 'Prosperity', 'Financial health and wealth'),
  agility('AGI', 'Agility', 'Consistency and habit streaks'),
  charisma('CHA', 'Charisma', 'Social skills and relationships');

  const AttributeType(this.shortName, this.displayName, this.description);

  final String shortName;
  final String displayName;
  final String description;
}

/// Build paths with attribute bonuses
enum BuildPath {
  warrior('Warrior', AttributeType.vitality, 'Master your body'),
  scholar('Scholar', AttributeType.intellect, 'Expand your mind'),
  merchant('Merchant', AttributeType.prosperity, 'Build your wealth'),
  phantom('Phantom', AttributeType.agility, 'Perfect your habits'),
  diplomat('Diplomat', AttributeType.charisma, 'Strengthen connections');

  const BuildPath(this.displayName, this.primaryAttribute, this.tagline);

  final String displayName;
  final AttributeType primaryAttribute;
  final String tagline;

  /// XP multiplier for primary attribute (1.2 = +20%)
  double get xpMultiplier => 1.2;
}

/// Attribute colors
class AttributeColors {
  AttributeColors._();

  static const Color vitality = Color(0xFFFF4757);
  static const Color intellect = Color(0xFF9B59FF);
  static const Color prosperity = Color(0xFFFFD700);
  static const Color agility = Color(0xFF00FF88);
  static const Color charisma = Color(0xFFFF6B9D);

  static Color forAttribute(AttributeType type) {
    switch (type) {
      case AttributeType.vitality:
        return vitality;
      case AttributeType.intellect:
        return intellect;
      case AttributeType.prosperity:
        return prosperity;
      case AttributeType.agility:
        return agility;
      case AttributeType.charisma:
        return charisma;
    }
  }

  static IconData iconForAttribute(AttributeType type) {
    switch (type) {
      case AttributeType.vitality:
        return Icons.favorite;
      case AttributeType.intellect:
        return Icons.psychology;
      case AttributeType.prosperity:
        return Icons.attach_money;
      case AttributeType.agility:
        return Icons.bolt;
      case AttributeType.charisma:
        return Icons.people;
    }
  }
}

/// XP calculation constants
class XpConstants {
  XpConstants._();

  /// Base XP required for level 2
  static const int baseXpForLevel = 100;

  /// XP growth factor per level (exponential)
  static const double xpGrowthFactor = 1.15;

  /// Calculate XP required for a specific level
  static int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;
    return (baseXpForLevel * _pow(xpGrowthFactor, level - 2)).round();
  }

  /// Calculate total XP required to reach a level
  static int totalXpForLevel(int level) {
    int total = 0;
    for (int i = 2; i <= level; i++) {
      total += xpRequiredForLevel(i);
    }
    return total;
  }

  /// Calculate level from total XP
  static int levelFromTotalXp(int totalXp) {
    int level = 1;
    int xpNeeded = 0;
    while (xpNeeded <= totalXp) {
      level++;
      xpNeeded += xpRequiredForLevel(level);
    }
    return level - 1;
  }

  /// Calculate progress to next level (0.0 - 1.0)
  static double progressToNextLevel(int totalXp) {
    final currentLevel = levelFromTotalXp(totalXp);
    final xpForCurrent = totalXpForLevel(currentLevel);
    final xpForNext = totalXpForLevel(currentLevel + 1);
    final xpInLevel = totalXp - xpForCurrent;
    final xpNeeded = xpForNext - xpForCurrent;
    return (xpInLevel / xpNeeded).clamp(0.0, 1.0);
  }

  static double _pow(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}

/// Verification types and their XP multipliers
enum VerificationType {
  selfReported('Self-reported', 1.0),
  photo('Photo proof', 1.25),
  integration('App integration', 1.5),
  witness('Guild witness', 1.5),
  gps('GPS verified', 1.75);

  const VerificationType(this.displayName, this.xpMultiplier);

  final String displayName;
  final double xpMultiplier;
}
