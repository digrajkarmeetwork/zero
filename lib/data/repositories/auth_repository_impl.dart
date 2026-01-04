import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

/// Firebase implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn? _googleSignIn;

  /// Cache for current user
  User _cachedUser = User.empty;

  @override
  Stream<User> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        _cachedUser = User.empty;
        return User.empty;
      }
      final user = await _getUserFromFirebase(firebaseUser);
      _cachedUser = user;
      return user;
    });
  }

  @override
  User get currentUser => _cachedUser;

  @override
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign up failed: No user returned');
      }

      // Update display name if provided
      if (displayName != null) {
        await credential.user!.updateDisplayName(displayName);
      }

      // Create user document in Firestore
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(credential.user!.uid)
          .set(userModel.toFirestore());

      _cachedUser = userModel.toEntity();
      return _cachedUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed: No user returned');
      }

      final user = await _getUserFromFirebase(credential.user!);
      _cachedUser = user;

      // Update last active
      await _updateLastActive(user.id);

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    if (_googleSignIn == null) {
      throw Exception('Google Sign-In is not available on this platform');
    }

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await _firebaseAuth.signInWithCredential(credential);
      if (authResult.user == null) {
        throw Exception('Google sign in failed: No user returned');
      }

      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(authResult.user!.uid)
          .get();

      if (!userDoc.exists) {
        // Create new user document
        final userModel = UserModel(
          id: authResult.user!.uid,
          email: authResult.user!.email ?? '',
          displayName: authResult.user!.displayName,
          avatarUrl: authResult.user!.photoURL,
          createdAt: DateTime.now(),
        );

        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(authResult.user!.uid)
            .set(userModel.toFirestore());

        _cachedUser = userModel.toEntity();
      } else {
        _cachedUser = UserModel.fromFirestore(userDoc).toEntity();
        await _updateLastActive(_cachedUser.id);
      }

      return _cachedUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    final futures = <Future>[_firebaseAuth.signOut()];
    if (_googleSignIn != null) {
      futures.add(_googleSignIn.signOut());
    }
    await Future.wait(futures);
    _cachedUser = User.empty;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<User> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('No authenticated user');
    }

    if (displayName != null) {
      await firebaseUser.updateDisplayName(displayName);
    }

    if (avatarUrl != null) {
      await firebaseUser.updatePhotoURL(avatarUrl);
    }

    // Update Firestore
    final updates = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (displayName != null) updates['displayName'] = displayName;
    if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .update(updates);

    _cachedUser = _cachedUser.copyWith(
      displayName: displayName ?? _cachedUser.displayName,
      avatarUrl: avatarUrl ?? _cachedUser.avatarUrl,
    );

    return _cachedUser;
  }

  @override
  Future<void> deleteAccount() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('No authenticated user');
    }

    // Delete Firestore data
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .delete();

    // Delete Firebase Auth account
    await firebaseUser.delete();

    _cachedUser = User.empty;
  }

  /// Get user from Firebase, creating Firestore doc if needed
  Future<User> _getUserFromFirebase(firebase_auth.User firebaseUser) async {
    final userDoc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .get();

    if (userDoc.exists) {
      return UserModel.fromFirestore(userDoc).toEntity();
    }

    // Create user document if it doesn't exist
    final userModel = UserModel.fromFirebaseUser(firebaseUser);
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .set(userModel.toFirestore());

    return userModel.toEntity();
  }

  /// Update user's last active timestamp
  Future<void> _updateLastActive(String userId) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update({'lastActiveAt': FieldValue.serverTimestamp()});
  }

  /// Map Firebase Auth exceptions to user-friendly messages
  Exception _mapFirebaseAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return Exception('An account already exists with this email');
      case 'invalid-email':
        return Exception('Invalid email address');
      case 'operation-not-allowed':
        return Exception('Operation not allowed');
      case 'weak-password':
        return Exception('Password is too weak');
      case 'user-disabled':
        return Exception('This account has been disabled');
      case 'user-not-found':
        return Exception('No account found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'invalid-credential':
        return Exception('Invalid email or password');
      default:
        return Exception(e.message ?? 'Authentication failed');
    }
  }
}
