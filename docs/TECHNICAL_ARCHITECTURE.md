# ZERO - Technical Architecture Document

## 1. System Overview

### 1.1 Architecture Pattern

ZERO uses a **clean architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   Screens   │  │   Widgets   │  │ Controllers │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
├─────────────────────────────────────────────────────────────────┤
│                        APPLICATION LAYER                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  Use Cases  │  │   BLoCs     │  │   States    │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
├─────────────────────────────────────────────────────────────────┤
│                         DOMAIN LAYER                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  Entities   │  │Repositories │  │  Services   │              │
│  │ (Interfaces)│  │ (Interfaces)│  │ (Interfaces)│              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
├─────────────────────────────────────────────────────────────────┤
│                          DATA LAYER                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   Models    │  │ Repository  │  │ Data Sources│              │
│  │             │  │   Impls     │  │(Remote/Local)│             │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 High-Level System Architecture

```
┌──────────────────┐         ┌──────────────────┐
│   iOS App        │         │   Android App    │
│   (Flutter)      │         │   (Flutter)      │
└────────┬─────────┘         └────────┬─────────┘
         │                            │
         └──────────┬─────────────────┘
                    │
                    ▼
         ┌──────────────────┐
         │   API Gateway    │
         │   (Firebase or   │
         │    Supabase)     │
         └────────┬─────────┘
                  │
    ┌─────────────┼─────────────┐
    │             │             │
    ▼             ▼             ▼
┌────────┐  ┌──────────┐  ┌──────────┐
│  Auth  │  │ Database │  │ Storage  │
│Service │  │(Firestore│  │ (Images/ │
│        │  │/Postgres)│  │  Media)  │
└────────┘  └──────────┘  └──────────┘
                  │
                  ▼
         ┌──────────────────┐
         │  Cloud Functions │
         │  (Background     │
         │   Processing)    │
         └──────────────────┘
```

---

## 2. Technology Stack

### 2.1 Mobile Application (Flutter)

| Category | Technology | Rationale |
|----------|------------|-----------|
| **Framework** | Flutter 3.x | Cross-platform, single codebase, excellent performance |
| **Language** | Dart 3.x | Null safety, strong typing, async support |
| **State Management** | flutter_bloc | Predictable state, testable, scalable |
| **Navigation** | go_router | Declarative routing, deep linking support |
| **DI** | get_it + injectable | Compile-time safety, easy testing |
| **Local Storage** | Hive / Isar | Fast NoSQL, offline-first capability |
| **HTTP Client** | dio | Interceptors, retry logic, cancellation |
| **Code Generation** | freezed, json_serializable | Immutable models, less boilerplate |

### 2.2 Backend Options

#### Option A: Firebase (Recommended for MVP)

| Service | Purpose |
|---------|---------|
| Firebase Auth | Authentication (email, Google, Apple) |
| Cloud Firestore | Primary database |
| Cloud Storage | Image/media storage |
| Cloud Functions | Background jobs, XP calculations |
| Cloud Messaging | Push notifications |
| Remote Config | Feature flags |
| Analytics | Usage tracking |

**Pros**: Fast development, generous free tier, real-time sync, offline support
**Cons**: Vendor lock-in, complex queries limited, costs scale with reads

#### Option B: Supabase (Alternative)

| Service | Purpose |
|---------|---------|
| Supabase Auth | Authentication |
| PostgreSQL | Primary database |
| Supabase Storage | File storage |
| Edge Functions | Serverless compute |
| Realtime | Live subscriptions |

**Pros**: SQL flexibility, open-source, predictable pricing
**Cons**: Smaller ecosystem, less mature mobile SDKs

### 2.3 Third-Party Integrations

| Integration | Package/API | Purpose |
|-------------|-------------|---------|
| Health Data | health | Apple Health / Google Fit |
| Fitness | strava_flutter | Strava activities |
| Analytics | firebase_analytics, mixpanel | User behavior |
| Crash Reporting | firebase_crashlytics | Error tracking |
| Notifications | firebase_messaging, flutter_local_notifications | Push & local |
| Image Processing | image_picker, image_cropper | Photo verification |

---

## 3. Project Structure

```
lib/
├── main.dart                      # App entry point
├── app/
│   ├── app.dart                   # MaterialApp configuration
│   ├── router.dart                # Route definitions
│   └── theme/
│       ├── app_theme.dart         # Theme data
│       ├── colors.dart            # Color constants
│       └── typography.dart        # Text styles
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart     # App-wide constants
│   │   ├── rank_constants.dart    # Rank thresholds
│   │   └── xp_constants.dart      # XP values
│   ├── errors/
│   │   ├── exceptions.dart        # Custom exceptions
│   │   └── failures.dart          # Failure classes
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   └── string_extensions.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── xp_calculator.dart
│   └── injection/
│       └── injection.dart         # Dependency injection setup
│
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── auth_remote_datasource.dart
│   │   │   ├── user_remote_datasource.dart
│   │   │   ├── activity_remote_datasource.dart
│   │   │   ├── quest_remote_datasource.dart
│   │   │   └── guild_remote_datasource.dart
│   │   └── local/
│   │       ├── user_local_datasource.dart
│   │       └── cache_datasource.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── character_model.dart
│   │   ├── attribute_model.dart
│   │   ├── activity_model.dart
│   │   ├── quest_model.dart
│   │   └── guild_model.dart
│   └── repositories/
│       ├── auth_repository_impl.dart
│       ├── user_repository_impl.dart
│       ├── activity_repository_impl.dart
│       ├── quest_repository_impl.dart
│       └── guild_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   ├── character.dart
│   │   ├── attribute.dart
│   │   ├── activity.dart
│   │   ├── quest.dart
│   │   ├── guild.dart
│   │   └── rank.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── activity_repository.dart
│   │   ├── quest_repository.dart
│   │   └── guild_repository.dart
│   └── usecases/
│       ├── auth/
│       │   ├── sign_in.dart
│       │   ├── sign_up.dart
│       │   └── sign_out.dart
│       ├── character/
│       │   ├── get_character.dart
│       │   ├── update_attribute.dart
│       │   └── calculate_power_level.dart
│       ├── activities/
│       │   ├── log_activity.dart
│       │   ├── get_activities.dart
│       │   └── verify_activity.dart
│       ├── quests/
│       │   ├── get_daily_quests.dart
│       │   ├── complete_quest.dart
│       │   └── claim_quest_reward.dart
│       └── guilds/
│           ├── create_guild.dart
│           ├── join_guild.dart
│           └── get_guild_leaderboard.dart
│
├── presentation/
│   ├── blocs/
│   │   ├── auth/
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   ├── character/
│   │   │   ├── character_bloc.dart
│   │   │   ├── character_event.dart
│   │   │   └── character_state.dart
│   │   ├── activities/
│   │   │   └── ...
│   │   ├── quests/
│   │   │   └── ...
│   │   └── guilds/
│   │       └── ...
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── onboarding/
│   │   │   ├── onboarding_screen.dart
│   │   │   └── character_creation_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── character/
│   │   │   ├── character_screen.dart
│   │   │   └── widgets/
│   │   ├── activities/
│   │   │   ├── activities_screen.dart
│   │   │   ├── log_activity_screen.dart
│   │   │   └── widgets/
│   │   ├── quests/
│   │   │   ├── quests_screen.dart
│   │   │   └── widgets/
│   │   ├── guilds/
│   │   │   ├── guild_screen.dart
│   │   │   ├── guild_search_screen.dart
│   │   │   └── widgets/
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│   │   │   └── settings_screen.dart
│   │   └── leaderboard/
│   │       ├── leaderboard_screen.dart
│   │       └── widgets/
│   └── widgets/
│       ├── common/
│       │   ├── zero_button.dart
│       │   ├── zero_card.dart
│       │   ├── zero_input.dart
│       │   └── loading_overlay.dart
│       ├── character/
│       │   ├── attribute_bar.dart
│       │   ├── rank_badge.dart
│       │   └── power_level_display.dart
│       ├── activities/
│       │   ├── activity_card.dart
│       │   └── streak_indicator.dart
│       └── animations/
│           ├── level_up_animation.dart
│           ├── xp_gain_animation.dart
│           └── rank_up_animation.dart
│
└── services/
    ├── health_service.dart        # Apple Health / Google Fit
    ├── notification_service.dart  # Push notifications
    ├── analytics_service.dart     # Event tracking
    └── storage_service.dart       # File uploads
```

---

## 4. Database Schema

### 4.1 Firestore Collections Structure

```
users/
  └── {userId}/
      ├── email: string
      ├── displayName: string
      ├── avatarUrl: string?
      ├── createdAt: timestamp
      ├── lastActiveAt: timestamp
      ├── isPremium: boolean
      ├── premiumExpiresAt: timestamp?
      └── settings: map
          ├── notifications: boolean
          ├── publicProfile: boolean
          └── theme: string

characters/
  └── {userId}/
      ├── userId: string
      ├── title: string?
      ├── buildPath: string (warrior|scholar|merchant|phantom|diplomat)
      ├── powerLevel: number
      ├── rank: number (0-10)
      ├── totalXp: number
      ├── attributes: map
      │   ├── vitality: { level: number, xp: number, totalXp: number }
      │   ├── intellect: { level: number, xp: number, totalXp: number }
      │   ├── prosperity: { level: number, xp: number, totalXp: number }
      │   ├── agility: { level: number, xp: number, totalXp: number }
      │   └── charisma: { level: number, xp: number, totalXp: number }
      ├── streaks: map
      │   ├── current: number
      │   ├── longest: number
      │   └── lastActivityDate: timestamp
      ├── achievements: array<string>
      ├── titles: array<string>
      ├── equippedTitle: string?
      └── updatedAt: timestamp

activities/
  └── {activityId}/
      ├── userId: string
      ├── name: string
      ├── description: string?
      ├── attribute: string (vitality|intellect|prosperity|agility|charisma)
      ├── baseXp: number
      ├── xpEarned: number
      ├── verificationType: string (self|photo|integration|witness|gps)
      ├── verificationData: map?
      │   ├── photoUrl: string?
      │   ├── integrationSource: string?
      │   ├── witnessUserId: string?
      │   └── location: geopoint?
      ├── isVerified: boolean
      ├── completedAt: timestamp
      └── createdAt: timestamp

activity_templates/
  └── {templateId}/
      ├── name: string
      ├── description: string
      ├── attribute: string
      ├── baseXp: number
      ├── category: string
      ├── icon: string
      ├── isDefault: boolean
      └── createdBy: string? (null for system templates)

quests/
  └── {questId}/
      ├── title: string
      ├── description: string
      ├── type: string (daily|weekly|epic|legendary)
      ├── requirements: array<map>
      │   ├── type: string (complete_activities|attribute_xp|streak|custom)
      │   ├── target: number
      │   └── attribute: string?
      ├── rewards: map
      │   ├── xp: number
      │   ├── attribute: string?
      │   └── title: string?
      ├── startsAt: timestamp
      ├── expiresAt: timestamp
      ├── isActive: boolean
      └── createdAt: timestamp

user_quests/
  └── {userQuestId}/
      ├── userId: string
      ├── questId: string
      ├── progress: array<number>
      ├── status: string (active|completed|claimed|expired)
      ├── completedAt: timestamp?
      ├── claimedAt: timestamp?
      └── assignedAt: timestamp

guilds/
  └── {guildId}/
      ├── name: string
      ├── description: string
      ├── iconUrl: string?
      ├── bannerUrl: string?
      ├── leaderId: string
      ├── memberCount: number
      ├── maxMembers: number
      ├── totalPowerLevel: number
      ├── weeklyXp: number
      ├── rank: number
      ├── isPublic: boolean
      ├── requirements: map?
      │   ├── minRank: number?
      │   └── minPowerLevel: number?
      ├── createdAt: timestamp
      └── updatedAt: timestamp

guild_members/
  └── {guildId}/
      └── members/
          └── {userId}/
              ├── role: string (leader|officer|member)
              ├── weeklyXp: number
              ├── joinedAt: timestamp
              └── lastActiveAt: timestamp

leaderboards/
  └── {period}/ (daily|weekly|monthly|alltime)
      └── {leaderboardId}/
          ├── type: string (global|guild|attribute)
          ├── attribute: string?
          ├── entries: array<map>
          │   ├── userId: string
          │   ├── displayName: string
          │   ├── avatarUrl: string?
          │   ├── rank: number
          │   ├── value: number
          │   └── position: number
          ├── updatedAt: timestamp
          └── period: string

rivalries/
  └── {rivalryId}/
      ├── challengerId: string
      ├── challengedId: string
      ├── status: string (pending|active|completed|declined)
      ├── metric: string (totalXp|attribute|activities)
      ├── attribute: string?
      ├── duration: number (days)
      ├── startsAt: timestamp?
      ├── endsAt: timestamp?
      ├── challengerProgress: number
      ├── challengedProgress: number
      ├── winnerId: string?
      └── createdAt: timestamp
```

### 4.2 Indexes Required

```
// Composite indexes for Firestore

// Activities by user, ordered by date
activities: userId ASC, completedAt DESC

// Activities by user and attribute
activities: userId ASC, attribute ASC, completedAt DESC

// User quests by user and status
user_quests: userId ASC, status ASC, assignedAt DESC

// Guild members by guild
guild_members/{guildId}/members: weeklyXp DESC

// Leaderboard queries
leaderboards: type ASC, period ASC, updatedAt DESC
```

---

## 5. API Design

### 5.1 Authentication Endpoints

```dart
// Firebase Auth handles these, but conceptually:

POST   /auth/register          // Create account
POST   /auth/login             // Sign in
POST   /auth/logout            // Sign out
POST   /auth/refresh           // Refresh token
POST   /auth/forgot-password   // Password reset
DELETE /auth/account           // Delete account
```

### 5.2 Character Endpoints

```dart
GET    /characters/{userId}              // Get character
POST   /characters                       // Create character (on signup)
PATCH  /characters/{userId}              // Update character
GET    /characters/{userId}/stats        // Get detailed stats
POST   /characters/{userId}/add-xp       // Add XP (triggered by activities)
```

### 5.3 Activity Endpoints

```dart
GET    /activities                       // List user's activities
POST   /activities                       // Log new activity
GET    /activities/{id}                  // Get activity details
PATCH  /activities/{id}                  // Update activity
DELETE /activities/{id}                  // Delete activity
POST   /activities/{id}/verify           // Submit verification
GET    /activity-templates               // Get available templates
POST   /activity-templates               // Create custom template
```

### 5.4 Quest Endpoints

```dart
GET    /quests/daily                     // Get today's daily quests
GET    /quests/weekly                    // Get this week's quests
GET    /quests/epic                      // Get active epic quests
GET    /user-quests                      // Get user's quest progress
POST   /user-quests/{questId}/claim      // Claim quest reward
```

### 5.5 Guild Endpoints

```dart
GET    /guilds                           // List/search guilds
POST   /guilds                           // Create guild
GET    /guilds/{id}                      // Get guild details
PATCH  /guilds/{id}                      // Update guild (leader only)
DELETE /guilds/{id}                      // Delete guild
POST   /guilds/{id}/join                 // Request to join
POST   /guilds/{id}/leave                // Leave guild
GET    /guilds/{id}/members              // List members
PATCH  /guilds/{id}/members/{userId}     // Update member role
DELETE /guilds/{id}/members/{userId}     // Kick member
GET    /guilds/{id}/leaderboard          // Guild internal leaderboard
```

### 5.6 Social Endpoints

```dart
GET    /users/{id}/profile               // Get public profile
POST   /users/{id}/follow                // Follow user
DELETE /users/{id}/follow                // Unfollow user
GET    /users/{id}/followers             // List followers
GET    /users/{id}/following             // List following
POST   /rivalries                        // Challenge to rivalry
PATCH  /rivalries/{id}                   // Accept/decline rivalry
GET    /rivalries                        // List user's rivalries
```

### 5.7 Leaderboard Endpoints

```dart
GET    /leaderboards/global              // Global leaderboard
GET    /leaderboards/global?period=week  // Weekly leaderboard
GET    /leaderboards/attribute/{attr}    // Attribute-specific
GET    /leaderboards/guilds              // Guild rankings
GET    /leaderboards/friends             // Friends leaderboard
```

---

## 6. State Management

### 6.1 BLoC Architecture

```dart
// Example: CharacterBloc

// Events
abstract class CharacterEvent {}
class LoadCharacter extends CharacterEvent {}
class AddXp extends CharacterEvent {
  final AttributeType attribute;
  final int amount;
}
class UpdateBuildPath extends CharacterEvent {
  final BuildPath path;
}

// States
abstract class CharacterState {}
class CharacterInitial extends CharacterState {}
class CharacterLoading extends CharacterState {}
class CharacterLoaded extends CharacterState {
  final Character character;
}
class CharacterError extends CharacterState {
  final String message;
}
class LevelUp extends CharacterState {
  final Character character;
  final AttributeType attribute;
  final int newLevel;
}
class RankUp extends CharacterState {
  final Character character;
  final Rank newRank;
}

// Bloc
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacter getCharacter;
  final UpdateAttribute updateAttribute;
  final CalculatePowerLevel calculatePowerLevel;

  CharacterBloc({
    required this.getCharacter,
    required this.updateAttribute,
    required this.calculatePowerLevel,
  }) : super(CharacterInitial()) {
    on<LoadCharacter>(_onLoadCharacter);
    on<AddXp>(_onAddXp);
    on<UpdateBuildPath>(_onUpdateBuildPath);
  }

  // Implementation...
}
```

### 6.2 State Flow

```
User Action → Event → BLoC → Use Case → Repository → Data Source
                ↓
            New State → UI Update
                ↓
         (if level/rank up)
                ↓
         Animation Trigger
```

---

## 7. Security Considerations

### 7.1 Authentication

- Firebase Auth with email verification required
- Social login (Google, Apple) for convenience
- JWT tokens with short expiry (1 hour)
- Refresh tokens stored securely (Keychain/Keystore)
- Biometric authentication for sensitive actions

### 7.2 Data Security

- All API calls over HTTPS
- Firestore security rules enforce user ownership
- Sensitive data encrypted at rest
- No PII in analytics events
- GDPR-compliant data export/deletion

### 7.3 Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users can only read/write their own data
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }

    match /characters/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }

    match /activities/{activityId} {
      allow read: if request.auth != null
                  && resource.data.userId == request.auth.uid;
      allow create: if request.auth != null
                    && request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null
                            && resource.data.userId == request.auth.uid;
    }

    // Guilds: public read, member-restricted write
    match /guilds/{guildId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth != null
                    && isGuildLeader(guildId);
      allow delete: if request.auth != null
                    && isGuildLeader(guildId);
    }

    // Activity templates: read all, create own, modify own
    match /activity_templates/{templateId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null
                            && resource.data.createdBy == request.auth.uid;
    }
  }
}
```

### 7.4 Anti-Cheat Measures

1. **Server-side XP calculation**: Client sends activity, server calculates XP
2. **Rate limiting**: Max activities per hour/day
3. **Anomaly detection**: Flag suspicious XP gains
4. **Photo verification**: Required for high-XP activities
5. **Integration verification**: Cross-check with Apple Health/Strava
6. **Guild policing**: Members can report suspicious activity

---

## 8. Performance Optimization

### 8.1 Caching Strategy

| Data Type | Cache Location | TTL | Invalidation |
|-----------|----------------|-----|--------------|
| User profile | Memory + Disk | 1 hour | On update |
| Character | Memory + Disk | 5 min | On XP gain |
| Activity templates | Disk | 24 hours | On app start |
| Leaderboards | Memory | 5 min | Auto-refresh |
| Guild data | Memory | 10 min | On membership change |

### 8.2 Lazy Loading

- Paginate activity history (20 per page)
- Lazy load guild members list
- Progressive image loading with placeholders
- Defer non-critical animations

### 8.3 Offline Support

- Queue activities for sync when online
- Cache today's quests locally
- Optimistic UI updates
- Conflict resolution: server wins

---

## 9. Testing Strategy

### 9.1 Test Pyramid

```
         ╱╲
        ╱  ╲
       ╱ E2E ╲         10% - Critical user flows
      ╱────────╲
     ╱Integration╲     30% - BLoCs, repositories
    ╱──────────────╲
   ╱     Unit       ╲   60% - Use cases, utilities
  ╱──────────────────╲
```

### 9.2 Test Coverage Targets

| Layer | Coverage Target |
|-------|-----------------|
| Domain (use cases) | 90% |
| Data (repositories) | 80% |
| Presentation (BLoCs) | 80% |
| Widgets | 60% |
| E2E flows | Key paths |

### 9.3 Testing Tools

- **Unit tests**: flutter_test, mocktail
- **Widget tests**: flutter_test
- **Integration tests**: integration_test package
- **E2E tests**: Patrol or Maestro
- **Golden tests**: golden_toolkit

---

## 10. DevOps & Deployment

### 10.1 CI/CD Pipeline

```
Push to main
     ↓
┌─────────────┐
│   Analyze   │  dart analyze, flutter analyze
└──────┬──────┘
       ↓
┌─────────────┐
│    Test     │  flutter test
└──────┬──────┘
       ↓
┌─────────────┐
│    Build    │  flutter build (iOS + Android)
└──────┬──────┘
       ↓
┌─────────────────────────────────┐
│         Deploy                   │
│  ┌─────────┐    ┌─────────┐     │
│  │ TestFlight│   │Firebase │     │
│  │  (iOS)   │    │App Dist │     │
│  └─────────┘    └─────────┘     │
└─────────────────────────────────┘
```

### 10.2 Environments

| Environment | Purpose | Firebase Project |
|-------------|---------|-----------------|
| Development | Local development | zero-dev |
| Staging | QA testing | zero-staging |
| Production | Live users | zero-prod |

### 10.3 Release Process

1. Feature branches → `develop`
2. Release branch from `develop`
3. QA on staging
4. Merge to `main`
5. Tag release
6. Automated deployment to stores

---

## 11. Monitoring & Analytics

### 11.1 Observability Stack

- **Crashes**: Firebase Crashlytics
- **Analytics**: Firebase Analytics + Mixpanel
- **Performance**: Firebase Performance Monitoring
- **Logs**: Cloud Logging (production errors)

### 11.2 Key Events to Track

```dart
// User lifecycle
'user_signed_up'
'user_logged_in'
'onboarding_completed'
'character_created'

// Core actions
'activity_logged'
'activity_verified'
'quest_completed'
'quest_claimed'
'level_up'
'rank_up'

// Social
'guild_created'
'guild_joined'
'rivalry_started'
'user_followed'

// Monetization
'premium_viewed'
'premium_started'
'premium_cancelled'
```

---

*Document Version: 1.0*
*Last Updated: January 2025*
