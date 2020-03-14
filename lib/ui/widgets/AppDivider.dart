import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final double paddingTop;
  final double paddingBottom;


  AppDivider({this.width, this.height, this.color, this.paddingTop, this.paddingBottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop ?? 5.0,
          bottom: paddingBottom ?? 5.0
      ),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 1.0,
        color: color ?? Colors.white,
      ),
    );
  }
}
