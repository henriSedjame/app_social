import 'dart:io';

import 'package:app_social/data/Tables.dart';
import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/repositories/UserRepository.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/User.dart';
import '../UserService.dart';

@RegisterAs(UserService)
@Singleton(signalsReady: true)
class UserServiceImpl extends UserService {

  UserRepository _userRepository;
  AuthenticationService _authenticationService;

  UserServiceImpl(this._userRepository, this._authenticationService);

  @override
  Future<User> findById(String userId) => this
      ._userRepository
      .findById(userId)
      .then((value) => User.fromJson(value));

  @override
  Future<User> save(User user, String password) {
    return this
        ._authenticationService
        .create(email: user.email, password: password)
        .then((authResult) => this._userRepository.save(user
          ..id = authResult.user.uid
          ..description = ''
          ..imageUrl ??= ''
          ..followings = []
          ..followers = []))
        .then((userId) => user..id = userId);
  }

}
