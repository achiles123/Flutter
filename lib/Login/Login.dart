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
        body: Builder(builder: (BuildContext context){
          return Container(
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
                )
            ),
            child: Center(
                child:Column(
                  children: <Widget>[
                    Form(
                      key: _form,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text("ĐĂNG NHẬP",style: TextStyle(color: Colors.blue,fontSize:30,fontWeight: FontWeight.w400,fontFamily: "Lobster"),),
                            margin: EdgeInsets.only(bottom: 20),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _txtUsername,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  prefixIcon: Icon(Icons.email,color: Colors.blue,)
                              ),
                              cursorColor: Colors.blue,
                              validator: (value){
                                if(value.length == 0)
                                  return "Hãy nhập email";
                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return "Email không đúng định dạng";
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
                                labelStyle: TextStyle(color: Colors.blue),
                                prefixIcon: Icon(Icons.keyboard_hide,color: Colors.blue),
                              ),
                              cursorColor: Colors.blue,
                              validator: (value){
                                if(value.length == 0)
                                  return "Hãy nhập mật khẩu";
                              },
                            ),
                          ),// Password
                          GestureDetector(
                            child:Container(
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: Icon(Icons.lock_open,color: Colors.white,),
                                color: Colors.blue,
                              ),
                              width: 100,
                              height: 50,

                            ),
                            onTap: (){
                              _scaffoldContext = context;
                              if(_form.currentState.validate()){
                                CheckLogin(_txtUsername.text,_txtPassword.text);
                              }
                            },
                          ),// Button login
                          GestureDetector(
                            child: Text(
                              "Đăng ký tài khoản.",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: (){
                              Navigator.of(context).pushNamed("/register");
                            },
                          ),// Redirect to register
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

  void CheckLogin(String email,String password) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = null;
    _auth.signInWithEmailAndPassword(email: email, password: password).then((result)=>{
      user = result,
      _popup.ShowPopup(context: _scaffoldContext,message: "Đăng nhập thành công"),
      Navigator.of(context).popAndPushNamed("/home")
    }).catchError((onError){
      _popup.ShowPopup(context: _scaffoldContext,message: "Đăng nhập thất bại");
    });
  }
}