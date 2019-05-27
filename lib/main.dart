import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'Home/Home.dart';
import 'Login/Login.dart';
import 'Register/Register.dart';
import 'SplashScreen/WelcomeSplash.dart';

void main() {
  runApp(CompareApp());
}

class CompareApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: <String,WidgetBuilder>{
        "/":(context) => new Login(),
        "/plash_screen": (context) => new WelcomeSplash(),
        "/register":(context) => new Register(),
        "/home":(context) => new Home()
      },
    );
  }
}

