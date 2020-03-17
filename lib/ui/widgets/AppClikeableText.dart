
import 'package:flutter/material.dart';

class AppClikeableText extends StatelessWidget {

  String text;
  VoidCallback onTap;
  TextStyle style;

  AppClikeableText({@required this.text, @required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(this.text, style: this.style,),
      onTap: this.onTap,
    );
  }
}
