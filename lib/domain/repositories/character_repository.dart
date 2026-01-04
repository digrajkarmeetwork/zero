import '../../core/constants/attribute_constants.dart';
import '../entities/character.dart';

/// Character repository interface
abstract class CharacterRepository {
  /// Get character by user ID
  Future<Character?> getCharacter(String userId);

  /// Stream character changes
  Stream<Character?> watchCharacter(String userId);

  /// Create a new character
  Future<Character> createCharacter({
    required String userId,
    required BuildPath buildPath,
  });

  /// Update character
  Future<Character> updateCharacter(Character character);

  /// Add XP to an attribute
  Future<Character> addXp({
    required String userId,
    required AttributeType attribute,
    required int amount,
  });

  /// Update streak
  Future<Character> updateStreak({
    required String userId,
    required bool completed,
  });

  /// Change build path
  Future<Character> changeBuildPath({
    required String userId,
    required BuildPath newPath,
  });

  /// Add title
  Future<Character> addTitle({
    required String userId,
    required String title,
  });

  /// Equip title
  Future<Character> equipTitle({
    required String userId,
    required String? title,
  });

  /// Add achievement
  Future<Character> addAchievement({
    required String userId,
    required String achievementId,
  });

  /// Delete character
  Future<void> deleteCharacter(String userId);
}
