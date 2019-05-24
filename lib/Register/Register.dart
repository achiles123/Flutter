import 'package:flutter/material.dart';
import 'package:flutter_app/PopupHepler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget{
  @override
  RegisterState createState() => new RegisterState();
}

class RegisterState extends State<Register>{
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              labelText: "Nhập lại mật khẩu",
                            ),
                            validator: (value){
                              if(value != _txtPassword.text)
                                return "Mật khẩu nhập lại không khớp";
                            },
                          ),
                        ),// RePassword
                        RaisedButton(
                          child: Text("Đăng ký"),
                          onPressed: (){
                            _scaffoldContext = context;
                            if(_form.currentState.validate()){
                              RegisterUser(_txtUsername.text,_txtPassword.text);
                            }
                          },
                        ),
                        GestureDetector(
                          child: Text(
                            "Đăng nhập.",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
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

  void RegisterUser(String email,String password) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = null;
    _auth.createUserWithEmailAndPassword(email: email, password: password).then((result)=>{
      user = result,_popup.showPopup(context: _scaffoldContext,message: "Đăng ký thành công")
    }).catchError((onError){
      _popup.showPopup(context: _scaffoldContext,message: "Đăng ký thất bại");
    });
  }
}