import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/widgets/AppTypeDefs.dart';
import 'package:flutter/material.dart';

class UIUtils {
  static void hideKeyBoard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static void showAppBottomSheet(
      {BuildContext context,
      AppGlobalStore store,
      Widget widget,
      GlobalKey<ScaffoldState> key}) {
    if (store.editing) return null;

    store.edit();

    (key?.currentState?.showBottomSheet((ctx) => widget,
                backgroundColor: Colors.transparent) ??
            showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (ctx) => widget,
            ))
        .closed
        .whenComplete(() => store.edit());
  }

  static Future<T> showAppBottomSheetWithResult<T>(
      {BuildContext context,
      AppGlobalStore store,
      Widget widget,
      AppFunction<AppGlobalStore, T> func,
      GlobalKey<ScaffoldState> key}) {

    if (store.editing) return Future.value(null);

    store.edit();

    return (key?.currentState?.showBottomSheet<T>(
                (ctx) => widget,
                backgroundColor: Colors.transparent) ??
            showBottomSheet<T>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (ctx) => widget,
            ))
        .closed
        .then((_) {
          store.edit();
          return func(store);
        });

  }
}
