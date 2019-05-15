import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';

class MenuThird extends Menu{
  @override
  Widget build(BuildContext context){
    return GetBody();
  }

  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return GridView.builder(
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context,int index){
        return new GestureDetector(
          child: Card(
            child: Container(child: Text("Item $index"),alignment: Alignment.center,),
            elevation: 3,

          ),
          onTap: (){
            showDialog(
                context: context,
                barrierDismissible: false,
                child:new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ),
            );
          },
        );
      },
    );
  }
}