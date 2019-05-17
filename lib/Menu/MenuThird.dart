import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';

class MenuThird extends Menu{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBody();
  }

  Widget GetListView(){
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context,int index){
          return new GestureDetector(
            child: Card(
              child: Container(child: Text("Item $index"),alignment: Alignment.center,),
              elevation: 3,

            ),
            onTap: (){
              showDialog(
                context: context,
                barrierDismissible: true,
                child: CupertinoAlertDialog(
                  content: Text("Cicked Item $index"),
                  actions: <Widget>[
                    FlatButton(
                      child: Center(child: Icon(Icons.close),),
                      onPressed: (){Navigator.of(context).pop();},
                    )
                  ],
                )
              );
            },
          );
        },

    );
  }

  Widget GetGridView(){
    return GridView.builder(
      itemCount: 100,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context,int index){
        return new GestureDetector(
          child: Card(
            child: Container(child: Text("Item $index"),alignment: Alignment.center,),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
          onTap: (){
            showDialog(
                context: context,
                barrierDismissible: true,
                child:CupertinoAlertDialog(
                  content: Text("Clicked Item $index"),
                  actions: <Widget>[
                    FlatButton(
                      child: Icon(Icons.close,color: Colors.red,),
                      onPressed: (){Navigator.of(context).pop();},
                    ),
                  ],
                )

            );
          },
        );
      },
    );
  }

  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return TabBarView(
      controller: TabController(length: 2),
      children: <Widget>[
        GetListView(),
        GetGridView(),
      ],
    );
  }
}