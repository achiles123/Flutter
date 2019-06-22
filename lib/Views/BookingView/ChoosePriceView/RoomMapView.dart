import 'package:flutter/material.dart';
import 'package:flutter_app/Model/RoomMap.dart';
class RoomMapView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RoomMapViewState();
  }
}

class RoomMapViewState extends State<RoomMapView>{
  RoomMap _roomMap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.all(5),
                child: FutureBuilder(
                  future: RoomMap.GetMap(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting && _roomMap == null)
                      return CircularProgressIndicator();
                    else{
                      if(snapshot.data != null)
                        _roomMap = snapshot.data;
                      if(_roomMap != null){
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _roomMap.area_index2.length,
                          itemBuilder: (rowContext,rowIndex){
                            List<dynamic> buildRow = _roomMap.area_index2[rowIndex];
                            if(buildRow.length == 0)
                              return Container();
                            String titleRow = _roomMap.title[rowIndex];
                            List<dynamic> statusRow = _roomMap.status[rowIndex];
                            double seatWidth = (MediaQuery.of(rowContext).size.width-50)/buildRow.length;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    height: seatWidth+1,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 10,
                                          margin: EdgeInsets.only(right: 5),
                                          child: Text(titleRow),
                                        ),

                                        ListView.builder(
                                          itemCount: buildRow.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:  NeverScrollableScrollPhysics(),
                                          itemBuilder: (columnContext,columnIndex){
                                            int status = (statusRow[columnIndex] as int);
                                            return InkWell(
                                              onTap: (){

                                              },
                                              child: Container(
                                                width: seatWidth,
                                                height: seatWidth,
                                                margin: EdgeInsets.all(0.5),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(status == 1?0xffe6e6e6:0xffcecece)
                                                ),
                                                child: status != 1?Text(""):Icon(Icons.close,size: seatWidth,color: Colors.white,),
                                              )
                                            );


                                          },
                                        ),
                                      ],
                                    )


                                )
                              ],
                            );


                          },
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                    }
                  },
                ),
              ),
              
            ),//Seat Map
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xffcecece)
                            ),
                          ),
                          Text("Ghế trống",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xffcecece)
                            ),
                          ),
                          Text("Ghế đôi",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.brown
                            ),
                          ),
                          Text("Ghế sofa",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.orangeAccent,
                            ),
                          ),
                          Text("Ghế VIP",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.blue
                            ),
                          ),
                          Text("Ghế DELUXE",style: TextStyle(fontSize: 10),),
                        ],
                      ),

                    ],

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.green
                            ),
                          ),
                          Text("Ghế đang chọn",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xffe6e6e6)
                            ),
                            child: Icon(Icons.close,size: 10,color: Colors.black54,),
                          ),
                          Text("Ghế đã có người chọn",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black
                            ),
                            child: Icon(Icons.close,size: 10,color: Colors.white,),
                          ),
                          Text("Ghế không thể chọn",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 15,
                                height: 1,
                                margin: EdgeInsets.all(1),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.orangeAccent),
                                ),
                                //child: Icon(Icons.remove,color: Colors.orangeAccent,size: 15,),

                              ),
                              Text("Ghế trung tâm",style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 15,
                                height: 1,
                                margin: EdgeInsets.all(1),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.orangeAccent),
                                ),
                                //child: Icon(Icons.remove,color: Colors.orangeAccent,size: 15,),

                              ),
                              Text("Ghế đẹp",style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ),
            
          ],
        ),
      ),
    );
  }
}