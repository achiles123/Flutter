import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Cinema.dart';
import 'package:flutter_app/Model/CinemaAddress.dart';
import 'package:flutter_app/Model/Combo.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/TicketPrice.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ChoosePriceView extends StatefulWidget{
  Movie _movie;
  Cinema _cinema;
  CinemaAddress _cinemaAddress;
  List<TicketPrice> _tickets;

  ChoosePriceView({Movie movie,Cinema cinema,CinemaAddress cinemaAddress,List<TicketPrice> tickets}){
    _movie = movie;
    _cinema = cinema;
    _tickets = tickets;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChoosePriceState();
  }

}

class ChoosePriceState extends State<ChoosePriceView>{
  Map<String,int> chooseTicket;
  Map<String,int> chooseCombo = new Map<String,int>();
  List<Combo> _combo;
  int amount  = 0;


  @override
  void initState() {
    // TODO: implement initState
    //super.initState();

  }
  @override
  Widget build(BuildContext context) {
    if(widget._movie == null){
      Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
      widget._movie = args["movie"];
      widget._cinema = args["cinema"];
      widget._cinemaAddress = args["address"];
      widget._tickets = args["tickets"];
      chooseTicket = new Map<String,int>();
      for(TicketPrice ticket in widget._tickets){
        chooseTicket.addAll({ticket.type_code:0});
      }
    }

    // TODO: implement build
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
                  Text(widget._cinema.shortName,style: TextStyle(color: widget._cinema.color),),
                  Text(" - "+widget._cinemaAddress.cinema_name_s2),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(bodyContext).size.height - 140,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 7,right: 7),
                    child: ListView(
                      shrinkWrap: true,
                      physics:  AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(widget._movie.film_name_vn,maxLines: 3,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),overflow: TextOverflow.clip,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          if(widget._movie.film_age != 0)
                                            Container(
                                              alignment: Alignment.center,
                                              width: 30,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.red,
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("C"+widget._movie.film_age.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),

                                                ],
                                              ),
                                            ),
                                          Text(widget._movie.film_duration.toInt().toString()+" phút - "+widget._tickets[0].version+" - phụ đề",style: TextStyle(color: Colors.black38),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ),
                              LayoutBuilder(
                                builder: (context,constrain){
                                  return Container(
                                    alignment: Alignment.topRight,
                                    width: MediaQuery.of(context).size.width*0.25,
                                    height: 105,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(image: NetworkImage(widget._movie.film_information.poster,),fit: BoxFit.fill)
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: Text("Chọn loại vé và số lượng",),
                        ),
                        Divider(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget._tickets.length+widget._tickets.length-1,
                                itemBuilder: (context,index){
                                  if(index.isOdd){
                                    return Divider();
                                  }
                                  int realIndex = index ~/2;
                                  String ticketType = widget._tickets[realIndex].type_code;
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Tooltip(
                                                        message: widget._tickets[realIndex].type_long_desc,
                                                        height: 24,
                                                        verticalOffset: 10,
                                                        child: Container(
                                                            margin: EdgeInsets.only(right: 3),
                                                            child:Icon(Icons.info_outline,size: 15,color: Colors.black38,),
                                                        ),
                                                      ),

                                                      Text(widget._tickets[realIndex].type_description),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(NumberFormat("#,##0","en_US").format(widget._tickets[realIndex].type_price).replaceAll(",", "."),style: TextStyle(fontSize: 16),),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 5),
                                                          child: Text("đ",style: TextStyle(color: Colors.grey),),
                                                        ),

                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                          ),
                                        ),

                                        Container(
                                          width: 30,
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.white.withOpacity(chooseTicket[ticketType] == 0?1:0)
                                          ),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                chooseTicket[ticketType] -= 1;
                                                if(chooseTicket[ticketType] < 0)
                                                  chooseTicket[ticketType] = 0;
                                                else
                                                  amount -= widget._tickets[realIndex].type_price;
                                              });

                                            },
                                            child:Icon(Icons.remove,color: Colors.red,),
                                          ),
                                        ),
                                        Container(
                                          width: 25,
                                          child:  Text(chooseTicket[ticketType].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                        ),
                                        Container(
                                          width: 30,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                chooseTicket[ticketType] += 1;
                                                amount += widget._tickets[realIndex].type_price;
                                              });
                                            },
                                            child:Icon(Icons.add,color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),// Ticket list
                        Divider(),
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: Text("COMBO"),
                        ),
                        Divider(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: FutureBuilder(
                                future: _combo == null?Combo.GetByCinema(widget._cinema.fetchName,widget._tickets[0].cinema_id):Future(()=>_combo),
                                builder: (context,snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting && _combo == null)
                                    return CircularProgressIndicator();
                                  else{
                                    if(snapshot.data != null)
                                      _combo = snapshot.data;
                                    if(_combo != null){
                                      if(chooseCombo.length == 0)
                                        chooseCombo.addAll(Map.fromIterable(_combo,key: (item)=>(item as Combo).item_id,value:(item)=> 0));
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _combo.length+_combo.length-1,
                                        itemBuilder: (context,index){
                                          if(index.isOdd)
                                            return Divider();
                                          int realIndex = index ~/2;
                                          String comboId = _combo[realIndex].item_id;
                                          return Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage(_combo[realIndex].item_img_thumb))
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 3),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Tooltip(
                                                              message: _combo[realIndex].item_desc,
                                                              height: 24,
                                                              verticalOffset: 10,
                                                              child: Container(
                                                                margin: EdgeInsets.only(right: 3),
                                                                child:Icon(Icons.info_outline,size: 15,color: Colors.black38,),
                                                              ),
                                                            ),

                                                            Text(_combo[realIndex].item_name),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(NumberFormat("#,##0","en_US").format(int.parse(_combo[realIndex].item_price)).replaceAll(",", "."),style: TextStyle(fontSize: 16),),
                                                            Container(
                                                              margin: EdgeInsets.only(left: 5),
                                                              child: Text("đ",style: TextStyle(color: Colors.grey),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ),
                                                Container(
                                                  width: 30,
                                                  foregroundDecoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(chooseCombo[comboId] == 0?1:0)
                                                  ),
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        chooseCombo[comboId] -= 1;
                                                        if(chooseCombo[comboId] < 0)
                                                          chooseCombo[comboId] = 0;
                                                        else
                                                          amount -= int.parse(_combo[realIndex].item_price);
                                                      });

                                                    },
                                                    child:Icon(Icons.remove,color: Colors.red,),
                                                  ),
                                                ),
                                                Container(
                                                  width: 25,
                                                  child:  Text(chooseCombo[comboId].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                                ),
                                                Container(
                                                  width: 30,
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        chooseCombo[comboId] += 1;
                                                        amount += int.parse(_combo[realIndex].item_price);
                                                      });
                                                    },
                                                    child:Icon(Icons.add,color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                          ],
                        ),// Combo

                      ],
                    ),
                  ), // Body
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
                                            (chooseTicket.values.toList().reduce((x,y)=> x+y )+(chooseCombo.length == 0?0:chooseCombo.values.toList().reduce((x,y)=>x+y))).toString(),
                                            style: TextStyle(color: Colors.white,fontSize: 8),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 3),
                                  child: Text(NumberFormat("#,##0","en_US").format(amount).replaceAll(",", "."),style: TextStyle(color: Color(0xff267326),fontSize: 18),),
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
                              onTap: (){
                                Navigator.of(context).popAndPushNamed("/booking/room_map");
                              },
                              child: Container(
                                height: 100,
                                color: Color(chooseTicket.values.toList().reduce((x,y)=> x+y ) == 0?0xffb3b3b3:0xff267326),
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
            );
          },
        )
    );
  }

}