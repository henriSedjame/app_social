import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/services/UserService.dart';
import 'package:app_social/ui/widgets/AppMenuItems.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'AppGlobalStore.g.dart';

@Singleton(signalsReady: true)
class AppGlobalStore extends _AppGlobalStore with _$AppGlobalStore {

  final UserService _userService;
  AppGlobalStore(this._userService) : super(_userService);
}

abstract class _AppGlobalStore with Store {

  /* Constructor */
  UserService _userService;

  _AppGlobalStore(this._userService);

  /* Observables */
  @observable
  int _currentLogMenuIdx = 0;

  @observable
  String _selectedMenuItem = HOME;

  @observable
  ObservableFuture<User> _futureUser;

  @observable
  User _currentUser;

  /* Computed */
  @computed
  int get currentLogMenuIdx => _currentLogMenuIdx;

  @computed
  String get selectedMenuItem => _selectedMenuItem;

  @computed
  User get currentUser => _currentUser;

  @computed
  ConnexionState get connexionState {
    FutureStatus status = _futureUser?.status ?? FutureStatus.rejected;

    switch(status){
      case FutureStatus.fulfilled:
        return ConnexionState.CONNECTED;
      case FutureStatus.pending:
        return ConnexionState.CONNECTING;
      default :
        return ConnexionState.DISCONNECTED;
    }
  }

  /* Actions */
  @action
  void changeLogMenu(int idx){
    if (_currentLogMenuIdx != idx) {
      _currentLogMenuIdx = idx;
    }
  }

  @action
  void changeAppMenu(String menu){
    _selectedMenuItem = menu;
  }

  @action
  Future<void> loadUser(String userId) async {
    _futureUser ??= ObservableFuture(this._userService.findById(userId));
    _currentUser ??= await _futureUser;
  }

}

enum ConnexionState {DISCONNECTED, CONNECTING, CONNECTED}