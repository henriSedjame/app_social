
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToasterUtils {

  static void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => SimpleDialog(
        backgroundColor: Colors.red,
        title: Center(child: Text('ERREUR')),
        contentPadding: EdgeInsets.all(15.0),
        children: <Widget>[
          Center(
            child: Text(message, textAlign: TextAlign.center ,style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontStyle: FontStyle.italic
            ),),
          ),
        ],
        
      )
    );
  }
}