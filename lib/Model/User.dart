import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../PopupHepler.dart';


class User{
  BuildContext _context;
  FirebaseUser _user;
  TextEditingController _txtOldPassword;
  TextEditingController _txtPassword;
  GlobalKey<FormState> _formState;
  PopupHelper _popup;

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
    _formState = new GlobalKey<FormState>();
    _txtPassword = new TextEditingController();
    _txtOldPassword = new TextEditingController();
    showDialog(context: _context,barrierDismissible: false,
        builder: (BuildContext context){
          _popup = new PopupHelper(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: AlertDialog(
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.blue)),
                  title: Center(child:Text("Thông tin cá nhân")),
                  titleTextStyle: TextStyle(fontFamily: "Lobster",color: Colors.blue,fontSize: 24,),
                  contentPadding: EdgeInsets.all(5),
                  content:Form(
                    key: _formState,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              child: Text("Email"),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5),
                                  child:TextField(
                                    enabled: false,
                                    controller: new TextEditingController(text: _user.email),
                                    style: TextStyle(backgroundColor: Colors.transparent,),
                                    decoration: InputDecoration.collapsed(border: InputBorder.none),
                                  )
                              ),
                            ),
                          ],
                        ),// Email
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              child: Text("Mật khẩu củ"),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5),
                                  child:TextFormField(
                                    controller: _txtOldPassword,
                                    obscureText: true,
                                    validator: (value){
                                      if(value.length == 0)
                                        return "Mật khẩu không được trống";
                                    },
                                  )
                              ),
                            )
                          ],
                        ),// old Password
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              child: Text("Mật khẩu"),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5),
                                  child:TextFormField(
                                    controller: _txtPassword,
                                    obscureText: true,
                                    validator: (value){
                                      if(value.length == 0)
                                        return "Mật khẩu không được trống";
                                    },
                                  )
                              ),
                            )
                          ],
                        ),// Password
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              child: Text("Nhập lại"),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5),
                                  child:TextFormField(
                                    obscureText: true,
                                    validator: (value){
                                      if(value.length == 0)
                                        return "Mật khẩu không khớp";
                                    },
                                  )
                              ),
                            )
                          ],
                        ),// Password Repeat
                      ],
                    ),// Form
                  ) ,
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          child: Icon(Icons.exit_to_app,color: Colors.yellow,),
                          color: Colors.white,
                          highlightColor: Colors.yellowAccent,
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.yellow)),
                          elevation: 1,
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(_context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
                          },
                        ),// Logout button
                        Container(width: MediaQuery.of(context).size.width*0.2,),
                        RaisedButton(
                          child: Icon(Icons.save,color: Colors.green,),
                          color: Colors.white,
                          highlightColor: Colors.lightGreenAccent,
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)),
                          elevation: 1,
                          onPressed: (){
                            if(_formState.currentState.validate()){
                              ChangePassword(_txtPassword.text);
                            }
                          },
                        ),// Save button
                        RaisedButton(
                          child: Icon(Icons.close,color: Colors.red),
                          color: Colors.white,
                          highlightColor: Colors.deepOrangeAccent,
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.red)),
                          elevation: 0,
                          onPressed: (){
                            Navigator.of(_context).pop();
                          },
                        ),// Close button
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
    );
  }

  Future ChangePassword(String password) async {
    bool isValid = true;
    AuthCredential credential = EmailAuthProvider.getCredential(email: _user.email, password: _txtOldPassword.text);
    await _user.reauthenticateWithCredential(credential).catchError((error){
        _popup.ShowPopupError(message: "Mật khẩu cũ không chính xác");
        isValid = false;
    });
    if(isValid == true){
      await _user.updatePassword(password).catchError((error){
        _popup.ShowPopupError(message: "Mật khẩu phải lớn hơn 6 ký tự");
        isValid = false;
      });
      if(isValid == false)
        return;
      _user.reload();
      _popup.ShowPopup(message: "Đổi mật khẩu thành công");
    }
  }
}