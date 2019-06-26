import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'GlobalData.dart';

class PopupHelper {
  BuildContext _context;
  PopupHelper(BuildContext context){
    _context = context;
  }

  void ShowPopup({BuildContext context,String message}) {
    if(context != null){
      _context = context;
    }
    // TODO: implement build
    showDialog(context: _context,barrierDismissible: true,
        child: CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.close),
              onPressed: (){
                Navigator.of(_context).pop();
              },
            ),
          ],
        )
    );
  }

  void ShowPopupError({BuildContext context,String message}) {
    if(context != null){
      _context = context;
    }
    // TODO: implement build
    showDialog(context: _context,barrierDismissible: true,
        child: CupertinoAlertDialog(
          title: Icon(Icons.error,color: Colors.red,),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.close,color: Colors.red,),
              onPressed: (){
                Navigator.of(_context).pop();
              },
            ),
          ],
        )
    );
  }
}

class LocationPopup extends StatefulWidget{
  Function onClose;
  LocationPopup({this.onClose});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LocationPopupState();
  }
}

class LocationPopupState extends State<LocationPopup>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async =>false,
        child: Material(
            type: MaterialType.transparency,
            child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width*0.8,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*0.8-50,
                        child: ListView.builder(
                          itemCount: GlobalData.locations.length,
                          itemBuilder: (context,index){
                            return Container(
                              height: 30,
                              child: Row(
                                children: <Widget>[
                                  Card(
                                    elevation: 0,
                                    child:  Radio(
                                      groupValue: GlobalData.locationId,
                                      value: index,
                                      onChanged: (value){
                                        setState(() {
                                          GlobalData.locationId = value;
                                        });
                                      },
                                    ),
                                  ),

                                  Container(
                                    child: Text(GlobalData.locations[index],style: TextStyle(fontSize: 12,color: Colors.black),),
                                  )
                                ],
                              ),
                            );

                          },
                        ),
                      ),// Location panel
                      Container(
                        height: 40,
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text("Chọn",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          textTheme: ButtonTextTheme.primary,
                          onPressed: (){
                            if(GlobalData.locationId != -1)
                              Navigator.of(context).pop();
                            if(widget.onClose != null)
                              widget.onClose();
                          },
                        ),
                      ),// Location confirm
                    ],
                  ),
                )
            )
        )


    );
  }
}

class TooltipPopup extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TooltipPopupState();
  }
}

class TooltipPopupState extends State<TooltipPopup>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}