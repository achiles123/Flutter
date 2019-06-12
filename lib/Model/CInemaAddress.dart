import 'dart:convert';

import 'package:http/http.dart' as http;
import '../GlobalData.dart';
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
  List<TicketPrice> ticket_price;
  static Map<String,dynamic> _versions;

  CinemaAddress({this.cinema_address,this.cinema_id,this.cinema_image,this.cinema_latitude,this.cinema_longitude,this.cinema_name,this.cinema_name_s1,
    this.cinema_name_s2,this.cinema_slug,this.ticket_price,this.parent_cinema});

  static CinemaAddress partseJson(Map<String,dynamic> json){
    _versions = json["versions"];
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
      //ticket_price: ticketPrices,
    );
  }

  Future<List<TicketPrice>> GetTicketPrice() async {
    List<TicketPrice> ticketPrices = new List<TicketPrice>();
    for(var itemVersion in _versions.entries){
      String version = "";
      switch(itemVersion.key){
        case "2_0":version = "2D";break;
        default:version = "2D";
      }
      List<dynamic>  sessions = itemVersion.value;
      for(dynamic itemSession in sessions){
        Map<String,dynamic> session = itemSession;
        String sessionId = session["session_id"];
        String sessionLink = session["session_link"];
        String sessionStatus = session["session_status"];
        String sessionTime = session["session_time"];
        session_id = sessionId;

        String cinemaName = GlobalData.parentCinema.where((x)=>x.id == parent_cinema).first.shortName;
        Map<String,dynamic> sessionData = await GetSession(sessionId);
        if(sessionData == null)
          continue;
        cinema_code = sessionData["cinema_code"];
        session_code = sessionData["session_code"];
        List<TicketPrice> prices = await TicketPrice.GetPrice(sessionId,session_code,cinemaName,cinema_code);
        prices.forEach((price){
          price.session_id = sessionId;
          price.session_link = sessionLink;
          price.session_status = sessionStatus;
          price.session_time = sessionTime;
          ticketPrices.add(price);
        });
      }
    }
    ticket_price = ticketPrices;
    return ticketPrices;
  }

  Future<Map<String,dynamic >> GetSession(String sessionId) async {
    Map<String,dynamic> result = await http.post(
      "https://123phim.vn/apitomapp",
      headers: {"Content-Type":"application/json; charset=utf-8"},
      body: '{"param":{"url":"/session/detail?session_id='+sessionId+'","keyCache":"no-cache"},"method":"GET"}',
    ).then((response){
      if(response.statusCode == 200){
        return json.decode(response.body)["result"][0];
      }
    }).catchError((error){

    });
    return result;
  }
}