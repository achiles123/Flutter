import 'package:flutter/material.dart';
import 'package:flutter_app/Model/FirebaseNotification.dart';
import 'package:flutter_app/Model/SignalrNot%C3%ACication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


String channelId = "1";
String channelName = "Channel 1";
String channelDescription = "Test";
class UserNotificationView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new UserNotificationState();
  }


}
class UserNotificationState extends State<UserNotificationView>{
  FirebaseNotification _firebaseNotification;
  FlutterLocalNotificationsPlugin _localNotifications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initAndroidSetting = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIOSSetting = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(initAndroidSetting, initIOSSetting);
    _localNotifications = new FlutterLocalNotificationsPlugin();
    _localNotifications.initialize(initSetting,onSelectNotification: Notification);
    AndroidNotificationDetails androidNotificationDetails = new AndroidNotificationDetails(channelId, channelName, channelDescription);
    IOSNotificationDetails iosNotificationDetails = new IOSNotificationDetails();
    NotificationDetails notificationDetails = new NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    //_localNotifications.show(0, "test", "ok", notificationDetails);
    SignalrNotification signalr = new SignalrNotification();
    signalr.receivedNotificaton();
    //_firebaseNotification = FirebaseNotification();
    //_firebaseNotification.SetupFirebase();
  }

  Future<String> Notification(String message) async {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(content: Text("abc"),);
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}