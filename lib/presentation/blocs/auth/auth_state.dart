part of 'auth_bloc.dart';

/// Auth status enum
enum AuthStatus {
  unknown,
  loading,
  authenticated,
  unauthenticated,
  error,
  passwordResetSent,
}

/// Auth state
final class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user = User.empty,
    this.isNewUser = false,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(User user, {bool isNewUser = false})
      : this._(
          status: AuthStatus.authenticated,
          user: user,
          isNewUser: isNewUser,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.error(String message)
      : this._(
          status: AuthStatus.error,
          errorMessage: message,
        );

  const AuthState.passwordResetSent()
      : this._(status: AuthStatus.passwordResetSent);

  final AuthStatus status;
  final User user;
  final bool isNewUser;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, user, isNewUser, errorMessage];
}
