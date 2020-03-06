import 'package:flutter/material.dart';
import 'AppPadding.dart';

class AppRaisedButton extends RaisedButton {
  AppRaisedButton(
      {@required VoidCallback onPressed, double elevation, Color color, @required String text})
      : super(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: elevation,
          color: color,
          child: AppPadding(
            top: 7.0,
            bottom: 7.0,
            left: 7.0,
            right: 7.0,
            child: Text(text,
              style: TextStyle(
                  color: Colors.white, fontSize: 16.0
              ),
            ),
          )
        );
}
