import 'package:equatable/equatable.dart';

/// User entity representing an authenticated user
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.isPremium = false,
    this.createdAt,
    this.lastActiveAt,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;
  final bool isPremium;
  final DateTime? createdAt;
  final DateTime? lastActiveAt;

  /// Empty user for unauthenticated state
  static const empty = User(id: '', email: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        avatarUrl,
        isPremium,
        createdAt,
        lastActiveAt,
      ];
}
