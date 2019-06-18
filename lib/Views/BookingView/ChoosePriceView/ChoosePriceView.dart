import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Cinema.dart';
import 'package:flutter_app/Model/CinemaAddress.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/TicketPrice.dart';
import 'package:intl/intl.dart';
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
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    widget._movie = args["movie"];
    widget._cinema = args["cinema"];
    widget._cinemaAddress = args["address"];
    widget._tickets = args["tickets"];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.red,),
        ),
        title: Column(
          children: <Widget>[
            Text(widget._cinema.shortName,style: TextStyle(color: widget._cinema.color),),
            Text(" - "+widget._cinemaAddress.cinema_name_s2)
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(widget._movie.film_name_vn,maxLines: 3,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),overflow: TextOverflow.clip,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width*0.08,
                                height: MediaQuery.of(context).size.height*0.03,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("C"+widget._movie.film_age.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                    Text(widget._movie.film_duration.toString()+" phút - "+widget._movie.film_information.film_version+" - phụ đề",style: TextStyle(color: Colors.black38),),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(image: NetworkImage(widget._movie.film_information.poster,),fit: BoxFit.fill)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),// Body
          Container(
            child: Row(
              children: <Widget>[
                Text(NumberFormat("#.##0","en_US").format(amount)),
              ],
            ),
          ),// Footer
        ],
      ),
    );
  }

}