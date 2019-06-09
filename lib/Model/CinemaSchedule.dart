import 'dart:convert';

import 'package:http/http.dart' as http;
import '../GlobalData.dart';
import 'CInemaAddress.dart';

class CinemaSchedule{
  final List<CinemaAddress> cinemas;
  final String date;
  final String p_cinema_id;
  final String p_cinema_logo;
  final String p_cinema_logo_square;
  final String p_cinema_name;

  CinemaSchedule({this.cinemas,this.date,this.p_cinema_id,this.p_cinema_logo,this.p_cinema_logo_square,this.p_cinema_name});

  factory CinemaSchedule.parseJson(Map<String,dynamic> json){
    Map<String,dynamic> cinemas = json["cinemas"];
    return CinemaSchedule(
        cinemas: cinemas.values.map((x) => CinemaAddress.partseJson(x)).toList(),
        date: json["date"],
        p_cinema_id: json["p_cinema_id"],
        p_cinema_logo: json["p_cinema_logo"],
        p_cinema_logo_square: json["p_cinema_logo_square"],
        p_cinema_name: json["p_cinema_name"],
    );
  }
  
  Future<List<CinemaSchedule>> GetSchedule({int filmId,String startDate,String endDate}) async {
    List<CinemaSchedule> result = new List<CinemaSchedule>();
    await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type":"application/json;charset=UTF-8"},
        body: '{"param":{"url":"/session/film?cinema_id=-1&film_id='+filmId.toString()+'&start_date='+startDate+'&end_date='+endDate+'&location_id='+(GlobalData.locationId+1).toString()+'","keyCache":"no-cache"},"method":"GET"}'
    ).then((response){
      if(response.statusCode == 200){
        List<dynamic> originData = json.decode(response.body)["result"];
        for(Map<String,dynamic> item in originData){
          result.addAll(item.values.map((f)=> CinemaSchedule.parseJson(f)).toList());
        }
      }

    }).catchError((error){

    });
    return result;
  }

  Future<Map<String,List<CinemaSchedule>>> GetScheduleByGroup({int filmId,String startDate,String endDate}) async {
    List<CinemaSchedule> data = await GetSchedule(filmId: filmId,startDate: startDate,endDate: endDate);
    Map<String,List<CinemaSchedule>> result = new Map<String,List<CinemaSchedule>>();
    GlobalData.parentCinema.forEach((item){
      result.addAll({
        item.id:data.where((x)=> x.p_cinema_id==item.id).toList()
      });
    });
    return result;
  }
}