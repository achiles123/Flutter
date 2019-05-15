import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';

class MenuThird extends Menu{
  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return GridView.builder(
      itemCount: 100,
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
                child:Text("Selected item $index") );
          },
        );
      },
    );
  }
}