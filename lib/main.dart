import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'Home/Home.dart';
import 'Login/Login.dart';
import 'Register/Register.dart';
import 'SplashScreen/WelcomeSplash.dart';
import 'Views/StarView/BookingView.dart';

void main() {

  runApp(CompareApp());
}

class CompareApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.deepOrangeAccent,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black)
        ),
      ),
      initialRoute: "/home",
      routes: <String,WidgetBuilder>{
        "/":(context) => new Login(),
        "/plash_screen": (context) => new WelcomeSplash(),
        "/register":(context) => new Register(),
        "/home":(context) => new Home(),
        "/booking":(context) => new BookingView(),
      },
    );
  }
}

