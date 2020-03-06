// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_social/config/RegisterModule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/data/repositories/UserRepository.dart';
import 'package:app_social/domain/services/impl/AuthenticationServiceImpl.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/domain/services/impl/UserServiceImpl.dart';
import 'package:app_social/domain/services/UserService.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerFactory<FirebaseAuth>(() => registerModule.firebaseAuth);
  g.registerFactory<Firestore>(() => registerModule.firestore);
  g.registerFactory<AppGlobalStore>(() => AppGlobalStore());
  g.registerFactory<UserRepository>(() => UserRepository(
        g<Firestore>(),
      ));
  g.registerFactory<AuthenticationService>(() => AuthenticationServiceImpl(
        g<FirebaseAuth>(),
      ));
  g.registerFactory<UserService>(() => UserServiceImpl(
        g<UserRepository>(),
        g<AuthenticationService>(),
      ));
}

class _$RegisterModule extends RegisterModule {}
