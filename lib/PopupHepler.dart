import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PopupHelper {
  BuildContext _context;
  PopupHelper(BuildContext context){
    _context = context;
  }

  void ShowPopup({BuildContext context,String message}) {
    if(context != null){
      _context = context;
    }
    // TODO: implement build
    showDialog(context: _context,barrierDismissible: true,
        child: CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.close),
              onPressed: (){
                Navigator.of(_context).pop();
              },
            ),
          ],
        )
    );
  }
}