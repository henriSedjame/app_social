
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBottomBarItem extends IconButton {

  AppBottomBarItem({@required String name,
    @required AppGlobalStore store,
    @required Icon icon,
    @required VoidCallback onPressed}) : super(
      onPressed: () {
        store.changeAppMenu(name);
        onPressed();
      },
      icon: icon,
      color: store.selectedMenuItem == name ? darkGrey : ternaryColor
  );

}