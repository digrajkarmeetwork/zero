# ZERO - Product Requirements Document

## Executive Summary

**ZERO** is a gamified life progression mobile app that transforms personal development into an immersive RPG experience. Users start at "Rank Zero" and ascend through increasingly prestigious ranks by completing real-world challenges across multiple life dimensions. The app combines habit tracking, goal setting, and social competition into a cohesive system that makes self-improvement feel like playing a game.

**Tagline**: *"From Zero to Legendary"*

---

## 1. Product Vision

### 1.1 Problem Statement

Current self-improvement apps suffer from:
- **Motivation decay**: Users lose interest after initial enthusiasm fades
- **Fragmented tracking**: Health, finances, skills tracked in separate apps
- **Meaningless metrics**: Arbitrary numbers that don't translate to real progress
- **Isolation**: Self-improvement feels like a solo, lonely journey
- **One-size-fits-all**: No personalization for different life priorities

### 1.2 Solution

ZERO solves these problems by:
- Creating a **rank-based progression system** with tangible milestones
- Unifying **all life dimensions** into one coherent character sheet
- Tying **levels to verified, meaningful actions** (not just logging)
- Building **guilds and rivalries** for accountability and competition
- Allowing users to **specialize their build** based on personal goals

### 1.3 Core Philosophy

> "Every master was once a disaster. Every legend started at zero."

The app embraces the journey from absolute beginner to mastery. Unlike apps that shame users for missed days, ZERO celebrates the grind and acknowledges that setbacks are part of any progression arc.

---

## 2. Brand Identity

### 2.1 Name Rationale

**ZERO** works on multiple levels:
- Starting point: Everyone begins at Rank Zero
- Clean slate: No judgment about where you've been
- Infinite potential: Zero is the origin of all numbers
- Memorable: Short, punchy, universal

### 2.2 Visual Identity

| Element | Description |
|---------|-------------|
| **Primary Colors** | Deep black (#0A0A0A), Electric blue (#00D4FF), Gold accents (#FFD700) |
| **Secondary Colors** | Rank-specific auras (explained in progression system) |
| **Typography** | Modern geometric sans-serif (Eurostile, Rajdhani, or custom) |
| **Aesthetic** | Dark mode default, glowing UI elements, particle effects on achievements |
| **Mascot/Icon** | Abstract "0" that transforms as user ranks up |

### 2.3 Tone of Voice

- **Motivational but not cheesy**: "You showed up. That's the hardest part."
- **Game-like**: Uses RPG terminology naturally (XP, stats, buffs, debuffs)
- **Respectful**: Never mocks failures, reframes them as "temporary setbacks"
- **Ambitious**: Encourages thinking big while acting small

---

## 3. Target Audience

### 3.1 Primary Personas

#### Persona 1: "The Gamer" (Age 18-28)
- Spends significant time gaming
- Understands RPG mechanics intuitively
- Wants to apply gaming mindset to real life
- Motivated by achievements, leaderboards, rare rewards
- **Pain point**: Feels like games are more rewarding than real life

#### Persona 2: "The Optimizer" (Age 25-35)
- Already tracks habits/fitness/finances
- Uses multiple apps that don't talk to each other
- Loves data, dashboards, and metrics
- Motivated by efficiency and seeing patterns
- **Pain point**: Context-switching between apps, no unified view

#### Persona 3: "The Comeback Kid" (Age 20-40)
- Has tried and failed at self-improvement before
- Feels stuck or behind peers
- Needs a fresh start without baggage
- Motivated by visible progress and second chances
- **Pain point**: Shame from past failures, analysis paralysis

### 3.2 Secondary Personas

- **Fitness enthusiasts** wanting to gamify gym progress
- **Students** balancing academics, health, and social life
- **Remote workers** needing structure and accountability
- **Content creators** who can share their progression journey

### 3.3 Anti-Personas (Not Target Users)

- Users wanting a simple, minimal habit tracker
- Those uncomfortable with gaming metaphors
- People seeking clinical health tracking (medical apps)
- Users who find competition demotivating

---

## 4. Core Features

### 4.1 The Attribute System

Users have **5 core attributes** that represent life dimensions:

| Attribute | Symbol | Represents | Example Activities |
|-----------|--------|------------|-------------------|
| **Vitality (VIT)** | ❤️ | Physical health | Workouts, sleep, nutrition, medical checkups |
| **Intellect (INT)** | 🧠 | Mental growth | Reading, courses, learning skills, puzzles |
| **Prosperity (PRS)** | 💰 | Financial health | Saving, investing, debt payoff, income growth |
| **Agility (AGI)** | ⚡ | Consistency & habits | Streak maintenance, routine adherence |
| **Charisma (CHA)** | 👥 | Social & relationships | Networking, quality time, communication |

Each attribute:
- Has a level from 1-100
- Gains XP from completed activities
- Has sub-stats for granular tracking
- Contributes to overall **Power Level**

### 4.2 The Rank System

Users progress through **10 ranks** based on their combined Power Level:

| Rank | Power Level | Title | Aura Color | Unlock |
|------|-------------|-------|------------|--------|
| 0 | 0-99 | Unranked | None | Starting rank |
| 1 | 100-299 | Bronze | Brown | Basic features |
| 2 | 300-599 | Iron | Gray | Custom habits |
| 3 | 600-999 | Steel | Silver | Guild creation |
| 4 | 1000-1499 | Gold | Gold | Advanced analytics |
| 5 | 1500-2099 | Platinum | White | Mentor system |
| 6 | 2100-2799 | Diamond | Light blue | Exclusive quests |
| 7 | 2800-3599 | Master | Purple | Leaderboard eligibility |
| 8 | 3600-4499 | Grandmaster | Red | Badge creation |
| 9 | 4500-5499 | Legend | Multi-color | Hall of Fame |
| 10 | 5500+ | Mythic | Animated | Legacy rewards |

### 4.3 Activity & Quest System

#### Daily Activities
- Small, repeatable actions that give consistent XP
- Examples: "Drink 8 glasses of water" (+5 VIT XP), "Read 20 pages" (+10 INT XP)
- Streaks provide **Agility XP** bonus

#### Quests
- Time-bound challenges with larger XP rewards
- Types:
  - **Daily Quests**: Refresh every 24 hours (e.g., "Complete 3 activities")
  - **Weekly Quests**: Larger goals (e.g., "Work out 4 times this week")
  - **Epic Quests**: Month-long challenges (e.g., "Save $500 this month")
  - **Legendary Quests**: Life milestones (e.g., "Run a marathon")

#### Dungeons (Premium Feature)
- Intensive 7-30 day focused challenges
- Examples: "The Iron Temple" (30-day workout program), "The Vault" (savings challenge)
- Completion grants exclusive titles and cosmetics

### 4.4 Verification System

To prevent cheating and make progress meaningful:

| Verification Level | Method | XP Multiplier |
|-------------------|--------|---------------|
| Self-reported | User marks complete | 1.0x |
| Photo proof | Upload image evidence | 1.25x |
| Integration verified | Connected app confirms | 1.5x |
| Witness verified | Guild member confirms | 1.5x |
| GPS/time verified | Location + timestamp | 1.75x |

Supported integrations:
- Apple Health / Google Fit (workouts, steps, sleep)
- Strava (runs, cycling)
- Bank APIs via Plaid (savings goals)
- Calendar APIs (habit completion)

### 4.5 Social Features

#### Guilds
- Groups of 5-50 users
- Shared guild rank based on combined activity
- Guild quests that require collaboration
- Guild chat and announcements
- Weekly guild leaderboards

#### Rivals
- 1v1 competitive matchups
- Challenge rivals to specific metrics
- Wager XP on outcomes
- Public rivalry leaderboards

#### Spectating
- Follow other users' journeys
- View public character sheets
- React to milestones
- Share achievements to social media

### 4.6 Character Customization

#### Titles
- Earned through achievements (e.g., "Early Riser", "Iron Mind", "Debt Slayer")
- Displayed on profile
- Show dedication to specific paths

#### Cosmetics
- Profile frames based on rank
- Animated auras for high ranks
- Achievement badges
- Custom themes (earned or purchased)

#### Build Paths
- Users can declare a "main class" focus:
  - **Warrior**: VIT-focused
  - **Scholar**: INT-focused
  - **Merchant**: PRS-focused
  - **Phantom**: AGI-focused
  - **Diplomat**: CHA-focused
- Class provides +20% XP in primary attribute
- Encourages specialization while still tracking everything

---

## 5. MVP Scope (Version 1.0)

### 5.1 Must Have (P0)

- [ ] User authentication (email, Google, Apple)
- [ ] Character creation with attribute allocation
- [ ] 5 core attributes with leveling
- [ ] Basic activity logging (self-reported)
- [ ] Daily quest system
- [ ] Rank progression (Ranks 0-5)
- [ ] Profile page with character sheet
- [ ] Basic streak tracking
- [ ] Push notification reminders
- [ ] Onboarding tutorial

### 5.2 Should Have (P1)

- [ ] Apple Health / Google Fit integration
- [ ] Photo verification for activities
- [ ] Weekly quests
- [ ] Basic social (follow/spectate)
- [ ] Achievement system (10-15 achievements)
- [ ] Dark/light mode toggle
- [ ] Basic analytics dashboard

### 5.3 Could Have (P2)

- [ ] Guilds (basic implementation)
- [ ] Rival system
- [ ] Custom activity creation
- [ ] Epic quests
- [ ] Calendar integration
- [ ] Export data feature

### 5.4 Won't Have in MVP (P3)

- Dungeons
- Financial integrations (Plaid)
- Animated cosmetics
- Guild wars
- Marketplace
- AI coaching

---

## 6. Success Metrics

### 6.1 North Star Metric

**Weekly Active Users completing 5+ activities**

This metric captures:
- Retention (weekly active)
- Engagement (completing activities, not just opening)
- Habit formation (5+ shows routine)

### 6.2 Supporting Metrics

| Category | Metric | Target (Month 3) |
|----------|--------|------------------|
| Acquisition | App downloads | 10,000 |
| Activation | Onboarding completion | 70% |
| Retention | Day 7 retention | 40% |
| Retention | Day 30 retention | 20% |
| Engagement | Avg activities/user/week | 8 |
| Engagement | Avg session duration | 4 min |
| Revenue | Conversion to premium | 5% |
| Viral | Shares per user | 0.3 |

### 6.3 Qualitative Metrics

- App Store rating > 4.5
- NPS score > 50
- User testimonials on real progress achieved

---

## 7. Monetization Strategy

### 7.1 Freemium Model

**Free Tier**:
- All 5 attributes and leveling
- Basic activities and quests
- Ranks 0-5 progression
- 1 guild membership
- Core social features

**Premium Tier ($7.99/month or $59.99/year)**:
- Ranks 6-10 progression
- Dungeons access
- Advanced analytics
- Unlimited custom activities
- Premium cosmetics
- Priority support
- Ad-free experience
- Integration with financial apps

### 7.2 Additional Revenue

- **Cosmetic shop**: One-time purchase profile customizations
- **Guild upgrades**: Larger guild capacity, custom guild badges
- **Partnerships**: Sponsored quests from fitness brands, learning platforms

### 7.3 What Will Never Be Monetized

- Core progression mechanics
- Basic habit tracking
- Pay-to-win XP boosts (would undermine the app's philosophy)

---

## 8. Competitive Analysis

| App | Strengths | Weaknesses | ZERO Differentiation |
|-----|-----------|------------|---------------------|
| **Habitica** | Deep RPG mechanics, social | Dated UI, overwhelming | Modern design, simpler onboarding |
| **Fabulous** | Beautiful design, coaching | Single-focus, expensive | Multi-dimensional, competitive |
| **Streaks** | Simple, Apple-native | No gamification, solo | Full RPG system, social |
| **Level Up Life** | Good gamification | Limited features, no social | Deeper progression, guilds |
| **LifeRPG** | Customizable | Ugly, complex, abandoned | Active development, polished |

**ZERO's Unique Position**: The only app combining multi-life-dimension tracking with deep rank progression, verified activities, and meaningful social competition in a modern, beautiful package.

---

## 9. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Users find it too complex | Medium | High | Gradual feature unlocking, excellent onboarding |
| Cheating undermines trust | High | High | Verification system, guild-policing |
| Gamification feels hollow | Medium | High | Tie XP to real milestones, user testimonials |
| Low retention after novelty | High | High | Social hooks, guild accountability, varied quests |
| Competition demotivates | Medium | Medium | Optional competitive features, focus on personal bests |

---

## 10. Open Questions

1. Should there be attribute decay for inactivity, or only positive progression?
2. How to handle users with disabilities who can't do certain physical activities?
3. Should premium be required for Ranks 6-10, or just for cosmetics?
4. What's the right guild size to balance intimacy and activity?
5. How to prevent toxic competition while encouraging healthy rivalry?

---

*Document Version: 1.0*
*Last Updated: January 2025*
*Author: Product Team*
