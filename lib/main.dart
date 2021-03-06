import 'dart:async';

import 'package:flutter/material.dart';

import 'GlobalData.dart';
import 'Home/Home.dart';
import 'Login/Login.dart';
import 'Register/Register.dart';
import 'SplashScreen/WelcomeSplash.dart';
import 'Views/BookingView/ChoosePriceView/ChoosePriceView.dart';
import 'Views/BookingView/ChoosePriceView/RoomMapView.dart';
import 'Views/StarView/BookingView.dart';
import 'package:geolocator/geolocator.dart';

Future main() async {

  GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
  if(geolocationStatus == GeolocationStatus.granted){
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GlobalData.locationPosition = position;
  }
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
        "/booking/choose_price":(context) => new ChoosePriceView(),
        "/booking/room_map":(context) => new RoomMapView(),
      },
    );
  }
}

