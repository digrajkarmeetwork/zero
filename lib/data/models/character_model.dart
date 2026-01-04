import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/attribute_constants.dart';
import '../../domain/entities/attribute.dart';
import '../../domain/entities/character.dart';

/// Character model for Firebase
class CharacterModel {
  const CharacterModel({
    required this.userId,
    required this.attributes,
    required this.buildPath,
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
  final Map<String, AttributeModel> attributes;
  final String buildPath;
  final String? equippedTitle;
  final List<String> titles;
  final List<String> achievements;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Create from Firestore document
  factory CharacterModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return CharacterModel(
        userId: doc.id,
        attributes: {},
        buildPath: 'warrior',
      );
    }

    final attributesData = data['attributes'] as Map<String, dynamic>? ?? {};
    final attributes = <String, AttributeModel>{};
    attributesData.forEach((key, value) {
      attributes[key] = AttributeModel.fromMap(key, value as Map<String, dynamic>);
    });

    return CharacterModel(
      userId: doc.id,
      attributes: attributes,
      buildPath: data['buildPath'] as String? ?? 'warrior',
      equippedTitle: data['equippedTitle'] as String?,
      titles: List<String>.from(data['titles'] ?? []),
      achievements: List<String>.from(data['achievements'] ?? []),
      currentStreak: data['currentStreak'] as int? ?? 0,
      longestStreak: data['longestStreak'] as int? ?? 0,
      lastActivityDate: (data['lastActivityDate'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    final attributesMap = <String, dynamic>{};
    attributes.forEach((key, value) {
      attributesMap[key] = value.toMap();
    });

    return {
      'attributes': attributesMap,
      'buildPath': buildPath,
      'equippedTitle': equippedTitle,
      'titles': titles,
      'achievements': achievements,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivityDate': lastActivityDate != null
          ? Timestamp.fromDate(lastActivityDate!)
          : null,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  /// Convert to domain entity
  Character toEntity() {
    final entityAttributes = <AttributeType, Attribute>{};
    for (final type in AttributeType.values) {
      final model = attributes[type.name];
      if (model != null) {
        entityAttributes[type] = model.toEntity(type);
      } else {
        entityAttributes[type] = Attribute(type: type);
      }
    }

    return Character(
      userId: userId,
      attributes: entityAttributes,
      buildPath: BuildPath.values.firstWhere(
        (b) => b.name == buildPath,
        orElse: () => BuildPath.warrior,
      ),
      equippedTitle: equippedTitle,
      titles: titles,
      achievements: achievements,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastActivityDate: lastActivityDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory CharacterModel.fromEntity(Character character) {
    final attributesMap = <String, AttributeModel>{};
    character.attributes.forEach((type, attr) {
      attributesMap[type.name] = AttributeModel.fromEntity(attr);
    });

    return CharacterModel(
      userId: character.userId,
      attributes: attributesMap,
      buildPath: character.buildPath.name,
      equippedTitle: character.equippedTitle,
      titles: character.titles,
      achievements: character.achievements,
      currentStreak: character.currentStreak,
      longestStreak: character.longestStreak,
      lastActivityDate: character.lastActivityDate,
      createdAt: character.createdAt,
      updatedAt: character.updatedAt,
    );
  }
}

/// Attribute model for Firebase
class AttributeModel {
  const AttributeModel({
    required this.level,
    required this.currentXp,
    required this.totalXp,
  });

  final int level;
  final int currentXp;
  final int totalXp;

  factory AttributeModel.fromMap(String key, Map<String, dynamic> map) {
    return AttributeModel(
      level: map['level'] as int? ?? 1,
      currentXp: map['currentXp'] as int? ?? 0,
      totalXp: map['totalXp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'currentXp': currentXp,
      'totalXp': totalXp,
    };
  }

  Attribute toEntity(AttributeType type) {
    return Attribute(
      type: type,
      level: level,
      currentXp: currentXp,
      totalXp: totalXp,
    );
  }

  factory AttributeModel.fromEntity(Attribute attr) {
    return AttributeModel(
      level: attr.level,
      currentXp: attr.currentXp,
      totalXp: attr.totalXp,
    );
  }
}
