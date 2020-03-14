// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfilePageStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilePageStore on _ProfilePageStore, Store {
  Computed<User> _$userComputed;

  @override
  User get user => (_$userComputed ??= Computed<User>(() => super.user)).value;

  final _$_futureUserAtom = Atom(name: '_ProfilePageStore._futureUser');

  @override
  ObservableFuture<User> get _futureUser {
    _$_futureUserAtom.context.enforceReadPolicy(_$_futureUserAtom);
    _$_futureUserAtom.reportObserved();
    return super._futureUser;
  }

  @override
  set _futureUser(ObservableFuture<User> value) {
    _$_futureUserAtom.context.conditionallyRunInAction(() {
      super._futureUser = value;
      _$_futureUserAtom.reportChanged();
    }, _$_futureUserAtom, name: '${_$_futureUserAtom.name}_set');
  }

  final _$_userAtom = Atom(name: '_ProfilePageStore._user');

  @override
  User get _user {
    _$_userAtom.context.enforceReadPolicy(_$_userAtom);
    _$_userAtom.reportObserved();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.context.conditionallyRunInAction(() {
      super._user = value;
      _$_userAtom.reportChanged();
    }, _$_userAtom, name: '${_$_userAtom.name}_set');
  }

  final _$loadUserAsyncAction = AsyncAction('loadUser');

  @override
  Future<void> loadUser(String userId) {
    return _$loadUserAsyncAction.run(() => super.loadUser(userId));
  }

  @override
  String toString() {
    final string = 'user: ${user.toString()}';
    return '{$string}';
  }
}
