import 'dart:convert';

import 'package:http/http.dart' as http;
import '../GlobalData.dart';
import 'Cinema.dart';
import 'TicketPrice.dart';

class CinemaAddress{
  final String cinema_address;
  final String cinema_id;
  final String cinema_image;
  final String cinema_latitude;
  final String cinema_longitude;
  final String cinema_name;
  final String cinema_name_s1;
  final String cinema_name_s2;
  final String cinema_slug;
  final String parent_cinema;
  String cinema_code;
  String session_code;
  String session_id;
  bool _locking = false;
  List<TicketPrice> ticket_price;
  Map<String,dynamic> versions;

  CinemaAddress({this.cinema_address,this.cinema_id,this.cinema_image,this.cinema_latitude,this.cinema_longitude,this.cinema_name,this.cinema_name_s1,
    this.cinema_name_s2,this.cinema_slug,this.ticket_price,this.parent_cinema,this.versions});

  factory CinemaAddress.partseJson(Map<String,dynamic> json){

    return CinemaAddress(
      cinema_address: json["cinema_address"],
      cinema_id: json["cinema_id"],
      cinema_image: json["cinema_image"],
      cinema_latitude: json["cinema_latitude"],
      cinema_longitude: json["cinema_longitude"],
      cinema_name: json["cinema_name"],
      cinema_name_s1: json["cinema_name_s1"],
      cinema_name_s2: json["cinema_name_s2"],
      cinema_slug: json["cinema_slug"],
      parent_cinema: json["parent_cinema"],
      ticket_price: new List<TicketPrice>(),
      versions: json["versions"],
    );
  }

  Future<List<TicketPrice>> GetTicketPrice({bool lock = false}) async {
    if(_locking == true)
      return ticket_price;
    if(lock == true){
      _locking = true;
      if(ticket_price.length != 0)
        return ticket_price;
    }
    List<TicketPrice> ticketPrices = new List<TicketPrice>();
    for(var itemVersion in versions.entries){
      String version = "";
      switch(itemVersion.key){
        case "2_0":version = "2D";break;
        default:version = "2D";
      }
      List<dynamic>  sessions = itemVersion.value;
      for(dynamic itemSession in sessions){
        Map<String,dynamic> session = itemSession;
        String sessionId = session["session_id"];
        if(sessionId == "385033598")
          int a = 1;
        String sessionLink = session["session_link"];
        String sessionStatus = session["session_status"];
        String sessionTime = session["session_time"];
        session_id = sessionId;
        String cinemaName = "";
        for(Cinema itemCinema in GlobalData.parentCinema){
          if(itemCinema.id == parent_cinema){
            cinemaName = itemCinema.fetchName;
          }
        }
        Map<String,dynamic> sessionData = await GetSession(sessionId);
        if(sessionData == null)
          continue;
        cinema_code = sessionData["cinema_code"];
        session_code = sessionData["session_code"];
        List<TicketPrice> prices = new List<TicketPrice>();
        if(parent_cinema == "16"){
          prices  = await TicketPrice.GetPriceRoom(sessionId);
        }else{
          prices = await TicketPrice.GetPrice(sessionId,session_code,cinemaName,cinema_code);
        }
        for(TicketPrice price in prices){
          price.session_id = sessionId;
          price.session_link = sessionLink;
          price.session_status = sessionStatus;
          price.session_time = sessionTime;
          price.version = version;
          if(parent_cinema == "16"){
            price.cinema_id = sessionData["cinema_id"];
            price.room_title = sessionData["room_name"];
          }
          ticketPrices.add(price);
        }
      }
    }
    ticket_price = ticketPrices;
    if(lock == true){
      _locking = false;
    }
    return ticketPrices;
  }

  Future<Map<String,dynamic >> GetSession(String sessionId) async {

    Map<String,dynamic> result;
    await http.post(
      "https://123phim.vn/apitomapp",
      headers: {"Content-Type":"application/json; charset=utf-8"},
      body: '{"param":{"url":"/session/detail?session_id='+sessionId+'","keyCache":"no-cache"},"method":"GET"}',
    ).then((response){
      if(response.statusCode == 200){
        result = json.decode(response.body)["result"][0];
      }
    }).catchError((error){
    });
    return result;
  }
}