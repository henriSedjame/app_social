// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_social/config/RegisterModule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app_social/data/repositories/PostRepository.dart';
import 'package:app_social/data/repositories/FileStorage.dart';
import 'package:app_social/data/repositories/UserRepository.dart';
import 'package:app_social/domain/services/impl/PostServiceImpl.dart';
import 'package:app_social/domain/services/PostService.dart';
import 'package:app_social/domain/services/impl/AuthenticationServiceImpl.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/domain/services/impl/UserServiceImpl.dart';
import 'package:app_social/domain/services/UserService.dart';
import 'package:app_social/ui/stores/ProfilePageStore.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerFactory<FirebaseAuth>(() => registerModule.firebaseAuth);
  g.registerFactory<Firestore>(() => registerModule.firestore);
  g.registerFactory<StorageReference>(() => registerModule.storage);

  //Eager singletons must be registered in the right order
  g.registerSingleton<PostRepository>(PostRepository(g<Firestore>()),
      signalsReady: true);
  g.registerSingleton<FileStorage>(FileStorage(g<StorageReference>()),
      signalsReady: true);
  g.registerSingleton<UserRepository>(UserRepository(g<Firestore>()),
      signalsReady: true);
  g.registerSingleton<PostService>(
      PostServiceImpl(g<PostRepository>(), g<FileStorage>()),
      signalsReady: true);
  g.registerSingleton<AuthenticationService>(
      AuthenticationServiceImpl(g<FirebaseAuth>()),
      signalsReady: true);
  g.registerSingleton<UserService>(
      UserServiceImpl(g<UserRepository>(), g<AuthenticationService>()),
      signalsReady: true);
  g.registerSingleton<ProfilePageStore>(ProfilePageStore(g<UserService>()),
      signalsReady: true);
  g.registerSingleton<AppGlobalStore>(AppGlobalStore(g<UserService>()),
      signalsReady: true);
}

class _$RegisterModule extends RegisterModule {}
