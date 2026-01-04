import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/repositories/activity_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/character_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/character/character_bloc.dart';

/// Global service locator
final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> configureDependencies() async {
  // Firebase instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Google Sign-In (skip on web for now - requires OAuth client setup)
  if (!kIsWeb) {
    getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  }

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      googleSignIn: kIsWeb ? null : getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<CharacterBloc>(
    () => CharacterBloc(
      characterRepository: getIt<CharacterRepository>(),
    ),
  );
}
