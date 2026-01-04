import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/blocs/auth/auth_bloc.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/onboarding/onboarding_screen.dart';
import '../presentation/screens/onboarding/character_creation_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/character/character_screen.dart';
import '../presentation/screens/activities/activities_screen.dart';
import '../presentation/screens/activities/log_activity_screen.dart';
import '../presentation/screens/quests/quests_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/widgets/navigation/main_navigation_shell.dart';

/// Route names
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String characterCreation = '/character-creation';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String character = '/character';
  static const String activities = '/activities';
  static const String logActivity = '/log-activity';
  static const String quests = '/quests';
  static const String profile = '/profile';
}

/// App router configuration
class AppRouter {
  AppRouter({required this.authBloc});

  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: _redirect,
    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Onboarding routes
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.characterCreation,
        builder: (context, state) => const CharacterCreationScreen(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigationShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.character,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CharacterScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.activities,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ActivitiesScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.quests,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: QuestsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // Log activity (modal)
      GoRoute(
        path: AppRoutes.logActivity,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LogActivityScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = authBloc.state;
    final isOnSplash = state.matchedLocation == AppRoutes.splash;
    final isOnAuth = state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register;
    final isOnOnboarding = state.matchedLocation == AppRoutes.onboarding ||
        state.matchedLocation == AppRoutes.characterCreation;

    // Still loading
    if (authState.status == AuthStatus.unknown ||
        authState.status == AuthStatus.loading) {
      return isOnSplash ? null : AppRoutes.splash;
    }

    // Not authenticated
    if (authState.status == AuthStatus.unauthenticated) {
      return isOnAuth ? null : AppRoutes.login;
    }

    // Authenticated
    if (authState.status == AuthStatus.authenticated) {
      // New user needs onboarding
      if (authState.isNewUser && !isOnOnboarding) {
        return AppRoutes.characterCreation;
      }

      // Already authenticated, go to home
      if (isOnAuth || isOnSplash) {
        return AppRoutes.home;
      }
    }

    return null;
  }
}

/// Stream wrapper for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
