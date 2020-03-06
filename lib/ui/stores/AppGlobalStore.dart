import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'AppGlobalStore.g.dart';

@injectable
class AppGlobalStore extends _AppGlobalStore with _$AppGlobalStore{}

abstract class _AppGlobalStore with Store {

  @observable
  int currentLogMenuIdx;

  @action
  void changeLogMenu(int idx){
    if (currentLogMenuIdx != idx) {
      currentLogMenuIdx = idx;
    }
  }

}