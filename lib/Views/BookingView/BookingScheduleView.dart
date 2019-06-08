import 'package:flutter/material.dart';

import '../../GlobalData.dart';
import '../../Helper.dart';
import '../../PopupHepler.dart';

class BookingScheduleView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookingScheduleViewState();
  }
}

class BookingScheduleViewState extends State<BookingScheduleView>{
  ScrollController _scrollController;
  bool _viewType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 2*50.0);
    _viewType = true;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async{

      },
      child: Container(
        color: Colors.white,

        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Vị trí hiện tại",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400),),
                      Text(
                          GlobalData.locations.containsKey(GlobalData.locationId)?GlobalData.locations[GlobalData.locationId]:"",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Spacer(),
                  Switch(
                    activeColor: Colors.deepOrangeAccent,
                    value: GlobalData.locationId == -1?false:true,
                    onChanged: (value){
                      if(value == false){
                        setState(() {
                          GlobalData.locationId = -1;
                        });
                      }else{
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context){
                              return new LocationPopup();
                            }
                        );
                      }
                    },

                  ),

                ],
              ),
            ),// Change Location
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Lịch chiếu",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400),),
                      Text(
                          _viewType?"Gộp nhóm":"Liệt kê",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Spacer(),
                  Switch(
                    activeColor: Colors.deepOrangeAccent,
                    value: _viewType,
                    onChanged: (value){
                      setState(() {
                        _viewType = value;
                      });
                    },

                  ),

                ],
              ),
            ),// Change View
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context,index){
                        return Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: InkWell(
                            onTap: (){

                            },
                            child: Column(
                              children: <Widget>[
                                Text(Helper.GetNameOfDate(DateTime.now().add(Duration(days: index)))),
                                Text(DateTime.now().add(Duration(days: index)).day.toString())
                              ],
                            ),
                          )
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),// Date View
          ],
        ),
      )
    );
  }
}