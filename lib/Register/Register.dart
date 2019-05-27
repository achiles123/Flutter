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
  void initState() {
    // TODO: implement initState
    super.initState();
    _form = new GlobalKey<FormState>();
    _txtUsername = new TextEditingController();
    _txtPassword = new TextEditingController();
    _popup = new PopupHelper(context);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(builder: (BuildContext context){
          return  Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xffccffcc),
                    Color(0xfff2f2f2),
                  ],
                  stops: [0.0, 1.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated
              ),

            ),
            child: Center(
                child:Column(
                  children: <Widget>[
                    Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text("ĐĂNG KÝ",style: TextStyle(color: Colors.blue,fontSize:30,fontWeight: FontWeight.w400,fontFamily:"Lobster" ),),
                            margin: EdgeInsets.only(bottom: 20),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 35,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _txtUsername,
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.all(0),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.blue),
                                prefixIcon: Icon(Icons.email,color: Colors.blue,),
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
                            height: 35,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _txtPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.all(0),
                                labelText: "Mật khẩu",
                                labelStyle: TextStyle(color: Colors.blue),
                                prefixIcon: Icon(Icons.keyboard_hide,color: Colors.blue),
                              ),
                              validator: (value){
                                if(value.length == 0)
                                  return "Hãy nhập mật khẩu";
                              },
                            ),
                          ),// Password
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 35,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.all(0),
                                labelText: "Nhập lại mật khẩu",
                                labelStyle: TextStyle(color: Colors.blue),
                                prefixIcon: Icon(Icons.repeat,color: Colors.blue),
                              ),
                              validator: (value){
                                if(value != _txtPassword.text)
                                  return "Mật khẩu nhập lại không khớp";
                              },
                            ),
                          ),// RePassword
                          GestureDetector(
                            child:Container(
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: Icon(Icons.add,color: Colors.white,),
                                color: Colors.blue,
                              ),
                              width: 100,
                              height: 50,

                            ),
                            onTap: (){
                              _scaffoldContext = context;
                              if(_form.currentState.validate()){
                                RegisterUser(_txtUsername.text,_txtPassword.text);
                              }
                            },
                          ),// Button login
                          GestureDetector(
                            child: Text(
                              "Đăng nhập.",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                          )// Redirect to login
                        ],
                      ),
                    ), //Form
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
            ),
          );
        })
    );
  }

  void RegisterUser(String email,String password) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = null;
    _auth.createUserWithEmailAndPassword(email: email, password: password).then((result)=>{
      user = result,_popup.ShowPopup(context: _scaffoldContext,message: "Đăng ký thành công")
    }).catchError((onError){
      _popup.ShowPopup(context: _scaffoldContext,message: "Đăng ký thất bại");
    });
  }
}