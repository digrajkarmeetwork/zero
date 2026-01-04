import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/attribute_constants.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../models/character_model.dart';

/// Firebase implementation of CharacterRepository
class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(AppConstants.charactersCollection);

  @override
  Future<Character?> getCharacter(String userId) async {
    final doc = await _collection.doc(userId).get();
    if (!doc.exists) return null;
    return CharacterModel.fromFirestore(doc).toEntity();
  }

  @override
  Stream<Character?> watchCharacter(String userId) {
    return _collection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return CharacterModel.fromFirestore(doc).toEntity();
    });
  }

  @override
  Future<Character> createCharacter({
    required String userId,
    required BuildPath buildPath,
  }) async {
    final character = Character.initial(userId, buildPath);
    final model = CharacterModel.fromEntity(character);

    await _collection.doc(userId).set(model.toFirestore());

    return character;
  }

  @override
  Future<Character> updateCharacter(Character character) async {
    final model = CharacterModel.fromEntity(character.copyWith(
      updatedAt: DateTime.now(),
    ));

    await _collection.doc(character.userId).update(model.toFirestore());

    return character;
  }

  @override
  Future<Character> addXp({
    required String userId,
    required AttributeType attribute,
    required int amount,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    final updatedCharacter = character.addXp(attribute, amount);
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<Character> updateStreak({
    required String userId,
    required bool completed,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    final updatedCharacter = character.updateStreak(completed: completed);
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<Character> changeBuildPath({
    required String userId,
    required BuildPath newPath,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    final updatedCharacter = character.copyWith(
      buildPath: newPath,
      updatedAt: DateTime.now(),
    );
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<Character> addTitle({
    required String userId,
    required String title,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    if (character.titles.contains(title)) {
      return character;
    }

    final updatedCharacter = character.copyWith(
      titles: [...character.titles, title],
      updatedAt: DateTime.now(),
    );
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<Character> equipTitle({
    required String userId,
    required String? title,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    final updatedCharacter = character.copyWith(
      equippedTitle: title,
      updatedAt: DateTime.now(),
    );
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<Character> addAchievement({
    required String userId,
    required String achievementId,
  }) async {
    final character = await getCharacter(userId);
    if (character == null) {
      throw Exception('Character not found');
    }

    if (character.achievements.contains(achievementId)) {
      return character;
    }

    final updatedCharacter = character.copyWith(
      achievements: [...character.achievements, achievementId],
      updatedAt: DateTime.now(),
    );
    await updateCharacter(updatedCharacter);

    return updatedCharacter;
  }

  @override
  Future<void> deleteCharacter(String userId) async {
    await _collection.doc(userId).delete();
  }
}
