import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class User{
  BuildContext _context;
  FirebaseUser _user;

  User(BuildContext context){
    _context = context;
  }

  Future EditPopup({FirebaseUser user}) async {
    if(user != null){
      _user = user;
    }else{
      _user = await  FirebaseAuth.instance.currentUser() ;
    }
    if(_user == null)
      return;
    showDialog(context: _context,barrierDismissible: true,
        child: CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: Text("Email"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 5),
                    width: 100,
                    child: TextField(
                      enabled: false,
                      controller: new TextEditingController(text: _user.email),
                    ),
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.save,color: Colors.green,),
              onPressed: (){
                Navigator.of(_context).pop();
              },
            ),
            FlatButton(
              child: Icon(Icons.close,color: Colors.red),
              onPressed: (){
                Navigator.of(_context).pop();
              },
            )
          ],
        )
    );
  }
}