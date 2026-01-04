part of 'auth_bloc.dart';

/// Base class for auth events
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check current auth state
final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// User auth state changed
final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

/// Sign up with email
final class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested({
    required this.email,
    required this.password,
    this.displayName,
  });

  final String email;
  final String password;
  final String? displayName;

  @override
  List<Object?> get props => [email, password, displayName];
}

/// Sign in with email
final class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Sign in with Google
final class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

/// Sign out
final class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

/// Password reset
final class AuthPasswordResetRequested extends AuthEvent {
  const AuthPasswordResetRequested(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}
