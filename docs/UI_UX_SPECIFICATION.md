# ZERO - UI/UX Specification Document

## 1. Design Principles

### 1.1 Core Principles

| Principle | Description |
|-----------|-------------|
| **Dark-First** | Dark mode as default; light mode secondary. Reduces eye strain, feels premium, matches gaming aesthetic. |
| **Glowing Progress** | Progress visualized through light/glow effects. Brighter = more progress. |
| **Minimal Friction** | Core actions (log activity, check quests) achievable in 2-3 taps max. |
| **Celebration** | Every achievement, level up, and milestone celebrated with animations. |
| **Information Density** | Show important stats at a glance; details on demand. |

### 1.2 Design Language: "Neon RPG"

The visual language combines:
- Dark backgrounds with vibrant accent colors
- Subtle gradients and glow effects
- Clean typography with a tech/gaming feel
- Card-based layouts with soft shadows
- Smooth, purposeful animations

---

## 2. Color System

### 2.1 Core Palette

```
Primary Background:    #0A0A0F (Near black with blue tint)
Secondary Background:  #12121A (Cards, elevated surfaces)
Tertiary Background:   #1A1A25 (Input fields, subtle separation)

Primary Accent:        #00D4FF (Electric blue - main actions)
Secondary Accent:      #FFD700 (Gold - achievements, premium)
Success:              #00FF88 (Green - completed, positive)
Warning:              #FFB800 (Orange - streaks at risk)
Error:                #FF4757 (Red - failures, destructive)

Text Primary:         #FFFFFF (Headlines, important)
Text Secondary:       #A0A0B0 (Body text, descriptions)
Text Tertiary:        #606070 (Hints, disabled)
```

### 2.2 Attribute Colors

Each attribute has a signature color used consistently:

| Attribute | Color | Hex |
|-----------|-------|-----|
| Vitality | Red/Crimson | #FF4757 |
| Intellect | Purple | #9B59FF |
| Prosperity | Gold | #FFD700 |
| Agility | Green | #00FF88 |
| Charisma | Pink/Magenta | #FF6B9D |

### 2.3 Rank Colors (Auras)

| Rank | Color | Gradient |
|------|-------|----------|
| 0 - Unranked | None | - |
| 1 - Bronze | Brown | #8B4513 → #CD853F |
| 2 - Iron | Gray | #5C5C5C → #8C8C8C |
| 3 - Steel | Silver | #A0A0A0 → #D0D0D0 |
| 4 - Gold | Gold | #DAA520 → #FFD700 |
| 5 - Platinum | White | #E0E0E0 → #FFFFFF |
| 6 - Diamond | Light Blue | #87CEEB → #00BFFF |
| 7 - Master | Purple | #8A2BE2 → #DA70D6 |
| 8 - Grandmaster | Red | #DC143C → #FF4500 |
| 9 - Legend | Rainbow | Animated gradient |
| 10 - Mythic | Animated | Particle effects |

---

## 3. Typography

### 3.1 Font Stack

**Primary Font**: Rajdhani (Google Fonts)
- Used for: Headlines, stats, numbers, ranks
- Weights: 500 (Medium), 600 (SemiBold), 700 (Bold)

**Secondary Font**: Inter (Google Fonts)
- Used for: Body text, descriptions, UI labels
- Weights: 400 (Regular), 500 (Medium), 600 (SemiBold)

**Monospace**: JetBrains Mono
- Used for: XP numbers, timers, codes

### 3.2 Type Scale

```
Display Large:   32px / Rajdhani Bold      (Power level, main stats)
Display Medium:  28px / Rajdhani SemiBold  (Screen titles)
Headline Large:  24px / Rajdhani SemiBold  (Section headers)
Headline Medium: 20px / Rajdhani Medium    (Card titles)
Title Large:     18px / Inter SemiBold     (List item titles)
Title Medium:    16px / Inter Medium       (Subtitles)
Body Large:      16px / Inter Regular      (Primary body text)
Body Medium:     14px / Inter Regular      (Secondary body text)
Label Large:     14px / Inter Medium       (Buttons, tabs)
Label Medium:    12px / Inter Medium       (Tags, badges)
Caption:         12px / Inter Regular      (Hints, timestamps)
```

---

## 4. Spacing & Layout

### 4.1 Spacing Scale

```
xs:  4px   (Tight spacing, inline elements)
sm:  8px   (Related elements)
md:  16px  (Standard spacing)
lg:  24px  (Section separation)
xl:  32px  (Major sections)
xxl: 48px  (Screen padding top/bottom)
```

### 4.2 Grid System

- **Screen padding**: 16px horizontal
- **Card padding**: 16px all sides
- **Card gap**: 12px between cards
- **Max content width**: 600px (for tablets)

### 4.3 Component Sizes

```
Button height (large):    56px
Button height (medium):   48px
Button height (small):    36px
Input height:            56px
Card minimum height:      80px
Avatar (small):          32px
Avatar (medium):         48px
Avatar (large):          80px
Icon (small):            20px
Icon (medium):           24px
Icon (large):            32px
```

---

## 5. Components

### 5.1 Buttons

#### Primary Button
```
Background: Linear gradient (#00D4FF → #0099CC)
Text: White, Label Large
Border radius: 12px
Shadow: 0 4px 15px rgba(0, 212, 255, 0.3)
Pressed: Scale to 0.98, shadow reduces
Disabled: 50% opacity, no shadow
```

#### Secondary Button
```
Background: Transparent
Border: 1px solid #00D4FF
Text: #00D4FF, Label Large
Border radius: 12px
Pressed: Background rgba(0, 212, 255, 0.1)
```

#### Ghost Button
```
Background: Transparent
Text: Text Secondary
Pressed: Background rgba(255, 255, 255, 0.05)
```

### 5.2 Cards

#### Standard Card
```
Background: #12121A
Border radius: 16px
Border: 1px solid rgba(255, 255, 255, 0.05)
Shadow: 0 4px 20px rgba(0, 0, 0, 0.3)
Padding: 16px
```

#### Highlighted Card (Active quest, streak)
```
Background: #12121A
Border: 1px solid rgba(0, 212, 255, 0.3)
Shadow: 0 0 20px rgba(0, 212, 255, 0.15)
```

#### Attribute Card
```
Background: Linear gradient from attribute color (10% opacity) to transparent
Border-left: 3px solid [attribute color]
```

### 5.3 Progress Bars

#### Attribute XP Bar
```
Track: #1A1A25
Fill: Gradient using attribute color
Height: 8px
Border radius: 4px
Animation: Fill animates on XP gain with glow pulse
```

#### Circular Progress (Power Level)
```
Track: #1A1A25
Fill: Gradient (#00D4FF → #00FF88)
Stroke width: 8px
Center: Power level number with glow
```

### 5.4 Input Fields

```
Background: #1A1A25
Border: 1px solid #2A2A35
Border radius: 12px
Text: White
Placeholder: #606070
Focus border: #00D4FF
Error border: #FF4757
Height: 56px
Padding: 16px
```

### 5.5 Bottom Navigation

```
Background: #0A0A0F with blur
Height: 80px (includes safe area)
Items: 5 (Home, Character, Activities, Quests, Profile)
Active: Icon + label, Primary Accent color, subtle glow
Inactive: Icon only, Text Tertiary
```

---

## 6. Screen Specifications

### 6.1 Splash Screen

```
┌─────────────────────────────┐
│                             │
│                             │
│                             │
│         ┌───────┐           │
│         │ ZERO  │           │  Animated logo
│         │  ◯    │           │  "0" morphs/pulses
│         └───────┘           │
│                             │
│        Loading...           │
│        ━━━━━━━━━━           │  Progress bar
│                             │
│                             │
└─────────────────────────────┘
```

### 6.2 Onboarding Flow

**Screen 1: Welcome**
```
┌─────────────────────────────┐
│                             │
│    [Animated character      │
│     silhouette rising]      │
│                             │
│    "Every Legend            │
│     Started at Zero"        │
│                             │
│    Begin your journey from  │
│    nothing to everything.   │
│                             │
│    ┌─────────────────────┐  │
│    │     Get Started     │  │
│    └─────────────────────┘  │
│                             │
│    Already have an account? │
│           Sign in           │
└─────────────────────────────┘
```

**Screen 2: Choose Your Path**
```
┌─────────────────────────────┐
│  ←                          │
│                             │
│    Choose Your Path         │
│    Focus on what matters    │
│    most to you              │
│                             │
│  ┌─────────────────────────┐│
│  │ ⚔️ Warrior              ││
│  │ Focus: Vitality (+20%)  ││
│  │ Master your body        ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 📚 Scholar              ││
│  │ Focus: Intellect (+20%) ││
│  │ Expand your mind        ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 💰 Merchant             ││
│  │ Focus: Prosperity (+20%)││
│  │ Build your wealth       ││
│  └─────────────────────────┘│
│      [Phantom] [Diplomat]   │
│                             │
│    You can change this later│
│                             │
│    ┌─────────────────────┐  │
│    │      Continue       │  │
│    └─────────────────────┘  │
└─────────────────────────────┘
```

**Screen 3: Set Your First Goal**
```
┌─────────────────────────────┐
│  ←                          │
│                             │
│    Set Your First Goal      │
│    What do you want to      │
│    achieve?                 │
│                             │
│  ┌─────────────────────────┐│
│  │ 🏋️ Get Fit              ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 📖 Learn Something New  ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 💵 Save Money           ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 🏃 Build a Habit        ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ✨ All of the Above     ││
│  └─────────────────────────┘│
│                             │
│    ┌─────────────────────┐  │
│    │    Let's Begin      │  │
│    └─────────────────────┘  │
└─────────────────────────────┘
```

### 6.3 Home Screen

```
┌─────────────────────────────┐
│  ZERO              🔔  ⚙️   │
│                             │
│  ┌─────────────────────────┐│
│  │    ┌─────────┐          ││
│  │    │  Avatar │   Lv.12  ││
│  │    │   👤    │   Rank 2 ││
│  │    └─────────┘   IRON   ││
│  │                         ││
│  │  ◯━━━━━━━━━━━━━━━━━━━◯  ││
│  │     Power Level: 423    ││
│  │     Next rank: 600      ││
│  └─────────────────────────┘│
│                             │
│  Today's Progress           │
│  ┌──────┐ ┌──────┐ ┌──────┐│
│  │VIT 12│ │INT  8│ │PRS  3││
│  │██░░░░│ │████░░│ │█░░░░░││
│  └──────┘ └──────┘ └──────┘│
│  ┌──────┐ ┌──────┐          │
│  │AGI 15│ │CHA  5│          │
│  │██████│ │██░░░░│          │
│  └──────┘ └──────┘          │
│                             │
│  🔥 7 Day Streak!           │
│                             │
│  Daily Quests         2/3 ▶│
│  ┌─────────────────────────┐│
│  │ ☑️ Complete 3 activities ││
│  │ ☐ Earn 50 VIT XP        ││
│  │ ☑️ Log in               ││
│  └─────────────────────────┘│
│                             │
│  Quick Log            + Add │
│  ┌─────┐┌─────┐┌─────┐┌────┐│
│  │Workout│Read │ Save │Walk ││
│  └─────┘└─────┘└─────┘└────┘│
│                             │
├─────────────────────────────┤
│  🏠    👤    ➕    📋    ⚙️  │
│ Home  Char  Log  Quest Prof │
└─────────────────────────────┘
```

### 6.4 Character Screen

```
┌─────────────────────────────┐
│  ←  Character               │
│                             │
│        ┌─────────────┐      │
│        │             │      │
│        │   AVATAR    │      │
│        │    with     │      │
│        │    AURA     │      │
│        │             │      │
│        └─────────────┘      │
│                             │
│      "The Dedicated"        │  (Equipped title)
│         Iron Rank           │
│                             │
│   ┌─────────────────────┐   │
│   │ ◉━━━━━━━━━━━━━━━━━◯ │   │
│   │   Power Level: 423  │   │
│   │   177 to next rank  │   │
│   └─────────────────────┘   │
│                             │
│  Attributes                 │
│  ┌─────────────────────────┐│
│  │ ❤️ Vitality        Lv.24││
│  │ ████████████░░░░░░ 2,450││
│  │                    XP   ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 🧠 Intellect       Lv.18││
│  │ █████████░░░░░░░░░ 1,823││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 💰 Prosperity      Lv.12││
│  │ ████░░░░░░░░░░░░░░   892││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ⚡ Agility         Lv.31││
│  │ ██████████████░░░░ 3,102││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 👥 Charisma        Lv.14││
│  │ █████░░░░░░░░░░░░░ 1,056││
│  └─────────────────────────┘│
│                             │
│  Build Path: Warrior (+20% VIT)
│                    [Change] │
│                             │
│  Achievements (12)    View ▶│
│  🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆      │
│                             │
├─────────────────────────────┤
│  🏠    👤    ➕    📋    ⚙️  │
└─────────────────────────────┘
```

### 6.5 Log Activity Screen

```
┌─────────────────────────────┐
│  ×       Log Activity       │
│                             │
│  Recent                     │
│  ┌─────┐┌─────┐┌─────┐┌────┐│
│  │🏋️   ││📖   ││💵   ││🏃  ││
│  │Gym  ││Read ││Save ││Walk││
│  │+25  ││+15  ││+20  ││+10 ││
│  └─────┘└─────┘└─────┘└────┘│
│                             │
│  Categories                 │
│  ┌─────────────────────────┐│
│  │ ❤️ Vitality             ▶││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 🧠 Intellect            ▶││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 💰 Prosperity           ▶││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ⚡ Agility              ▶││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 👥 Charisma             ▶││
│  └─────────────────────────┘│
│                             │
│  ┌─────────────────────────┐│
│  │  + Create Custom        ││
│  └─────────────────────────┘│
│                             │
└─────────────────────────────┘
```

### 6.6 Activity Detail / Confirmation

```
┌─────────────────────────────┐
│  ←       Gym Workout        │
│                             │
│          🏋️                 │
│                             │
│      +25 Vitality XP        │
│                             │
│  ─────────────────────────  │
│                             │
│  Add verification for       │
│  bonus XP:                  │
│                             │
│  ┌─────────────────────────┐│
│  │ 📷 Photo Proof   (+25%) ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 📱 Apple Health  (+50%) ││
│  │    ✓ Connected          ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ 👥 Guild Witness (+50%) ││
│  └─────────────────────────┘│
│                             │
│  Notes (optional)           │
│  ┌─────────────────────────┐│
│  │ Leg day, 5x5 squats     ││
│  └─────────────────────────┘│
│                             │
│  ┌─────────────────────────┐│
│  │    ✓ Log Activity       ││
│  └─────────────────────────┘│
│                             │
└─────────────────────────────┘
```

### 6.7 Quest Screen

```
┌─────────────────────────────┐
│  Quests                     │
│                             │
│  ┌───────┬───────┬────────┐ │
│  │ Daily │Weekly │  Epic  │ │
│  │███████│       │        │ │
│  └───────┴───────┴────────┘ │
│                             │
│  Daily Quests    Resets 8h  │
│                             │
│  ┌─────────────────────────┐│
│  │ ☑️ Complete 3 activities ││
│  │    ██████████ 3/3       ││
│  │    +50 XP         CLAIM ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ☐ Earn 50 Vitality XP   ││
│  │    █████░░░░░ 32/50     ││
│  │    +30 XP               ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ☑️ Maintain your streak  ││
│  │    ██████████ ✓         ││
│  │    +25 AGI XP     CLAIM ││
│  └─────────────────────────┘│
│  ┌─────────────────────────┐│
│  │ ☐ Log 2 different types ││
│  │    █████░░░░░ 1/2       ││
│  │    +40 XP               ││
│  └─────────────────────────┘│
│                             │
│  Bonus Quest (Premium)  🔒  │
│  ┌─────────────────────────┐│
│  │ ☐ Perfect Day: All 5    ││
│  │    attributes +100 XP   ││
│  └─────────────────────────┘│
│                             │
├─────────────────────────────┤
│  🏠    👤    ➕    📋    ⚙️  │
└─────────────────────────────┘
```

### 6.8 Guild Screen

```
┌─────────────────────────────┐
│  ←  Iron Warriors    ⚙️     │
│                             │
│  ┌─────────────────────────┐│
│  │  [Guild Banner Image]   ││
│  │                         ││
│  │  Iron Warriors          ││
│  │  Rank #127 • 23 members ││
│  │  Weekly XP: 12,450      ││
│  └─────────────────────────┘│
│                             │
│  This Week's Leaderboard    │
│  ┌─────────────────────────┐│
│  │ 🥇 @mike_lifts    2,340 ││
│  │ 🥈 @sarah_reads   1,890 ││
│  │ 🥉 @you          1,245 ││
│  │  4 @fitness_joe     980 ││
│  │  5 @bookworm        875 ││
│  │           View all ▶    ││
│  └─────────────────────────┘│
│                             │
│  Guild Quest                │
│  ┌─────────────────────────┐│
│  │ Combined 10,000 XP      ││
│  │ ████████████░░░ 78%     ││
│  │ Reward: Guild Badge     ││
│  │ Ends in 3 days          ││
│  └─────────────────────────┘│
│                             │
│  Chat                  ▶    │
│  ┌─────────────────────────┐│
│  │ @mike: Great job today! ││
│  │ @sarah: 💪              ││
│  └─────────────────────────┘│
│                             │
├─────────────────────────────┤
│  🏠    👤    ➕    📋    ⚙️  │
└─────────────────────────────┘
```

### 6.9 Level Up Animation

```
┌─────────────────────────────┐
│                             │
│                             │
│     ✨ ✨ ✨ ✨ ✨ ✨ ✨       │
│                             │
│        LEVEL UP!            │
│                             │
│     ┌───────────────┐       │
│     │               │       │
│     │   VITALITY    │       │
│     │               │       │
│     │    23 → 24    │       │
│     │               │       │
│     └───────────────┘       │
│                             │
│     +1 Power Level          │
│                             │
│     ✨ ✨ ✨ ✨ ✨ ✨ ✨       │
│                             │
│     ┌─────────────────┐     │
│     │    Awesome!     │     │
│     └─────────────────┘     │
│                             │
└─────────────────────────────┘

Animation sequence:
1. Screen dims
2. Particles converge to center
3. Attribute icon pulses
4. Number counts up with sound
5. Burst of particles outward
6. Power level increment shows
7. Button fades in
```

### 6.10 Rank Up Animation

```
┌─────────────────────────────┐
│                             │
│    [Full-screen takeover]   │
│                             │
│         ══════════          │
│        RANK ACHIEVED        │
│         ══════════          │
│                             │
│      ┌─────────────┐        │
│      │             │        │
│      │    ◆ ◆ ◆    │        │  (Rank icon animates in)
│      │     ◆ ◆     │        │
│      │      ◆      │        │
│      │             │        │
│      │    STEEL    │        │
│      │   RANK 3    │        │
│      │             │        │
│      └─────────────┘        │
│                             │
│    You've unlocked:         │
│    • Guild Creation         │
│    • Steel Aura             │
│    • 3 New Achievements     │
│                             │
│     ┌─────────────────┐     │
│     │    Continue     │     │
│     └─────────────────┘     │
│                             │
└─────────────────────────────┘

Animation:
1. Epic sound effect
2. Screen flashes rank color
3. Old rank dissolves
4. New rank materializes with particles
5. Aura effect spreads from center
6. Unlocks list fades in
```

---

## 7. Animation Guidelines

### 7.1 Timing

| Animation Type | Duration | Easing |
|---------------|----------|--------|
| Button press | 100ms | ease-out |
| Card tap | 150ms | ease-out |
| Screen transition | 300ms | ease-in-out |
| Modal appear | 250ms | ease-out |
| Modal dismiss | 200ms | ease-in |
| XP bar fill | 600ms | ease-out |
| Level up | 1500ms | custom spring |
| Rank up | 3000ms | staged |
| Particles | 400-800ms | linear |
| Glow pulse | 1500ms | ease-in-out, loop |

### 7.2 Micro-interactions

- **XP Gain**: Number pops up, floats up, fades (+15 VIT)
- **Streak Fire**: Flame icon pulses when streak increases
- **Quest Complete**: Checkmark draws itself, slight bounce
- **Button Hover/Press**: Subtle scale (0.98) and shadow reduction
- **Pull to Refresh**: Custom animation with ZERO logo
- **Tab Switch**: Crossfade with slight slide

### 7.3 Haptic Feedback

| Action | Haptic Type |
|--------|-------------|
| Button tap | Light impact |
| Activity logged | Medium impact |
| Level up | Heavy impact + success notification |
| Rank up | Heavy impact × 3 |
| Error | Error notification |
| Quest complete | Success notification |

---

## 8. Accessibility

### 8.1 Requirements

- **Color contrast**: Minimum 4.5:1 for text, 3:1 for UI elements
- **Touch targets**: Minimum 44×44 points
- **Text scaling**: Support up to 200% text size
- **Screen readers**: All elements labeled, logical reading order
- **Reduced motion**: Option to disable animations
- **Color blindness**: Don't rely on color alone; use icons + text

### 8.2 Alternative Themes

- **High Contrast Mode**: Increased contrast, bolder borders
- **Light Mode**: Full light theme for outdoor use

---

## 9. Error States

### 9.1 Empty States

```
┌─────────────────────────────┐
│                             │
│           📋                │
│                             │
│    No Activities Yet        │
│                             │
│    Start logging to see     │
│    your progress here       │
│                             │
│    ┌─────────────────────┐  │
│    │  Log First Activity │  │
│    └─────────────────────┘  │
│                             │
└─────────────────────────────┘
```

### 9.2 Error States

```
┌─────────────────────────────┐
│                             │
│           ⚠️                │
│                             │
│    Something Went Wrong     │
│                             │
│    We couldn't load your    │
│    data. Check your         │
│    connection and try again.│
│                             │
│    ┌─────────────────────┐  │
│    │      Try Again      │  │
│    └─────────────────────┘  │
│                             │
└─────────────────────────────┘
```

### 9.3 Offline State

```
┌─────────────────────────────┐
│  ⚡ Offline Mode            │  (Banner at top)
├─────────────────────────────┤
│                             │
│    [Normal UI continues]    │
│    [Activities queue for    │
│     sync when online]       │
│                             │
└─────────────────────────────┘
```

---

## 10. Platform Considerations

### 10.1 iOS Specific

- Use SF Symbols where appropriate
- Respect safe areas (notch, home indicator)
- Support Dynamic Type
- Haptic feedback via UIImpactFeedbackGenerator
- Sign in with Apple required

### 10.2 Android Specific

- Material Design 3 influences where appropriate
- Edge-to-edge display support
- Predictive back gesture support
- Adaptive icons for app icon

### 10.3 Tablet Support

- Max content width: 600px, centered
- Two-column layout for larger screens (character + activities)
- Larger touch targets not needed (pointer devices)

---

*Document Version: 1.0*
*Last Updated: January 2025*
