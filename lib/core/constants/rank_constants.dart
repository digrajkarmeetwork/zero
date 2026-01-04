import 'package:flutter/material.dart';

/// Rank definitions and thresholds
enum Rank {
  unranked(0, 'Unranked', 0, 99),
  bronze(1, 'Bronze', 100, 299),
  iron(2, 'Iron', 300, 599),
  steel(3, 'Steel', 600, 999),
  gold(4, 'Gold', 1000, 1499),
  platinum(5, 'Platinum', 1500, 2099),
  diamond(6, 'Diamond', 2100, 2799),
  master(7, 'Master', 2800, 3599),
  grandmaster(8, 'Grandmaster', 3600, 4499),
  legend(9, 'Legend', 4500, 5499),
  mythic(10, 'Mythic', 5500, 999999);

  const Rank(this.tier, this.displayName, this.minPowerLevel, this.maxPowerLevel);

  final int tier;
  final String displayName;
  final int minPowerLevel;
  final int maxPowerLevel;

  /// Get rank from power level
  static Rank fromPowerLevel(int powerLevel) {
    for (final rank in Rank.values.reversed) {
      if (powerLevel >= rank.minPowerLevel) {
        return rank;
      }
    }
    return Rank.unranked;
  }

  /// Progress to next rank (0.0 - 1.0)
  double progressToNext(int currentPowerLevel) {
    if (this == Rank.mythic) return 1.0;

    final range = maxPowerLevel - minPowerLevel + 1;
    final progress = currentPowerLevel - minPowerLevel;
    return (progress / range).clamp(0.0, 1.0);
  }

  /// Power level needed for next rank
  int get powerLevelForNextRank {
    if (this == Rank.mythic) return maxPowerLevel;
    return maxPowerLevel + 1;
  }
}

/// Rank colors for UI
class RankColors {
  RankColors._();

  static const Color unranked = Color(0xFF3A3A3A);
  static const Color bronze = Color(0xFFCD853F);
  static const Color iron = Color(0xFF8C8C8C);
  static const Color steel = Color(0xFFD0D0D0);
  static const Color gold = Color(0xFFFFD700);
  static const Color platinum = Color(0xFFE5E4E2);
  static const Color diamond = Color(0xFF00BFFF);
  static const Color master = Color(0xFFDA70D6);
  static const Color grandmaster = Color(0xFFFF4500);
  static const Color legend = Color(0xFFFFD700); // Animated gradient in UI
  static const Color mythic = Color(0xFFFFFFFF); // Animated particles in UI

  static Color forRank(Rank rank) {
    switch (rank) {
      case Rank.unranked:
        return unranked;
      case Rank.bronze:
        return bronze;
      case Rank.iron:
        return iron;
      case Rank.steel:
        return steel;
      case Rank.gold:
        return gold;
      case Rank.platinum:
        return platinum;
      case Rank.diamond:
        return diamond;
      case Rank.master:
        return master;
      case Rank.grandmaster:
        return grandmaster;
      case Rank.legend:
        return legend;
      case Rank.mythic:
        return mythic;
    }
  }

  static List<Color> gradientForRank(Rank rank) {
    switch (rank) {
      case Rank.unranked:
        return [const Color(0xFF2A2A2A), const Color(0xFF3A3A3A)];
      case Rank.bronze:
        return [const Color(0xFF8B4513), const Color(0xFFCD853F)];
      case Rank.iron:
        return [const Color(0xFF5C5C5C), const Color(0xFF8C8C8C)];
      case Rank.steel:
        return [const Color(0xFFA0A0A0), const Color(0xFFD0D0D0)];
      case Rank.gold:
        return [const Color(0xFFDAA520), const Color(0xFFFFD700)];
      case Rank.platinum:
        return [const Color(0xFFE0E0E0), const Color(0xFFFFFFFF)];
      case Rank.diamond:
        return [const Color(0xFF87CEEB), const Color(0xFF00BFFF)];
      case Rank.master:
        return [const Color(0xFF8A2BE2), const Color(0xFFDA70D6)];
      case Rank.grandmaster:
        return [const Color(0xFFDC143C), const Color(0xFFFF4500)];
      case Rank.legend:
        return [
          const Color(0xFFFF0000),
          const Color(0xFFFF7F00),
          const Color(0xFFFFFF00),
          const Color(0xFF00FF00),
          const Color(0xFF0000FF),
          const Color(0xFF4B0082),
          const Color(0xFF9400D3),
        ];
      case Rank.mythic:
        return [
          const Color(0xFFFFFFFF),
          const Color(0xFF00D4FF),
          const Color(0xFFFFD700),
          const Color(0xFFFFFFFF),
        ];
    }
  }
}
