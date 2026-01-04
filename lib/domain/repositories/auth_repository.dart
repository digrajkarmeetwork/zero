import '../entities/user.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Stream of authentication state changes
  Stream<User> get authStateChanges;

  /// Get current user
  User get currentUser;

  /// Sign up with email and password
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in with email and password
  Future<User> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign in with Google
  Future<User> signInWithGoogle();

  /// Sign out
  Future<void> signOut();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Update user profile
  Future<User> updateProfile({
    String? displayName,
    String? avatarUrl,
  });

  /// Delete account
  Future<void> deleteAccount();
}
