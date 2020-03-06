// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppGlobalStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppGlobalStore on _AppGlobalStore, Store {
  final _$currentLogMenuIdxAtom =
      Atom(name: '_AppGlobalStore.currentLogMenuIdx');

  @override
  int get currentLogMenuIdx {
    _$currentLogMenuIdxAtom.context.enforceReadPolicy(_$currentLogMenuIdxAtom);
    _$currentLogMenuIdxAtom.reportObserved();
    return super.currentLogMenuIdx;
  }

  @override
  set currentLogMenuIdx(int value) {
    _$currentLogMenuIdxAtom.context.conditionallyRunInAction(() {
      super.currentLogMenuIdx = value;
      _$currentLogMenuIdxAtom.reportChanged();
    }, _$currentLogMenuIdxAtom, name: '${_$currentLogMenuIdxAtom.name}_set');
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
  String toString() {
    final string = 'currentLogMenuIdx: ${currentLogMenuIdx.toString()}';
    return '{$string}';
  }
}
