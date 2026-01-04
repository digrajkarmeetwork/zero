import 'package:equatable/equatable.dart';
import '../../core/constants/attribute_constants.dart';

/// Activity entity representing a logged activity
class Activity extends Equatable {
  const Activity({
    required this.id,
    required this.userId,
    required this.name,
    required this.attribute,
    required this.baseXp,
    this.description,
    this.xpEarned = 0,
    this.verificationType = VerificationType.selfReported,
    this.verificationData,
    this.isVerified = false,
    this.notes,
    this.completedAt,
    this.createdAt,
  });

  final String id;
  final String userId;
  final String name;
  final String? description;
  final AttributeType attribute;
  final int baseXp;
  final int xpEarned;
  final VerificationType verificationType;
  final Map<String, dynamic>? verificationData;
  final bool isVerified;
  final String? notes;
  final DateTime? completedAt;
  final DateTime? createdAt;

  /// Calculate XP with verification multiplier
  int get calculatedXp => (baseXp * verificationType.xpMultiplier).round();

  Activity copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    AttributeType? attribute,
    int? baseXp,
    int? xpEarned,
    VerificationType? verificationType,
    Map<String, dynamic>? verificationData,
    bool? isVerified,
    String? notes,
    DateTime? completedAt,
    DateTime? createdAt,
  }) {
    return Activity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      attribute: attribute ?? this.attribute,
      baseXp: baseXp ?? this.baseXp,
      xpEarned: xpEarned ?? this.xpEarned,
      verificationType: verificationType ?? this.verificationType,
      verificationData: verificationData ?? this.verificationData,
      isVerified: isVerified ?? this.isVerified,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        attribute,
        baseXp,
        xpEarned,
        verificationType,
        verificationData,
        isVerified,
        notes,
        completedAt,
        createdAt,
      ];
}

/// Activity template for quick logging
class ActivityTemplate extends Equatable {
  const ActivityTemplate({
    required this.id,
    required this.name,
    required this.attribute,
    required this.baseXp,
    this.description,
    this.category,
    this.icon,
    this.isDefault = false,
    this.createdBy,
  });

  final String id;
  final String name;
  final String? description;
  final AttributeType attribute;
  final int baseXp;
  final String? category;
  final String? icon;
  final bool isDefault;
  final String? createdBy;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        attribute,
        baseXp,
        category,
        icon,
        isDefault,
        createdBy,
      ];
}
