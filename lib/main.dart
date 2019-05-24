import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'Login/Login.dart';

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
        "/":(context) => new Login()
      },
    );
  }
}

