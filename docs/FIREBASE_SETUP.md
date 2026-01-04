# Firebase Setup Guide (Free Spark Plan)

This guide walks you through setting up Firebase for ZERO using the **free Spark plan**.

## Free Tier Limits (Spark Plan)

| Service | Free Limit |
|---------|------------|
| Authentication | Unlimited users |
| Firestore | 1 GB storage, 50K reads/day, 20K writes/day |
| Cloud Storage | 5 GB storage, 1 GB/day download |
| Hosting | 10 GB storage, 360 MB/day transfer |

These limits are **more than sufficient** for development and early users.

---

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"**
3. Enter project name: `zero-app` (or your preferred name)
4. Disable Google Analytics (optional, saves setup time)
5. Click **"Create project"**

---

## Step 2: Enable Authentication

1. In Firebase Console, go to **Build > Authentication**
2. Click **"Get started"**
3. Enable the following providers:

### Email/Password
- Click **Email/Password**
- Enable **"Email/Password"**
- Click **Save**

### Google Sign-In
- Click **Google**
- Enable it
- Set a support email
- Click **Save**

---

## Step 3: Create Firestore Database

1. Go to **Build > Firestore Database**
2. Click **"Create database"**
3. Select **"Start in production mode"** (we'll add rules)
4. Choose a location close to your users (e.g., `us-central1`)
5. Click **Enable**

### Deploy Security Rules
1. Go to **Firestore > Rules**
2. Copy the contents of `firebase/firestore.rules`
3. Click **Publish**

### Deploy Indexes
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init firestore`
4. Deploy: `firebase deploy --only firestore:indexes`

---

## Step 4: Add Apps

### Android App
1. Go to **Project Settings > General**
2. Click **"Add app"** > Android
3. Android package name: `com.zeroapp.zero`
4. App nickname: `ZERO Android`
5. Download `google-services.json`
6. Place it in `android/app/google-services.json`

### iOS App
1. Click **"Add app"** > iOS
2. iOS bundle ID: `com.zeroapp.zero`
3. App nickname: `ZERO iOS`
4. Download `GoogleService-Info.plist`
5. Place it in `ios/Runner/GoogleService-Info.plist`

---

## Step 5: Configure Flutter Project

### Android Configuration

1. Edit `android/build.gradle.kts`:
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

2. Edit `android/app/build.gradle.kts`:
```kotlin
plugins {
    id("com.google.gms.google-services")
}

android {
    defaultConfig {
        minSdk = 23  // Required for Firebase
    }
}
```

### iOS Configuration

1. Open `ios/Runner.xcworkspace` in Xcode
2. Ensure `GoogleService-Info.plist` is in the Runner folder
3. Update `ios/Runner/Info.plist` for Google Sign-In:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

Replace `YOUR_REVERSED_CLIENT_ID` with the value from `GoogleService-Info.plist`.

---

## Step 6: Seed Default Activity Templates

Run this in Firebase Console > Firestore > Data:

Create collection `activity_templates` with these documents:

```json
// Vitality Activities
{
  "name": "Gym Workout",
  "attribute": "vitality",
  "baseXp": 25,
  "description": "Weight training or cardio session",
  "category": "fitness",
  "isDefault": true
}

{
  "name": "Run/Jog",
  "attribute": "vitality",
  "baseXp": 20,
  "description": "Running or jogging session",
  "category": "fitness",
  "isDefault": true
}

{
  "name": "Walk 10K Steps",
  "attribute": "vitality",
  "baseXp": 15,
  "description": "Complete 10,000 steps",
  "category": "fitness",
  "isDefault": true
}

{
  "name": "Healthy Meal",
  "attribute": "vitality",
  "baseXp": 10,
  "description": "Prepare and eat a healthy meal",
  "category": "nutrition",
  "isDefault": true
}

// Intellect Activities
{
  "name": "Read 30 Minutes",
  "attribute": "intellect",
  "baseXp": 15,
  "description": "Read a book for 30 minutes",
  "category": "learning",
  "isDefault": true
}

{
  "name": "Online Course",
  "attribute": "intellect",
  "baseXp": 25,
  "description": "Complete a lesson in an online course",
  "category": "learning",
  "isDefault": true
}

{
  "name": "Learn New Skill",
  "attribute": "intellect",
  "baseXp": 30,
  "description": "Practice a new skill for 30+ minutes",
  "category": "learning",
  "isDefault": true
}

// Prosperity Activities
{
  "name": "Save Money",
  "attribute": "prosperity",
  "baseXp": 20,
  "description": "Transfer money to savings",
  "category": "finance",
  "isDefault": true
}

{
  "name": "Budget Review",
  "attribute": "prosperity",
  "baseXp": 15,
  "description": "Review and update your budget",
  "category": "finance",
  "isDefault": true
}

{
  "name": "Side Hustle",
  "attribute": "prosperity",
  "baseXp": 25,
  "description": "Work on side income project",
  "category": "income",
  "isDefault": true
}

// Agility Activities
{
  "name": "Morning Routine",
  "attribute": "agility",
  "baseXp": 15,
  "description": "Complete your morning routine",
  "category": "habits",
  "isDefault": true
}

{
  "name": "Evening Review",
  "attribute": "agility",
  "baseXp": 10,
  "description": "Review your day and plan tomorrow",
  "category": "habits",
  "isDefault": true
}

{
  "name": "Meditation",
  "attribute": "agility",
  "baseXp": 15,
  "description": "Meditate for 10+ minutes",
  "category": "mindfulness",
  "isDefault": true
}

// Charisma Activities
{
  "name": "Networking",
  "attribute": "charisma",
  "baseXp": 20,
  "description": "Attend a networking event or reach out to contacts",
  "category": "social",
  "isDefault": true
}

{
  "name": "Quality Time",
  "attribute": "charisma",
  "baseXp": 15,
  "description": "Spend quality time with friends/family",
  "category": "relationships",
  "isDefault": true
}

{
  "name": "Help Someone",
  "attribute": "charisma",
  "baseXp": 15,
  "description": "Help someone with a task or problem",
  "category": "kindness",
  "isDefault": true
}
```

---

## Step 7: Test the Setup

1. Run the app: `flutter run`
2. Create an account
3. Check Firestore console - you should see:
   - A document in `users` collection
   - A document in `characters` collection

---

## Monitoring Usage

To stay within free limits:

1. Go to **Usage and billing** in Firebase Console
2. Monitor daily reads/writes
3. Set up budget alerts (optional)

### Optimization Tips

- The app uses local caching (Hive) to reduce Firestore reads
- Character data is cached for 5 minutes
- Activity templates are cached for 1 hour
- Pagination is used for activity history

---

## Upgrading to Blaze (Pay-as-you-go)

When you have real users and need more capacity:

1. Go to **Usage and billing > Modify plan**
2. Select **Blaze (pay as you go)**
3. Add a payment method
4. Set a budget alert

Blaze plan is still free for the same limits as Spark, you only pay for overages.

---

## Troubleshooting

### "Permission denied" errors
- Check Firestore rules are published
- Ensure user is authenticated
- Check userId matches the document owner

### Google Sign-In not working
- Verify SHA-1 fingerprint is added in Firebase Console
- Check `google-services.json` is up to date
- Ensure OAuth consent screen is configured

### iOS build fails
- Run `cd ios && pod install`
- Ensure `GoogleService-Info.plist` is in Xcode project
- Check minimum iOS version is 12.0+

---

*Document Version: 1.0*
