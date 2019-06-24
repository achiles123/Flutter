import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Cinema.dart';
import 'package:flutter_app/Model/CinemaAddress.dart';
import 'package:flutter_app/Model/Combo.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/RoomMap.dart';
import 'package:flutter_app/Model/TicketPrice.dart';
import 'package:intl/intl.dart';

import '../../../GlobalData.dart';
class RoomMapView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RoomMapViewState();
  }
}

class RoomMapViewState extends State<RoomMapView>{
  RoomMap _roomMap;
  String _sessionId;
  Movie _movie;
  Cinema _cinema;
  Map<Combo,int> _combos;
  Map<TicketPrice,int> _tickets;
  CinemaAddress _cinemaAddress;
  Map<String,ChooseSeat> chooseSeats;

  Widget DrawSeat(int rowIndex,int columnIndex,double seatWidth){
    Color seatColor = Color(0xffcecece);
    Widget statusWidget;
    List<dynamic> statusRow = _roomMap.status[rowIndex];
    List<dynamic> typeRow = _roomMap.type[rowIndex];
    List<dynamic> seatIdRow = _roomMap.seat_id[rowIndex];
    List<dynamic> seatCodeRow = _roomMap.seat_code[rowIndex];
    int type = (typeRow[columnIndex] as int);
    int status = (statusRow[columnIndex] as int);
    String seatId = (seatIdRow[columnIndex] as String);
    bool checkChosen = false;
    seatColor = GlobalData.seatColor[type];
    if(status == 1)
      seatColor = seatColor.withOpacity(0.5);
    if(status == 2)
      seatColor = Colors.black54;
    switch(type){
      case 3: statusWidget = Icon(Icons.close,size: seatWidth,color: Colors.white,);break;
    }
    if(status == 2)
      statusWidget = Icon(Icons.close,size: seatWidth,color: Colors.white,);
    if(seatId == "0"){
      seatColor = Colors.transparent;
      statusWidget = null;
    }
    if(status == 1)
      statusWidget = Icon(Icons.close,size: seatWidth,color: Colors.white,);
    if(type == 11){
      int degree = 360;
      if(rowIndex == _roomMap.type.length-1)
        degree = 270;
      if(rowIndex == 0)
        degree = 90;
      if(columnIndex == 0 && seatIdRow[1] == "0")
        degree = 0;
      if(columnIndex == typeRow.length-1 && seatIdRow[typeRow.length-2] == "0")
        degree = 180;
      statusWidget = RotationTransition(
        turns: AlwaysStoppedAnimation(degree/360),
        child: Image.asset("assets/image/exit.png",fit: BoxFit.fill,),
      );

    }
    List<ChooseSeat> temp = chooseSeats.values.toList();
    if(temp.any((f)=>f.poins.values.any((f)=> f.x == rowIndex && f.y == columnIndex))){
      checkChosen = true;
      seatColor = Colors.green;
      String seatCode = seatCodeRow[columnIndex];
      int numberSeatCode = int.parse(seatCode.substring(0,1));
      statusWidget = Text(numberSeatCode.toString(),textAlign: TextAlign.center,);
    }

    return InkWell(
        onTap: (){
          int areaId = _roomMap.area_id[rowIndex][columnIndex];
          ChooseSeat chooseSeat = chooseSeats.values.firstWhere((f)=>f.area_id == areaId);
          if(chooseSeat == null)
            return;
          int currentPoint = chooseSeat.current_point;
          setState(() {
            chooseSeats[chooseSeat.id].poins[currentPoint] = new Point(rowIndex,columnIndex);
            currentPoint += 1;
            chooseSeats[chooseSeat.id].current_point += currentPoint%chooseSeat.poins.length;
          });

        },
        child: Container(
          width: seatWidth,
          height: seatWidth,
          margin: EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: seatColor,
          ),
          child: statusWidget,
        )
    );
  }

  Widget SeatNote(){
    return Container(
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
    );//SeatNote
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String dateName;
    DateFormat formatDate = new DateFormat("yyyy-MM-dd");
    DateFormat formatTime = new DateFormat("HH:mm");
    DateTime ticketDate = DateFormat("yyyy-MM-dd HH:mm").parse(_tickets.keys.first.session_time);
    String headerText;
    List<Map<String,dynamic>> queryTicket;
    if(_cinema == null){
      Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
      _cinema = args["cinema"];
      _tickets = args["chooseTicket"];
      _combos = args["chooseCombo"];
      _cinemaAddress = args["address"];
      _movie = args["movie"];
      _sessionId = _tickets.keys.first.session_id;
      queryTicket = new List<Map<String,dynamic>>();
      chooseSeats = new Map<String,ChooseSeat>();
      headerText = "Vui lòng chọn ";
      for(MapEntry<TicketPrice,int> item in _tickets.entries){
        chooseSeats.addAll({item.key.type_code:new ChooseSeat(id: item.key.type_code,area_id: item.key.area_id,quantity: item.value,quantity_chosen: 0  )});
        headerText += item.value.toString()+" "+item.key.type_description+" ";
        queryTicket.add({
          "type_num":item.value,
          "type_code":item.key.type_code,
          "type_max":10,
          "type_area":item.key.area_id
        });
      }

      dateName = DateFormat("dd/MM").format(ticketDate);
      if(formatDate.format(ticketDate) == formatDate.format(DateTime.now()))
        dateName = "Hôm nay";
      if(formatDate.format(ticketDate) == formatDate.format(DateTime.now().add(Duration(days: 1))))
        dateName = "Ngày mai";
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.red,),
        ),
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(_cinema.shortName,style: TextStyle(color: _cinema.color),),
                Text(" - "+_cinemaAddress.cinema_name_s2),
              ],
            ),
            Row(
              children: <Widget>[
                Text(dateName+"-"+formatTime.format(ticketDate)+"-"+_tickets.keys.first.room_title,style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(3),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(headerText),
                ),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black12,
                          Colors.black12.withOpacity(0.01)
                        ],
                        stops: [
                          0.1,
                          0.9
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      Text("Màn Hình",textAlign: TextAlign.center,),
                      Text("("+_movie.film_name_vn+")",textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: FutureBuilder(
                      future: RoomMap.GetMap(_cinema.fetchName,_sessionId,queryTicket),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting && _roomMap == null)
                          return CircularProgressIndicator();
                        else{
                          if(snapshot.data != null)
                            _roomMap = snapshot.data;
                          if(_roomMap != null){
                            List<dynamic> areaIndex = _roomMap.area_index2 != null?_roomMap.area_index2:_roomMap.area_index;
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: areaIndex.length,
                              itemBuilder: (rowContext,rowIndex){
                                List<dynamic> buildRow = areaIndex[rowIndex];
                                double seatWidth = (MediaQuery.of(rowContext).size.width-buildRow.length*0.5-40)/_roomMap.seat_id[rowIndex].length;
                                if(buildRow.length == 0)
                                  return Container(height: seatWidth,);
                                String titleRow = _roomMap.title[rowIndex];
                                List<dynamic> statusRow = _roomMap.status[rowIndex];
                                List<dynamic> typeRow = _roomMap.type[rowIndex];
                                List<dynamic> seatIdRow = _roomMap.seat_id[rowIndex];
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
                                              child: Text(titleRow,style: TextStyle(fontSize: 10),),
                                            ),

                                            ListView.builder(
                                              itemCount: buildRow.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics:  NeverScrollableScrollPhysics(),
                                              itemBuilder: (columnContext,columnIndex){
                                                int type = (typeRow[columnIndex] as int);
                                                int status = (statusRow[columnIndex] as int);
                                                String seatId = (seatIdRow[columnIndex] as String);
                                                return DrawSeat(rowIndex, columnIndex,seatWidth);


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
                            if(snapshot.connectionState == ConnectionState.done){
                              Navigator.of(context).pop("abc");
                            }
                            return CircularProgressIndicator();
                          }
                        }
                      },
                    ),
                  ),

                ),//Seat Map
                SeatNote(),

              ],
            ),
          )


      ),
    );
  }
}
class ChooseSeat{
  final String id;
  final int area_id;
  final int quantity;
  int quantity_chosen;
  int current_point;
  Map<int,Point> poins;
  ChooseSeat({String this.id,int this.area_id,int this.quantity,int this.quantity_chosen,}){
    current_point = 0;
    poins = new Map<int,Point>();
    for(int i=0;i<quantity;i++){
       poins.addAll({0:Point(-1,-1)});
    }
  }
}