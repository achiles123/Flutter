import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseNotification{
  FirebaseMessaging _firebaseMessaging;
  void SetupFirebase(){
    _firebaseMessaging = new FirebaseMessaging();
    MessageListener();
  }

  void MessageListener(){
    if(Platform.isIOS)
      IOSPermission();
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
    _firebaseMessaging.configure(
      onLaunch: (message)async{
          print(message);
      },
      onMessage: (message)async{
        print(message);
      },
      onResume: (message)async{
        print(message);
      },
    );
  }

  void IOSPermission(){
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}