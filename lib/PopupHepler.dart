import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PopupHelper {
  static String _msg;
  PopupHelper(String message){
    _msg = message;
  }

  static void showPopup(BuildContext context,String message) {
    // TODO: implement build
    showDialog(context: context,barrierDismissible: true,
        child: CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.close),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }
}