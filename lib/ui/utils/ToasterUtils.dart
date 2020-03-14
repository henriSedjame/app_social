
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToasterUtils {

  static Future<void> showLogOutDialog(BuildContext context, VoidCallback onOk) async {

    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx){
        return AlertDialog(
          title: Text('Souhaitez-vous vous déconnecter ?'),
          actions: <Widget>[
            FlatButton(onPressed: () => Navigator.pop(ctx),child: Text('NON'),),
            FlatButton(onPressed: onOk, child: Text('OUI'), color: blueLight,)
          ],
        );
      }
    );

  }
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