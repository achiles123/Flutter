import 'package:flutter/material.dart';
export 'package:flutter_app/Menu/MenuFirst.dart';
export 'package:flutter_app/Menu/MenuSecond.dart';
export 'package:flutter_app/Menu/MenuThird.dart';

class Menu extends StatelessWidget{

  Widget build(BuildContext context) {
<<<<<<< HEAD
    return   Center(
=======
    return  Center(
>>>>>>> c6a7bef3ea83c7b8a28a54e63b9cc46d4dbf2641
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