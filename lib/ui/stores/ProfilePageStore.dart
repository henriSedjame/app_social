
import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/services/UserService.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'ProfilePageStore.g.dart';

@Singleton(signalsReady: true)
class ProfilePageStore extends _ProfilePageStore with _$ProfilePageStore {
  ProfilePageStore(UserService userService) : super(userService);
}

abstract class _ProfilePageStore with Store {

  final UserService _userService;

  _ProfilePageStore(this._userService);

  /* Observables */
  @observable
  ObservableFuture<User> _futureUser;

  @observable
  User _user;

  /* Computed */
  @computed
  User get user => _user;

  /* Actions */
  @action
  Future<void> loadUser(String userId) async {
    _futureUser ??= ObservableFuture(this._userService.findById(userId));
    _user ??= await _futureUser;
  }

}