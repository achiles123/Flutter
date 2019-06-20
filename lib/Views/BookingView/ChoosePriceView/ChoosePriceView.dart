import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Cinema.dart';
import 'package:flutter_app/Model/CinemaAddress.dart';
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
  Map<String,int> chooseResult;
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
      chooseResult = new Map<String,int>();
      for(TicketPrice ticket in widget._tickets){
        chooseResult.addAll({ticket.type_code:0});
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
        body: LayoutBuilder(
          builder: (bodyContext,constrain){
            return Container(
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(bodyContext).size.height - 148,
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
                          child: Text("Chọn loại vé và số lượng"),
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
                                                      InkWell(
                                                        child: Container(
                                                          margin: EdgeInsets.only(right: 5),
                                                          child: Icon(Icons.info_outline,size: 15,color: Colors.black38,),
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
                                                        Text(widget._tickets[realIndex].type_price.toString()),
                                                        Text("đ",style: TextStyle(color: Colors.grey),),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                          ),
                                        ),

                                        Container(
                                          width: 30,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                chooseResult[ticketType] -= 1;
                                                if(chooseResult[ticketType] < 0)
                                                  chooseResult[ticketType] = 0;
                                              });

                                            },
                                            child:Icon(FontAwesomeIcons.minus,color: Colors.red,size: 14,),
                                          ),
                                        ),
                                        Container(
                                          width: 25,
                                          child: Text(chooseResult[ticketType].toString(),style: TextStyle(fontSize: 18,),textAlign: TextAlign.center,),
                                        ),
                                        Container(
                                          width: 30,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                chooseResult[ticketType] += 1;
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
                        ),


                      ],
                    ),
                  ), // Body
                  Card(
                    elevation: 0.5,
                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    borderOnForeground: true,

                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Text(NumberFormat("#,##0","en_US").format(amount)),
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