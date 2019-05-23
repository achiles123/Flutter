import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
 BuildContext context;
  Widget build(BuildContext context) {
    this.context = context;
    return   Center(
      child: Column(
        children: <Widget>[
          GetBody(),       ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget GetBody(){
    return Align(child: Text("Main"),alignment: Alignment.center,);
  }
}