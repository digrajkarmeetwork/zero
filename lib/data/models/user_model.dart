import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';

/// User model for Firebase
class UserModel {
  const UserModel({
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

  /// Create from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return UserModel(id: doc.id, email: '');
    }
    return UserModel(
      id: doc.id,
      email: data['email'] as String? ?? '',
      displayName: data['displayName'] as String?,
      avatarUrl: data['avatarUrl'] as String?,
      isPremium: data['isPremium'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastActiveAt: (data['lastActiveAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Create from Firebase Auth User
  factory UserModel.fromFirebaseUser(
    dynamic firebaseUser, {
    bool isPremium = false,
  }) {
    return UserModel(
      id: firebaseUser.uid as String,
      email: firebaseUser.email as String? ?? '',
      displayName: firebaseUser.displayName as String?,
      avatarUrl: firebaseUser.photoURL as String?,
      isPremium: isPremium,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'isPremium': isPremium,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'lastActiveAt': FieldValue.serverTimestamp(),
    };
  }

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      createdAt: createdAt,
      lastActiveAt: lastActiveAt,
    );
  }

  /// Create from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
      avatarUrl: user.avatarUrl,
      isPremium: user.isPremium,
      createdAt: user.createdAt,
      lastActiveAt: user.lastActiveAt,
    );
  }
}
