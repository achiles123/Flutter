import 'dart:async';

import 'package:flutter/material.dart';

import 'GlobalData.dart';
import 'Home/Home.dart';
import 'Login/Login.dart';
import 'Register/Register.dart';
import 'SplashScreen/WelcomeSplash.dart';
import 'Views/StarView/BookingView.dart';
import 'package:geolocator/geolocator.dart';

Future main() async {

  runApp(CompareApp());
  GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  GlobalData.locationPosition = position;
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

