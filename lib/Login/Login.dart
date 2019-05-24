import 'package:flutter/material.dart';
import 'package:flutter_app/PopupHepler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget{
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login>{
  TextEditingController _txtUsername;
  TextEditingController _txtPassword;
  GlobalKey<FormState> _form;
  BuildContext _scaffoldContext;
  PopupHelper _popup;
  @override
  Widget build(BuildContext context){
    _form = new GlobalKey<FormState>();
    _txtUsername = new TextEditingController();
    _txtPassword = new TextEditingController();
    _popup = new PopupHelper(context);
    return Scaffold(
      body: Builder(builder: (BuildContext context){
        return Center(
            child:Column(
              children: <Widget>[
                Form(
                  key: _form,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _txtUsername,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            labelText: "Email",
                          ),
                          validator: (value){
                            if(value.length == 0)
                              return "Hãy nhập email";
                            Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value))
                              return "Email không đúng định dạng";
                            else
                              return null;
                          },
                        ),
                      ),// Email
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _txtPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            labelText: "Mật khẩu",
                          ),
                          validator: (value){
                            if(value.length == 0)
                              return "Hãy nhập mật khẩu";
                          },
                        ),
                      ),// Password
                      RaisedButton(
                        child: Text("Đăng nhập"),
                        onPressed: (){
                          _scaffoldContext = context;
                          if(_form.currentState.validate()){
                            CheckLogin(_txtUsername.text,_txtPassword.text);
                          }
                        },
                      )
                    ],
                  ),
                ), //Form
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
        );
      })
    );
  }

  void CheckLogin(String email,String password) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = null;
    _auth.signInWithEmailAndPassword(email: email, password: password)..then((result)=>{
      user = result
    }).catchError((onError){
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(content: Text(onError.message),duration: Duration(seconds: 10),));
      return;
    });
  }
}