import 'package:signalr_client/signalr_client.dart';
import 'package:http/http.dart' as http;

class SignalrNotification{
  static String _serverUrl = "http://192.168.1.132:6969/notification";
  HubConnection _hubConnection ;
  Function onMessage;

  Future init() async {
    await http.get(_serverUrl).then((response){
      String rs = response.body;
    });
    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder().withUrl(_serverUrl).build();
      if (_hubConnection.state != HubConnectionState.Connected) {
        await _hubConnection.start();
      }
      _hubConnection.onclose((error) {
        print(error);
        _hubConnection.start();
      });
      _hubConnection.on("Notification", _handleIncommingChatMessage);

    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
    }
  }

  void _handleIncommingChatMessage(List<Object> args){
    List<dynamic> data = args[0];
    onMessage(data);
  }

}