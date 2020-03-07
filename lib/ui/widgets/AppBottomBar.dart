
import 'package:flutter/material.dart';

class AppBottomBar extends BottomAppBar {
  AppBottomBar({@required List<Widget> items}) : super(
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: items
    )
  );
}