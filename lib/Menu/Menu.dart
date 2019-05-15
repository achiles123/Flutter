import 'package:flutter/material.dart';
export 'package:flutter_app/Menu/MenuFirst.dart';
export 'package:flutter_app/Menu/MenuSecond.dart';
export 'package:flutter_app/Menu/MenuThird.dart';

class Menu extends StatelessWidget{

  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: <Widget>[
          GetBody(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget GetBody(){
    return Align(child: Text("Main"),alignment: Alignment.center,);
  }
}