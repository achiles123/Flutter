import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/DrawCanvas/BestSeatCanvas.dart';
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
  Map<String,ChooseSeat> _chooseSeats;
  DateTime _ticketDate;
  String _headerText;
  List<Map<String,dynamic>> _queryTicket;
  String _dateName;
  String _chosenHeaderText = "";
  int _amount;

  Widget DrawSeat(int rowIndex,int columnIndex,double seatWidth){
    double seatHeight = seatWidth;
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
    if(status != 0 && status != 1)
      seatColor = Colors.black54;
    if(status != 0)
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
    List<ChooseSeat> temp = _chooseSeats.values.toList();
    if(temp.any((f)=>f.poins.values.any((f)=> f.x == rowIndex && f.y == columnIndex))){
      checkChosen = true;
      seatColor = Color(0xff44c020);
      String seatCode = seatCodeRow[columnIndex];
      int numberSeatCode = int.parse(seatCode.substring(1));
      statusWidget = Container(
        alignment: Alignment.center,
        child: Text(numberSeatCode.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.black54),),
      );

    }
    String seatLeft = columnIndex - 1 >= 0?seatCodeRow[columnIndex-1]:"";
    String seatRight = columnIndex + 1 < seatCodeRow.length?seatCodeRow[columnIndex+1]:"";
    EdgeInsets margin = EdgeInsets.only(
        bottom: 0.5,
        top: 0.5,
        right: seatCodeRow[columnIndex] == "0"?0:(seatRight != seatCodeRow[columnIndex]?0.5:0),
        left: seatCodeRow[columnIndex] == "0"?0:(seatLeft != seatCodeRow[columnIndex]?0.5:0),
    );

    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(seatLeft == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"?0:3),
      bottomLeft: Radius.circular(seatLeft == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"?0:3),
      topRight: Radius.circular(seatRight == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"?0:3),
      bottomRight: Radius.circular(seatRight == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"?0:3),
    );
    if(seatRight == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"){
      seatWidth += 0.5;
    }
    if(seatLeft == seatCodeRow[columnIndex] && seatCodeRow[columnIndex] != "0"){
      seatWidth += 0.5;
    }
    if(type == 3){
      List<int> groupIndex = new List<int>();
      for(int i=0;i<typeRow.length;i++){
        if(typeRow[i] == 3)
          groupIndex.add(i);
      }
      int indexInGroup = groupIndex.indexOf(columnIndex)+1;

      margin = EdgeInsets.only(
        bottom: 0.5,
        top: 0.5,
        right: indexInGroup % 2 == 0?0.5:0,
        left: indexInGroup % 2 == 0?0:0.5,
      );

      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(indexInGroup % 2 == 0?0:3),
        bottomLeft: Radius.circular(indexInGroup % 2 == 0?0:3),
        topRight: Radius.circular(indexInGroup % 2 == 0?3:0),
        bottomRight: Radius.circular(indexInGroup % 2 == 0?3:0),
      );
      seatWidth += 0.5;
    }

    return Builder(
      builder: (context){
        return InkWell(
            onTap: (){
              int areaId = _roomMap.area_id[rowIndex][columnIndex];
              ChooseSeat chooseSeat = _chooseSeats.values.firstWhere((f)=>f.area_id == areaId,orElse: ()=> null);
              if(chooseSeat == null)
                return;
              int currentPoint = chooseSeat.current_point;
              setState(() {
                if(chooseSeat.poins.values.where((f)=>f.x == rowIndex && f.y == columnIndex).length != 0){
                  return;
                }
                if(statusRow[columnIndex] != 0)
                  return;
                int quantityChosen = _chooseSeats[chooseSeat.id].quantity_chosen;
                if(_chooseSeats[chooseSeat.id].poins[currentPoint].x == -1){
                  quantityChosen += 1;
                }
                bool checkSeatError = false;
                if(quantityChosen >= _chooseSeats[chooseSeat.id].quantity){
                  // Validate except couple, longseat, firstclass
                  if(type != 6 && type != 7 && type != 3){
                    _chooseSeats[chooseSeat.id].poins[currentPoint] = new Point(rowIndex,columnIndex);
                    List<Point> pointTemp = _chooseSeats[chooseSeat.id].poins.values.toList();
                    for(Point point in pointTemp){
                      for(MapEntry<int,Point> p in _chooseSeats[chooseSeat.id].poins.entries){
                        if(p.value.x == point.x && (p.value.y - point.y).abs() == 2){
                          Scaffold.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("Vui lòng không để trống ở giữa"),
                          ));
                          _chooseSeats[chooseSeat.id].errors[p.key] = 1;
                          if(_chooseSeats[chooseSeat.id].poins[currentPoint].x == point.x && _chooseSeats[chooseSeat.id].poins[currentPoint].y == point.y){
                            checkSeatError = true;
                          }
                          break;
                        }
                      }

                    }
                    for(MapEntry<int,Point> point in _chooseSeats[chooseSeat.id].poins.entries){
                      List<int> statusRow = List.from(_roomMap.status[point.value.x]);
                      int beginIndex = statusRow.indexOf(0);
                      int lastIndex = statusRow.lastIndexOf(0);
                      Point existedPoint = pointTemp.firstWhere((f)=> f.x == point.value.x && (f.y == beginIndex || f.y == lastIndex ),orElse:()=> null);
                      if(existedPoint != null && point.value.y - 1 != existedPoint.y && point.value.y + 1 != existedPoint.y && (point.value.y - 1 == beginIndex || point.value.y + 1 == lastIndex)){
                        Scaffold.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Vui lòng không để trống đầu dãy"),
                        ));
                        _chooseSeats[chooseSeat.id].errors[point.key] = 2;
                        if(_chooseSeats[chooseSeat.id].poins[currentPoint].x == point.value.x && _chooseSeats[chooseSeat.id].poins[currentPoint].y == point.value.y){
                          checkSeatError = true;
                        }
                        break;
                      }
                      if(existedPoint == null && (point.value.y - 1 == beginIndex || point.value.y + 1 == lastIndex)){
                        Scaffold.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Vui lòng không để trống đầu dãy"),
                        ));
                        _chooseSeats[chooseSeat.id].errors[point.key] = 2;
                        if(_chooseSeats[chooseSeat.id].poins[currentPoint].x == point.value.x && _chooseSeats[chooseSeat.id].poins[currentPoint].y == point.value.y){
                          checkSeatError = true;
                        }
                        break;
                      }
                    }
                  }

                }
                _chooseSeats[chooseSeat.id].poins[currentPoint] = new Point(rowIndex,columnIndex);
                currentPoint += 1;
                _chooseSeats[chooseSeat.id].current_point = currentPoint%chooseSeat.poins.length;
                if(quantityChosen <= _chooseSeats[chooseSeat.id].quantity)
                  _chooseSeats[chooseSeat.id].quantity_chosen = quantityChosen;
                if(checkSeatError == false)
                  _chooseSeats[chooseSeat.id].errors[currentPoint] = 0;
                List<String> temp = new List<String>();
                for(ChooseSeat item in _chooseSeats.values){
                  temp.addAll(item.poins.values.toList().where((f)=>f.x != -1).map((f)=> _roomMap.seat_code[f.x][f.y] as String));
                }
                _chosenHeaderText = temp.join(",");
              });

            },
            child: Container(
              width: seatWidth,
              height: seatHeight,
              margin: margin,
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none,width: 0),
                borderRadius: borderRadius,
                color: seatColor,
              ),
              child: statusWidget,
            )
        );
      },
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
                          color: Color(0xff8b572a),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xff50e3c2),
                          ),
                        ),
                        Text("Ghế First Class",style: TextStyle(fontSize: 10),),
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
    DateFormat formatDate = new DateFormat("yyyy-MM-dd");
    DateFormat formatTime = new DateFormat("HH:mm");
    if(_cinema == null){
      Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
      _cinema = args["cinema"];
      _tickets = args["chooseTicket"];
      _combos = args["chooseCombo"];
      _cinemaAddress = args["address"];
      _movie = args["movie"];
      _amount = args["amount"];
      _sessionId = _tickets.keys.first.session_id;
      _queryTicket = new List<Map<String,dynamic>>();
      _chooseSeats = new Map<String,ChooseSeat>();
      _headerText = "Vui lòng chọn ";
      for(MapEntry<TicketPrice,int> item in _tickets.entries){
        _chooseSeats.addAll({item.key.type_code:new ChooseSeat(id: item.key.type_code,area_id: item.key.area_id,quantity: item.value,quantity_chosen: 0  )});
        _headerText += item.value.toString()+" "+item.key.type_description+" ";
        _queryTicket.add({
          "type_num":item.value,
          "type_code":item.key.type_code,
          "type_max":10,
          "type_area":item.key.area_id
        });
      }
      _ticketDate = DateFormat("yyyy-MM-dd HH:mm").parse(_tickets.keys.first.session_time);
      _dateName = DateFormat("dd/MM").format(_ticketDate);
      if(formatDate.format(_ticketDate) == formatDate.format(DateTime.now()))
        _dateName = "Hôm nay";
      if(formatDate.format(_ticketDate) == formatDate.format(DateTime.now().add(Duration(days: 1))))
        _dateName = "Ngày mai";
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop("abc");
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
                Text(_dateName+"-"+formatTime.format(_ticketDate)+"-"+_tickets.keys.first.room_title,style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (bodyContext){
          return Container(
              height: double.infinity,
              color: Colors.white,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(3),
                      height: MediaQuery.of(bodyContext).size.height-136,
                      child: ListView(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(_headerText),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text("Đã chọn: "+_chosenHeaderText),
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: FutureBuilder(
                                    future: RoomMap.GetMap(_cinema.fetchName,_sessionId,_queryTicket),
                                    builder: (context,snapshot){
                                      if(snapshot.connectionState == ConnectionState.waiting && _roomMap == null)
                                        return CircularProgressIndicator();
                                      else{
                                        if(snapshot.data != null)
                                          _roomMap = snapshot.data;
                                        if(_roomMap != null){
                                          List<dynamic> areaIndex = _roomMap.area_index2 != null?_roomMap.area_index2:_roomMap.area_index;
                                          int rowBestSeat = _roomMap.title.indexOf(_roomMap.best_seat.substring(0,1));
                                          int columnBestSeat = List.from(_roomMap.seat_code[rowBestSeat]).indexOf(_roomMap.best_seat);
                                          double size = (MediaQuery.of(context).size.width-_roomMap.seat_code[1].length*0.5-40)/_roomMap.seat_id[1].length;
                                          //print("Formula:"+MediaQuery.of(context).size.width.toString()+"-"+_roomMap.seat_code[1].length.toString()+"-"+_roomMap.seat_id[1].length.toString()+"  .Size :"+size.toString());
                                          Offset startPoint = Offset(columnBestSeat*size -2, rowBestSeat*size+rowBestSeat-2);
                                          Offset endPoint = Offset(columnBestSeat*size + size*4 + 6, rowBestSeat*size+rowBestSeat-2);
                                          Offset heightPoint = Offset(startPoint.dx+(endPoint.dx-startPoint.dx)/2, (rowBestSeat+3)*size+rowBestSeat+6);

                                          Offset startPointO = Offset((columnBestSeat-2)*size -2, (rowBestSeat-1)*size+rowBestSeat-2);
                                          Offset endPointO = Offset(columnBestSeat*size + size*4 +size*2 + 6, (rowBestSeat-1)*size+rowBestSeat-2);
                                          Offset heightPointO = Offset(startPoint.dx+(endPointO.dx-startPointO.dx)/2, (rowBestSeat+5)*size+rowBestSeat+6);
                                          return CustomPaint(
                                            foregroundPainter: BestSeatCanvas(
                                                inlineColor: Colors.red,
                                                outlineColor: Colors.redAccent,
                                                width: 1.5,
                                                inlineOffset: [startPoint, endPoint, heightPoint,],
                                                outlineOffset: [startPointO,endPointO,heightPointO]
                                            ),

                                            child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: areaIndex.length,
                                              itemBuilder: (rowContext,rowIndex){
                                                List<dynamic> buildRow = areaIndex[rowIndex];
                                                double seatWidth = (MediaQuery.of(rowContext).size.width-buildRow.length-31)/_roomMap.seat_id[rowIndex].length;
                                                //print("Formula:"+MediaQuery.of(rowContext).size.width.toString()+"-"+buildRow.length.toString()+"-"+_roomMap.seat_id[rowIndex].length.toString()+"  .Real Size :"+seatWidth.toString());
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
                                            ),
                                          );

                                        }else{
                                          if(snapshot.connectionState == ConnectionState.done){
                                            Navigator.of(context).pop("Có lỗi đã xảy ra");
                                          }
                                          return CircularProgressIndicator();
                                        }
                                      }
                                    },
                                  ),



                                ),

                              ),//Seat Map
                            ],
                          ),
                          SeatNote(),

                        ],
                      ),
                    ),
                    Card(
                      elevation: 0.5,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(0),borderSide: BorderSide(color: Colors.black26),gapPadding: 0),
                      margin: EdgeInsets.all(0),

                      //borderOnForeground: true,

                      child: Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              margin: EdgeInsets.only(left: 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 5,right: 5),
                                          child: Icon(Icons.event_note,size: 26,color: Colors.grey,),
                                        ),

                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              (_tickets.values.toList().reduce((x,y)=> x+y )+(_combos.length == 0?0:_combos.values.toList().reduce((x,y)=>x+y))).toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 8),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text(NumberFormat("#,##0","en_US").format(_amount).replaceAll(",", "."),style: TextStyle(color: Color(0xff267326),fontSize: 18),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text("đ",style: TextStyle(color: Colors.grey),),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  if(_chooseSeats.values.firstWhere((f)=>f.quantity == f.quantity_chosen,orElse: ()=>null) == null)
                                    return;
                                  
                                  for(ChooseSeat item in _chooseSeats.values){
                                    for(var error in item.errors.entries){
                                      if(error.value != 0){
                                        String messageError;
                                        switch(error.value){
                                          case 1:messageError = "Vui lòng không để trống ở giữa";break;
                                          case 2:messageError = "Vui lòng không để trống đầu dãy";break;
                                        }
                                        Scaffold.of(bodyContext).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                                        Scaffold.of(bodyContext).showSnackBar(SnackBar(
                                          duration: Duration(milliseconds: 4000),
                                          content: Text(messageError),
                                          action: SnackBarAction(label: "Ẩn", onPressed: (){
                                            Scaffold.of(bodyContext).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                                          }),
                                        ));
                                        return;
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  height: 100,
                                  color: Color(_chooseSeats.values.firstWhere((f)=>f.quantity == f.quantity_chosen,orElse: ()=>null) == null?0xffb3b3b3:0xff267326),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("TIẾP TỤC",style: TextStyle(color: Colors.white,fontSize: 18),),
                                      Icon(Icons.arrow_forward,color: Colors.white,size: 22,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )// Footer
                  ],
                ),
              )


          );
        },
      )





    );
  }
}
class ChooseSeat{
  final String id;
  final int area_id;
  final int quantity;
  int quantity_chosen;
  int current_point;
  Map<int,int> errors;
  Map<int,Point> poins;
  ChooseSeat({String this.id,int this.area_id,int this.quantity,int this.quantity_chosen,}){
    current_point = 0;
    poins = new Map<int,Point>();
    errors = new Map<int,int>();
    for(int i=0;i<quantity;i++){
       poins.addAll({i:Point(-1,-1)});
       errors.addAll({i:0});
    }
  }
}