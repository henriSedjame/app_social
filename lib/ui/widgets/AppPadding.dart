import 'package:flutter/material.dart';

class AppPadding extends Padding {
  AppPadding(
      {double top: 25.0,
      double bottom: 0.0,
      double left: 0.0,
      double right: 0.0, @required Widget child})
      : super(
            child: child,
            padding: EdgeInsets.only(
                top: top, bottom: bottom, left: left, right: right));
}
