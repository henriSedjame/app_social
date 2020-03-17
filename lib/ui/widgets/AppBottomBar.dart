
import 'package:flutter/material.dart';

class AppBottomBar extends BottomAppBar {
  AppBottomBar({@required List<Widget> items}) : super(
    color: Colors.white,
    elevation: 7.0,
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: items
    )
  );
}
