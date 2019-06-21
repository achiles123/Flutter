import 'dart:convert';

import 'package:http/http.dart' as http;
class Combo{
  final String item_code;
  final String item_desc;
  final String item_id;
  final String item_img;
  final String item_img_thumb;
  final String item_name;
  final String item_price;
  final String item_profit;

  Combo({this.item_code,this.item_desc,this.item_id,this.item_img,this.item_img_thumb,this.item_name,this.item_price,this.item_profit});

  factory Combo.parseJson(Map<String,dynamic> json){
    return Combo(
      item_code: json["item_code"],
      item_desc: json["item_desc"],
      item_id: json["item_id"],
      item_img: json["item_img"],
      item_img_thumb: json["item_img_thumb"],
      item_name: json["item_name"],
      item_price: json["item_price"],
      item_profit: json["item_profit"],
    );
  }

  static Future<List<Combo>> GetByCinema(String cinemaFetchName,String cinemaId) async {
    List<Combo> result = new List<Combo>();
    await http.post(
      "https://123phim.vn/apitomapp",
      headers: {'Content-Type':'application/json;charset=UTF-8'},
      body: '{"param":{"url":"/checkout/$cinemaFetchName/concession?cinema_id=$cinemaId","keyCache":"no-cache"},"method":"GET"}'
    ).then((response){
      if(response.statusCode == 200){
        List<dynamic> rs = json.decode(response.body)["result"];
        if(rs.length != 0){
          rs = rs[0]["items"];
          result = rs.map((f)=> Combo.parseJson(f)).toList();
        }

      }
    }).then((error){

    });
    return result;
  }

}