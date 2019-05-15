import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';

class MenuFirst extends Menu {
  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return Column(
      children: <Widget>[
        Align(child: Text("Menu First"),alignment: Alignment.center,),
        new SnackButton()
      ],
    );
  }
}
class SnackButton extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(
      child: RaisedButton(onPressed: () {
        final snackBar = SnackBar(
          content: Text("This is snack bar"),
          action: SnackBarAction(label: "Cancel", onPressed: (){}),
        );
        Scaffold.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
        Scaffold.of(context).showSnackBar(snackBar);
      },child: Text("Snack button"),),
    );
  }
}