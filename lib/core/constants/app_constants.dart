/// App-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'ZERO';
  static const String appTagline = 'From Zero to Legendary';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String charactersCollection = 'characters';
  static const String activitiesCollection = 'activities';
  static const String activityTemplatesCollection = 'activity_templates';
  static const String questsCollection = 'quests';
  static const String userQuestsCollection = 'user_quests';
  static const String guildsCollection = 'guilds';

  // Pagination
  static const int defaultPageSize = 20;

  // Cache durations (in minutes)
  static const int characterCacheDuration = 5;
  static const int templatesCacheDuration = 60;
  static const int leaderboardCacheDuration = 5;

  // Validation
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int minPasswordLength = 8;

  // Rate limiting
  static const int maxActivitiesPerHour = 20;
  static const int maxActivitiesPerDay = 50;
}
