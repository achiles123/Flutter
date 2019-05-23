import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolateFlow{
  Isolate _isolate;
  SendPort _sendPort;

  Future startIsolate() async {
    ReceivePort receivePort = new ReceivePort();
    _isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
    _sendPort.send(data);
    _sendPort = await receivePort.first;
  }

  void runTimer(SendPort sendPort){
    ReceivePort receivePort = new ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((dynamic message){

    });
  }

  void stop(){
    if(_isolate != null){
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }
}