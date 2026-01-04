import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/attribute_constants.dart';
import '../../domain/entities/activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../models/activity_model.dart';

/// Firebase implementation of ActivityRepository
class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  CollectionReference<Map<String, dynamic>> get _activitiesCollection =>
      _firestore.collection(AppConstants.activitiesCollection);

  CollectionReference<Map<String, dynamic>> get _templatesCollection =>
      _firestore.collection(AppConstants.activityTemplatesCollection);

  @override
  Future<Activity> logActivity({
    required String userId,
    required String name,
    required AttributeType attribute,
    required int baseXp,
    String? description,
    String? notes,
    VerificationType verificationType = VerificationType.selfReported,
    Map<String, dynamic>? verificationData,
  }) async {
    final now = DateTime.now();
    final xpEarned = (baseXp * verificationType.xpMultiplier).round();

    final activity = Activity(
      id: _uuid.v4(),
      userId: userId,
      name: name,
      description: description,
      attribute: attribute,
      baseXp: baseXp,
      xpEarned: xpEarned,
      verificationType: verificationType,
      verificationData: verificationData,
      isVerified: verificationType != VerificationType.selfReported,
      notes: notes,
      completedAt: now,
      createdAt: now,
    );

    final model = ActivityModel.fromEntity(activity);
    await _activitiesCollection.doc(activity.id).set(model.toFirestore());

    return activity;
  }

  @override
  Future<List<Activity>> getActivities({
    required String userId,
    int limit = 20,
    DateTime? startAfter,
    AttributeType? attribute,
  }) async {
    Query<Map<String, dynamic>> query = _activitiesCollection
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit);

    if (attribute != null) {
      query = query.where('attribute', isEqualTo: attribute.name);
    }

    if (startAfter != null) {
      query = query.startAfter([Timestamp.fromDate(startAfter)]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => ActivityModel.fromFirestore(doc).toEntity())
        .toList();
  }

  @override
  Future<List<Activity>> getTodayActivities(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _activitiesCollection
        .where('userId', isEqualTo: userId)
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('completedAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ActivityModel.fromFirestore(doc).toEntity())
        .toList();
  }

  @override
  Future<Activity?> getActivity(String activityId) async {
    final doc = await _activitiesCollection.doc(activityId).get();
    if (!doc.exists) return null;
    return ActivityModel.fromFirestore(doc).toEntity();
  }

  @override
  Future<Activity> updateActivity(Activity activity) async {
    final model = ActivityModel.fromEntity(activity);
    await _activitiesCollection.doc(activity.id).update(model.toFirestore());
    return activity;
  }

  @override
  Future<void> deleteActivity(String activityId) async {
    await _activitiesCollection.doc(activityId).delete();
  }

  @override
  Future<int> getActivityCount({
    required String userId,
    required DateTime start,
    required DateTime end,
  }) async {
    final snapshot = await _activitiesCollection
        .where('userId', isEqualTo: userId)
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('completedAt', isLessThan: Timestamp.fromDate(end))
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  @override
  Future<List<ActivityTemplate>> getTemplates({
    AttributeType? attribute,
    bool includeCustom = true,
    String? userId,
  }) async {
    Query<Map<String, dynamic>> query = _templatesCollection;

    if (attribute != null) {
      query = query.where('attribute', isEqualTo: attribute.name);
    }

    final snapshot = await query.get();
    final templates = snapshot.docs
        .map((doc) => ActivityTemplateModel.fromFirestore(doc).toEntity())
        .toList();

    if (!includeCustom) {
      return templates.where((t) => t.isDefault).toList();
    }

    if (userId != null) {
      return templates
          .where((t) => t.isDefault || t.createdBy == userId)
          .toList();
    }

    return templates;
  }

  @override
  Future<ActivityTemplate> createTemplate({
    required String userId,
    required String name,
    required AttributeType attribute,
    required int baseXp,
    String? description,
    String? category,
  }) async {
    final template = ActivityTemplate(
      id: _uuid.v4(),
      name: name,
      description: description,
      attribute: attribute,
      baseXp: baseXp,
      category: category,
      isDefault: false,
      createdBy: userId,
    );

    final model = ActivityTemplateModel.fromEntity(template);
    await _templatesCollection.doc(template.id).set(model.toFirestore());

    return template;
  }

  @override
  Future<void> deleteTemplate(String templateId) async {
    await _templatesCollection.doc(templateId).delete();
  }
}
