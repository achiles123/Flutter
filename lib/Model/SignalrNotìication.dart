import 'package:signalr_client/signalr_client.dart';

class SignalrNotification{
  static String _serverUrl = "192.168.1.132:6969";
  //final HubConnection _hubConnection = HubConnectionBuilder().withUrl(_serverUrl).build();

  SignalrNotification(){
    int a = 1;
    print('here');
  }

  void receivedNotificaton(){
    int a = 1;
    //_hubConnection.on("Notification", ListeningNotification);
  }

  void ListeningNotification(List<Object> parameters){

  }
}