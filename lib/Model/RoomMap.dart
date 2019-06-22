import 'dart:convert';

import 'package:http/http.dart' as http;

class RoomMap{
  final List<dynamic> area_id;
  final List<dynamic> area_index;
  final List<dynamic> area_index2;
  final Map<String,dynamic> area_summary;
  final String best_seat;
  final List<dynamic> col_index;
  final List<dynamic> group;
  final String room_title;
  final String room_version;
  final List<dynamic> row_index;
  final List<dynamic> seat_code;
  final List<dynamic> seat_id;
  final List<dynamic> status;
  final List<dynamic> title;
  final List<dynamic> type;

  RoomMap({this.area_id,this.area_index,this.area_index2,this.area_summary,this.best_seat,this.col_index,this.group,this.room_title,this.room_version,this.row_index,this.seat_code,this.seat_id,this.status,this.title,this.type,});

  factory RoomMap.parseJson(Map<String,dynamic> json){
    return RoomMap(
      area_id: json["area_id"],
      area_index: json["area_index2"] == null?json["area_index"]:null,
      area_index2: json["area_index2"],
      area_summary: json["area_summary"],
      best_seat: json["best_seat"],
      col_index: json["col_index"],
      group: json["group"],
      room_title: json["room_title"],
      room_version: json["room_version"],
      row_index: json["row_index"],
      seat_code: json["seat_code"],
      seat_id: json["seat_id"],
      status: json["status"],
      title: json["title"],
      type: json["type"],
    );
  }

  static Future<RoomMap> GetMap() async {
    RoomMap result = null;
    await http.post(
      "https://123phim.vn/apitomapp",
      headers: {"Content-Type": "application/json;charset=UTF-8"},
      body:'{"param":{"url":"/checkout/galaxy/ticket","keyCache":"no-cache"},"data":{"session_id":"385063283","list_ticket":[{"type_num":2,"type_desc":"Vé người lớn","type_price":85000,"type_area":2,"type_code":"0004","type_max":10}],"user_session_id":"","is_full_data":1},"method":"POST"}'
    ).then((response){
      if(response.statusCode == 200){
        Map<String,dynamic> rs = json.decode(response.body)["result"]["list_seat"];

        result = RoomMap.parseJson(rs);
      }
    }).then((error){
      
    });
    return result;
  }
}