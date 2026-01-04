import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/attribute_constants.dart';
import '../../domain/entities/activity.dart';

/// Activity model for Firebase
class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.attribute,
    required this.baseXp,
    this.description,
    this.xpEarned = 0,
    this.verificationType = 'selfReported',
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
  final String attribute;
  final int baseXp;
  final int xpEarned;
  final String verificationType;
  final Map<String, dynamic>? verificationData;
  final bool isVerified;
  final String? notes;
  final DateTime? completedAt;
  final DateTime? createdAt;

  /// Create from Firestore document
  factory ActivityModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return ActivityModel(
        id: doc.id,
        userId: '',
        name: '',
        attribute: 'vitality',
        baseXp: 0,
      );
    }

    return ActivityModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String?,
      attribute: data['attribute'] as String? ?? 'vitality',
      baseXp: data['baseXp'] as int? ?? 0,
      xpEarned: data['xpEarned'] as int? ?? 0,
      verificationType: data['verificationType'] as String? ?? 'selfReported',
      verificationData: data['verificationData'] as Map<String, dynamic>?,
      isVerified: data['isVerified'] as bool? ?? false,
      notes: data['notes'] as String?,
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'description': description,
      'attribute': attribute,
      'baseXp': baseXp,
      'xpEarned': xpEarned,
      'verificationType': verificationType,
      'verificationData': verificationData,
      'isVerified': isVerified,
      'notes': notes,
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : FieldValue.serverTimestamp(),
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  /// Convert to domain entity
  Activity toEntity() {
    return Activity(
      id: id,
      userId: userId,
      name: name,
      description: description,
      attribute: AttributeType.values.firstWhere(
        (a) => a.name == attribute,
        orElse: () => AttributeType.vitality,
      ),
      baseXp: baseXp,
      xpEarned: xpEarned,
      verificationType: VerificationType.values.firstWhere(
        (v) => v.name == verificationType,
        orElse: () => VerificationType.selfReported,
      ),
      verificationData: verificationData,
      isVerified: isVerified,
      notes: notes,
      completedAt: completedAt,
      createdAt: createdAt,
    );
  }

  /// Create from domain entity
  factory ActivityModel.fromEntity(Activity activity) {
    return ActivityModel(
      id: activity.id,
      userId: activity.userId,
      name: activity.name,
      description: activity.description,
      attribute: activity.attribute.name,
      baseXp: activity.baseXp,
      xpEarned: activity.xpEarned,
      verificationType: activity.verificationType.name,
      verificationData: activity.verificationData,
      isVerified: activity.isVerified,
      notes: activity.notes,
      completedAt: activity.completedAt,
      createdAt: activity.createdAt,
    );
  }
}

/// Activity template model for Firebase
class ActivityTemplateModel {
  const ActivityTemplateModel({
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
  final String attribute;
  final int baseXp;
  final String? category;
  final String? icon;
  final bool isDefault;
  final String? createdBy;

  factory ActivityTemplateModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return ActivityTemplateModel(
        id: doc.id,
        name: '',
        attribute: 'vitality',
        baseXp: 0,
      );
    }

    return ActivityTemplateModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      description: data['description'] as String?,
      attribute: data['attribute'] as String? ?? 'vitality',
      baseXp: data['baseXp'] as int? ?? 0,
      category: data['category'] as String?,
      icon: data['icon'] as String?,
      isDefault: data['isDefault'] as bool? ?? false,
      createdBy: data['createdBy'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'attribute': attribute,
      'baseXp': baseXp,
      'category': category,
      'icon': icon,
      'isDefault': isDefault,
      'createdBy': createdBy,
    };
  }

  ActivityTemplate toEntity() {
    return ActivityTemplate(
      id: id,
      name: name,
      description: description,
      attribute: AttributeType.values.firstWhere(
        (a) => a.name == attribute,
        orElse: () => AttributeType.vitality,
      ),
      baseXp: baseXp,
      category: category,
      icon: icon,
      isDefault: isDefault,
      createdBy: createdBy,
    );
  }

  factory ActivityTemplateModel.fromEntity(ActivityTemplate template) {
    return ActivityTemplateModel(
      id: template.id,
      name: template.name,
      description: template.description,
      attribute: template.attribute.name,
      baseXp: template.baseXp,
      category: template.category,
      icon: template.icon,
      isDefault: template.isDefault,
      createdBy: template.createdBy,
    );
  }
}
