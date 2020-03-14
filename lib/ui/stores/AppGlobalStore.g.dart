// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppGlobalStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppGlobalStore on _AppGlobalStore, Store {
  Computed<int> _$currentLogMenuIdxComputed;

  @override
  int get currentLogMenuIdx => (_$currentLogMenuIdxComputed ??=
          Computed<int>(() => super.currentLogMenuIdx))
      .value;
  Computed<String> _$selectedMenuItemComputed;

  @override
  String get selectedMenuItem => (_$selectedMenuItemComputed ??=
          Computed<String>(() => super.selectedMenuItem))
      .value;
  Computed<User> _$currentUserComputed;

  @override
  User get currentUser =>
      (_$currentUserComputed ??= Computed<User>(() => super.currentUser)).value;
  Computed<ConnexionState> _$connexionStateComputed;

  @override
  ConnexionState get connexionState => (_$connexionStateComputed ??=
          Computed<ConnexionState>(() => super.connexionState))
      .value;

  final _$_currentLogMenuIdxAtom =
      Atom(name: '_AppGlobalStore._currentLogMenuIdx');

  @override
  int get _currentLogMenuIdx {
    _$_currentLogMenuIdxAtom.context
        .enforceReadPolicy(_$_currentLogMenuIdxAtom);
    _$_currentLogMenuIdxAtom.reportObserved();
    return super._currentLogMenuIdx;
  }

  @override
  set _currentLogMenuIdx(int value) {
    _$_currentLogMenuIdxAtom.context.conditionallyRunInAction(() {
      super._currentLogMenuIdx = value;
      _$_currentLogMenuIdxAtom.reportChanged();
    }, _$_currentLogMenuIdxAtom, name: '${_$_currentLogMenuIdxAtom.name}_set');
  }

  final _$_selectedMenuItemAtom =
      Atom(name: '_AppGlobalStore._selectedMenuItem');

  @override
  String get _selectedMenuItem {
    _$_selectedMenuItemAtom.context.enforceReadPolicy(_$_selectedMenuItemAtom);
    _$_selectedMenuItemAtom.reportObserved();
    return super._selectedMenuItem;
  }

  @override
  set _selectedMenuItem(String value) {
    _$_selectedMenuItemAtom.context.conditionallyRunInAction(() {
      super._selectedMenuItem = value;
      _$_selectedMenuItemAtom.reportChanged();
    }, _$_selectedMenuItemAtom, name: '${_$_selectedMenuItemAtom.name}_set');
  }

  final _$_futureUserAtom = Atom(name: '_AppGlobalStore._futureUser');

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

  final _$_currentUserAtom = Atom(name: '_AppGlobalStore._currentUser');

  @override
  User get _currentUser {
    _$_currentUserAtom.context.enforceReadPolicy(_$_currentUserAtom);
    _$_currentUserAtom.reportObserved();
    return super._currentUser;
  }

  @override
  set _currentUser(User value) {
    _$_currentUserAtom.context.conditionallyRunInAction(() {
      super._currentUser = value;
      _$_currentUserAtom.reportChanged();
    }, _$_currentUserAtom, name: '${_$_currentUserAtom.name}_set');
  }

  final _$loadUserAsyncAction = AsyncAction('loadUser');

  @override
  Future<void> loadUser(String userId) {
    return _$loadUserAsyncAction.run(() => super.loadUser(userId));
  }

  final _$_AppGlobalStoreActionController =
      ActionController(name: '_AppGlobalStore');

  @override
  void changeLogMenu(int idx) {
    final _$actionInfo = _$_AppGlobalStoreActionController.startAction();
    try {
      return super.changeLogMenu(idx);
    } finally {
      _$_AppGlobalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAppMenu(String menu) {
    final _$actionInfo = _$_AppGlobalStoreActionController.startAction();
    try {
      return super.changeAppMenu(menu);
    } finally {
      _$_AppGlobalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'currentLogMenuIdx: ${currentLogMenuIdx.toString()},selectedMenuItem: ${selectedMenuItem.toString()},currentUser: ${currentUser.toString()},connexionState: ${connexionState.toString()}';
    return '{$string}';
  }
}
