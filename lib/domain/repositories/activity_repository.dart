import '../../core/constants/attribute_constants.dart';
import '../entities/activity.dart';

/// Activity repository interface
abstract class ActivityRepository {
  /// Log a new activity
  Future<Activity> logActivity({
    required String userId,
    required String name,
    required AttributeType attribute,
    required int baseXp,
    String? description,
    String? notes,
    VerificationType verificationType = VerificationType.selfReported,
    Map<String, dynamic>? verificationData,
  });

  /// Get activities for a user
  Future<List<Activity>> getActivities({
    required String userId,
    int limit = 20,
    DateTime? startAfter,
    AttributeType? attribute,
  });

  /// Get activities for today
  Future<List<Activity>> getTodayActivities(String userId);

  /// Get activity by ID
  Future<Activity?> getActivity(String activityId);

  /// Update activity
  Future<Activity> updateActivity(Activity activity);

  /// Delete activity
  Future<void> deleteActivity(String activityId);

  /// Get activity count for a time period
  Future<int> getActivityCount({
    required String userId,
    required DateTime start,
    required DateTime end,
  });

  /// Get activity templates
  Future<List<ActivityTemplate>> getTemplates({
    AttributeType? attribute,
    bool includeCustom = true,
    String? userId,
  });

  /// Create custom template
  Future<ActivityTemplate> createTemplate({
    required String userId,
    required String name,
    required AttributeType attribute,
    required int baseXp,
    String? description,
    String? category,
  });

  /// Delete custom template
  Future<void> deleteTemplate(String templateId);
}
