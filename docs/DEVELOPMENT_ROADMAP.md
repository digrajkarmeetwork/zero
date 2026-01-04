# ZERO - Development Roadmap

## Overview

This document outlines the phased development approach for ZERO. Each phase builds upon the previous, allowing for iterative releases and user feedback incorporation.

---

## Phase 0: Project Setup & Foundation

### 0.1 Development Environment

- [ ] Initialize Flutter project with proper structure
- [ ] Configure linting rules (very_good_analysis)
- [ ] Set up Git repository and branching strategy
- [ ] Configure CI/CD pipeline (GitHub Actions / Codemagic)
- [ ] Set up Firebase projects (dev, staging, prod)
- [ ] Configure environment variables and flavors

### 0.2 Core Dependencies

```yaml
# pubspec.yaml core dependencies
dependencies:
  flutter_bloc: ^8.1.3
  go_router: ^12.0.0
  get_it: ^7.6.4
  injectable: ^2.3.2
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  dio: ^5.3.3
  hive_flutter: ^1.1.0
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_storage: ^11.5.0
  firebase_messaging: ^14.7.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.0

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  injectable_generator: ^2.4.1
  mocktail: ^1.0.1
  bloc_test: ^9.1.5
```

### 0.3 Architecture Setup

- [ ] Create folder structure per architecture document
- [ ] Set up dependency injection with get_it/injectable
- [ ] Create base classes (UseCase, Failure, etc.)
- [ ] Set up routing with go_router
- [ ] Create theme files and design tokens
- [ ] Build core widgets library (ZeroButton, ZeroCard, etc.)

### 0.4 Firebase Configuration

- [ ] Enable Authentication (Email, Google, Apple)
- [ ] Create Firestore database structure
- [ ] Set up security rules
- [ ] Configure Cloud Storage buckets
- [ ] Set up Cloud Functions project
- [ ] Enable Analytics and Crashlytics

**Deliverable**: Empty app shell that builds on iOS and Android with proper architecture in place.

---

## Phase 1: Core MVP (Authentication & Character)

### 1.1 Authentication

- [ ] **Sign Up Screen**
  - Email/password registration
  - Input validation
  - Error handling
  - Loading states

- [ ] **Sign In Screen**
  - Email/password login
  - "Forgot password" flow
  - Error handling

- [ ] **Social Authentication**
  - Google Sign In
  - Apple Sign In (required for iOS)

- [ ] **Auth State Management**
  - AuthBloc implementation
  - Persistent auth state
  - Auto-login on app restart

### 1.2 Onboarding Flow

- [ ] **Welcome Screen**
  - Animated introduction
  - Value proposition slides

- [ ] **Path Selection**
  - 5 build paths (Warrior, Scholar, Merchant, Phantom, Diplomat)
  - Visual selection UI
  - Store selection

- [ ] **Goal Setting**
  - Initial goal selection
  - Personalization questions

- [ ] **Character Creation**
  - Avatar selection (basic)
  - Username input
  - Create character in Firestore

### 1.3 Character System

- [ ] **Character Model & Repository**
  - Firestore integration
  - Local caching with Hive
  - Real-time updates

- [ ] **Character Screen**
  - Power level display
  - 5 attribute bars with levels
  - Current rank display
  - Equipped title
  - Build path indicator

- [ ] **XP System**
  - XP calculation utility
  - Level-up thresholds
  - Power level calculation
  - Build path bonus (+20%)

- [ ] **Rank System**
  - Rank thresholds (0-5 for MVP)
  - Rank-up detection
  - Rank display with colors

### 1.4 Basic Navigation

- [ ] Bottom navigation bar (5 tabs)
- [ ] Screen transitions
- [ ] Deep linking setup

**Deliverable**: Users can sign up, create a character, and view their (empty) character sheet.

---

## Phase 2: Activity Logging

### 2.1 Activity Templates

- [ ] **Default Templates**
  - Create 20+ default activity templates
  - Categorize by attribute
  - Define base XP values

- [ ] **Template Display**
  - Category-based browsing
  - Search/filter functionality
  - Recent activities section

### 2.2 Activity Logging

- [ ] **Log Activity Screen**
  - Quick-log from templates
  - Activity detail/confirmation
  - Notes field
  - Submit and save

- [ ] **Activity Repository**
  - Create activity in Firestore
  - Trigger XP calculation
  - Update character attributes

- [ ] **XP Gain Animation**
  - Floating +XP number
  - Attribute bar animation
  - Sound effect (optional)

### 2.3 Level Up Flow

- [ ] **Level Up Detection**
  - Check after each XP gain
  - Emit level-up event

- [ ] **Level Up Animation**
  - Full-screen celebration
  - Particle effects
  - Sound effects
  - Haptic feedback

### 2.4 Activity History

- [ ] **Activities List Screen**
  - Paginated activity history
  - Filter by attribute
  - Filter by date range

- [ ] **Activity Detail View**
  - View logged activity
  - Edit capability
  - Delete capability

### 2.5 Streak System

- [ ] **Streak Tracking**
  - Calculate current streak
  - Track longest streak
  - Streak break detection

- [ ] **Streak UI**
  - Fire icon with count
  - Streak-at-risk warning
  - Streak milestone celebrations (7, 30, 100 days)

**Deliverable**: Users can log activities, gain XP, level up attributes, and maintain streaks.

---

## Phase 3: Quests & Goals

### 3.1 Daily Quests

- [ ] **Quest Generation**
  - Cloud Function to generate daily quests
  - Assign quests at midnight (user timezone)
  - 3-4 quests per day

- [ ] **Quest Types**
  - Complete X activities
  - Earn X attribute XP
  - Log X different activity types
  - Maintain streak

- [ ] **Quest UI**
  - Quest list with progress bars
  - Completion status
  - Time until reset

- [ ] **Quest Completion**
  - Auto-detect completion
  - Claim reward button
  - XP reward animation

### 3.2 Weekly Quests

- [ ] **Weekly Quest System**
  - Larger goals spanning 7 days
  - Higher XP rewards
  - Reset on Monday

- [ ] **Quest Variety**
  - Multi-attribute challenges
  - Streak-based quests
  - Volume quests (total XP)

### 3.3 Quest Screen

- [ ] **Tab Navigation**
  - Daily / Weekly / Epic tabs
  - Quest filtering

- [ ] **Progress Tracking**
  - Real-time progress updates
  - Completion notifications

**Deliverable**: Users have daily and weekly quests to complete for bonus XP.

---

## Phase 4: Verification & Integrations

### 4.1 Photo Verification

- [ ] **Photo Capture**
  - Camera integration
  - Photo picker
  - Image compression

- [ ] **Photo Upload**
  - Upload to Firebase Storage
  - Link to activity record
  - 1.25x XP multiplier

- [ ] **Photo Display**
  - Show verification badge
  - View proof in activity detail

### 4.2 Apple Health Integration

- [ ] **Health Package Setup**
  - Request permissions
  - Handle permission states

- [ ] **Data Sync**
  - Read workouts
  - Read steps
  - Read sleep data

- [ ] **Auto-Logging**
  - Detect new health data
  - Prompt to log as activity
  - 1.5x XP multiplier

### 4.3 Google Fit Integration

- [ ] Same features as Apple Health for Android

### 4.4 Verification UI

- [ ] **Verification Options**
  - Show available verification methods
  - Display XP multipliers
  - Integration status indicators

**Deliverable**: Users can verify activities with photos or health data for bonus XP.

---

## Phase 5: Social Features (Basic)

### 5.1 User Profiles

- [ ] **Public Profile**
  - Display name, avatar
  - Current rank and power level
  - Attribute breakdown
  - Achievement showcase

- [ ] **Profile Privacy**
  - Public/private toggle
  - Control what's visible

### 5.2 Follow System

- [ ] **Follow/Unfollow**
  - Follow other users
  - Follower/following counts

- [ ] **Activity Feed**
  - See followed users' milestones
  - Level ups, rank ups, achievements

### 5.3 Leaderboards

- [ ] **Global Leaderboard**
  - Top users by power level
  - Weekly XP leaderboard

- [ ] **Friends Leaderboard**
  - Followed users only
  - Competitive comparison

- [ ] **Attribute Leaderboards**
  - Filter by specific attribute
  - Find specialists

**Deliverable**: Users can follow others and compete on leaderboards.

---

## Phase 6: Guilds

### 6.1 Guild Creation

- [ ] **Create Guild**
  - Name, description
  - Icon/banner upload
  - Public/private setting
  - Join requirements

### 6.2 Guild Management

- [ ] **Membership**
  - Join requests
  - Accept/reject members
  - Kick members
  - Leave guild

- [ ] **Roles**
  - Leader, Officer, Member
  - Role-based permissions

### 6.3 Guild Features

- [ ] **Guild Leaderboard**
  - Internal weekly rankings
  - Member contribution tracking

- [ ] **Guild Chat**
  - Basic text chat
  - System messages (joins, achievements)

- [ ] **Guild Quests**
  - Combined XP goals
  - Collaborative challenges

### 6.4 Guild Discovery

- [ ] **Search Guilds**
  - By name
  - By requirements
  - Recommended guilds

**Deliverable**: Users can join/create guilds and compete together.

---

## Phase 7: Polish & Monetization

### 7.1 Achievements System

- [ ] **Achievement Framework**
  - Achievement definitions
  - Progress tracking
  - Completion detection

- [ ] **Achievement Types**
  - Milestone achievements (first activity, first level up)
  - Streak achievements (7, 30, 100 days)
  - Attribute achievements (reach level 50 in any)
  - Social achievements (join guild, gain followers)

- [ ] **Achievement UI**
  - Achievement gallery
  - Progress indicators
  - Unlock animations

### 7.2 Titles & Cosmetics

- [ ] **Title System**
  - Earn titles from achievements
  - Equip titles to profile
  - Title display on character

- [ ] **Profile Customization**
  - Rank-based frames
  - Aura effects (high ranks)

### 7.3 Premium Features

- [ ] **Subscription Setup**
  - RevenueCat integration
  - iOS/Android subscription

- [ ] **Premium Features**
  - Ranks 6-10 access
  - Advanced analytics
  - Unlimited custom activities
  - Premium cosmetics

- [ ] **Paywall UI**
  - Feature comparison
  - Subscription options
  - Restore purchases

### 7.4 Push Notifications

- [ ] **Notification Types**
  - Streak reminders
  - Quest expiring
  - Level up celebrations
  - Guild activity

- [ ] **Notification Preferences**
  - Granular controls
  - Quiet hours

### 7.5 Settings & Account

- [ ] **Settings Screen**
  - Notification preferences
  - Theme toggle
  - Privacy settings
  - Connected accounts

- [ ] **Account Management**
  - Change password
  - Export data
  - Delete account

**Deliverable**: Full MVP with achievements, cosmetics, premium tier, and polish.

---

## Phase 8: Post-MVP Features

### 8.1 Rivalries

- [ ] Challenge users to 1v1 competitions
- [ ] Wager XP on outcomes
- [ ] Rivalry leaderboards

### 8.2 Dungeons

- [ ] Intensive multi-day challenges
- [ ] Exclusive rewards
- [ ] Premium feature

### 8.3 Epic Quests

- [ ] Month-long challenges
- [ ] Major life goals
- [ ] Legendary titles

### 8.4 Advanced Analytics

- [ ] Detailed progress charts
- [ ] Trend analysis
- [ ] Attribute radar chart
- [ ] Export capabilities

### 8.5 Calendar Integration

- [ ] Schedule activities
- [ ] Habit reminders
- [ ] Historical view

---

## Development Principles

### 1. Iterative Development

- Release early, gather feedback
- Each phase should be testable by users
- Don't build features nobody wants

### 2. Quality Standards

- Minimum 80% test coverage for business logic
- No feature ships without tests
- Performance budgets: app start < 2s, navigation < 300ms

### 3. Code Review Requirements

- All PRs require review
- Architecture decisions documented
- Breaking changes flagged

### 4. Documentation

- Update docs with each feature
- API documentation auto-generated
- Onboarding guide for new developers

---

## Release Strategy

### Alpha (Phase 1-2)
- Internal testing only
- Core functionality validation
- Bug discovery

### Beta (Phase 3-5)
- TestFlight / Play Store internal testing
- Limited external testers (100-500)
- Feature feedback collection

### Soft Launch (Phase 6-7)
- Limited geographic release
- Metrics validation
- Monetization testing

### Full Launch (Post-Phase 7)
- Global availability
- Marketing push
- Continuous iteration

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Scope creep | Strict phase boundaries, PM approval for additions |
| Technical debt | Dedicated refactoring sprints between phases |
| Low retention | Early user testing, iterate on feedback |
| Integration failures | Mock integrations, fallback to self-reporting |
| Scaling issues | Load testing before launch, Firebase scalability |

---

## Success Criteria per Phase

| Phase | Key Metric | Target |
|-------|-----------|--------|
| 0 | Build success | iOS + Android builds work |
| 1 | Onboarding completion | 80% of users finish |
| 2 | Activities logged/user/week | 5+ |
| 3 | Quest completion rate | 60% |
| 4 | Verification adoption | 30% of activities |
| 5 | Users with followers | 40% |
| 6 | Guild membership | 50% of actives |
| 7 | Premium conversion | 5% |

---

*Document Version: 1.0*
*Last Updated: January 2025*
