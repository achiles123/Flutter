import 'dart:io';
import 'dart:convert';
import 'dart:convert' show utf8 ;
import 'package:http/http.dart' as http;

class TicketPrice{
  String session_id;
  String session_link;
  String session_status;
  String session_time;
  String cinema_id;
  int is_vip_layout;
  String room_id;
  String room_title;
  int area_id;
  String area_name;
  String area_name_en;
  String description;
  String type_code;
  String type_description;
  String type_description_en;
  String type_long_desc;
  String type_long_desc_en;
  int type_max;
  String version;
  String type_version;
  int type_price;



  TicketPrice({this.session_id,this.cinema_id,this.session_link,this.session_status,this.session_time,this.is_vip_layout,this.room_id,this.room_title,
    this.area_id,this.area_name,this.area_name_en,this.description,this.type_code,this.type_description,this.type_description_en,this.type_long_desc,
    this.type_long_desc_en,this.type_max,this.version,this.type_price});

  factory TicketPrice.partseJson(Map<String,dynamic> json){
    return TicketPrice(
      session_id: json["cinema_address"],
      cinema_id: json["cinema_id"],
      session_status: json["cinema_image"],
      session_time: json["cinema_latitude"],
      session_link: json["cinema_longitude"],
      is_vip_layout: json["cinema_name"],
      room_id: json["cinema_name_s1"],
      room_title: json["cinema_name_s2"],
      area_id: json["cinema_slug"],
      area_name: json["cinema_slug"],
      area_name_en: json["cinema_slug"],
      description: json["cinema_slug"],
      type_code: json["cinema_slug"],
      type_description: json["cinema_slug"],
      type_description_en: json["cinema_slug"],
      type_long_desc: json["cinema_slug"],
      type_long_desc_en: json["cinema_slug"],
      type_max: json["cinema_slug"],
      version: json["version"],
      type_price: json["cinema_slug"],

    );
  }

  static Future<List<TicketPrice>> GetPrice(String sessionId,String sessionCode,String name,String cinemaCode) async {
    List<TicketPrice> result = new List<TicketPrice>();
    Stopwatch sw = new Stopwatch();
    sw.start();
    final String url = 'https://123phim.vn/apitomapp';
    var httpClient = new HttpClient();
    try {
      // Make the call
      var requestBody = '{"param":{"url":"/checkout/'+name+'/ticket?session_id='+sessionId+'&session_code='+sessionCode+'&cinema_code='+cinemaCode+'","keyCache":"no-cache"},"method":"GET"}';
      var request = await httpClient.postUrl(Uri.parse(url));
      request.headers.contentType = new ContentType("application", "json",charset: "UTF-8");
      request.contentLength = requestBody.length;
      request.write(requestBody);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var rp = await response.transform(utf8.decoder).join();
        if(rp == null)
          result;
        Map<String,dynamic> rs = json.decode(rp)["result"];
        String cinemaId = rs["cinema_id"];
        int isVipLayout = rs["is_vip_layout"];
        List<dynamic> listType = rs["list_type"];
        String roomId = rs["room_id"];
        String roomTitle = rs["room_title"];
        listType.forEach((f){
          Map<String,dynamic> member = f;
          TicketPrice item = new TicketPrice();
          item.cinema_id = cinemaId;
          item.is_vip_layout = isVipLayout;
          item.room_id = roomId;
          item.room_title = roomTitle;
          item.area_id = member["area_id"];
          item.area_name = member["area_name"];
          item.area_name_en = member["area_name_en"];
          item.description = member["description"];
          item.type_code = member["type_code"];
          item.type_description = member["type_description"];
          item.type_description_en = member["type_desription_en"];
          item.type_long_desc = member["type_long_desc"];
          item.type_long_desc_en = member["type_long_desc_en"];
          item.type_max = member["type_max"];
          item.type_price = member["type_price"];
          result.add(item);
        });
        sw.stop();
        print(sw.elapsed.toString()+ " .Session id:$sessionId. Cinema code:$cinemaCode");
      } else {
        //print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
    }
    return result;
    var data = await http.post(
      "https://123phim.vn/apitomapp",
      headers: {"Content-Type": "application/json;charset=UTF-8"},
      body: '{"param":{"url":"/checkout/'+name+'/ticket?session_id='+sessionId+'&session_code='+sessionCode+'&cinema_code='+cinemaCode+'","keyCache":"no-cache"},"method":"GET"}'

    ).then((response){
      if(response.statusCode == 200){
        Map<String,dynamic> rs = json.decode(response.body)["result"];
        if(rs == null)
          return;
        String cinemaId = rs["cinema_id"];
        int isVipLayout = rs["is_vip_layout"];
        List<dynamic> listType = rs["list_type"];
        String roomId = rs["room_id"];
        String roomTitle = rs["room_title"];
        for(dynamic f in listType){
          Map<String,dynamic> member = f;
          TicketPrice item = new TicketPrice();
          item.cinema_id = cinemaId;
          item.is_vip_layout = isVipLayout;
          item.room_id = roomId;
          item.room_title = roomTitle;
          item.area_id = member["area_id"];
          item.area_name = member["area_name"];
          item.area_name_en = member["area_name_en"];
          item.description = member["description"];
          item.type_code = member["type_code"];
          item.type_description = member["type_description"];
          item.type_description_en = member["type_desription_en"];
          item.type_long_desc = member["type_long_desc"];
          item.type_long_desc_en = member["type_long_desc_en"];
          item.type_max = member["type_max"];
          item.type_price = member["type_price"];
          result.add(item);
        }
        sw.stop();
        print(sw.elapsed.toString()+ " .Session id:$sessionId. Cinema code:$cinemaCode");
      }
    }).catchError((error){

    });
    return result;
  }

  static Future<List<TicketPrice>> GetPriceRoom(String sessionId) async {
    List<TicketPrice> result = new List<TicketPrice>();
    var data = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: '{"param":{"url":"/checkout/price","keyCache":"no-cache"},"data":{"list_seat":["A01"],"session_id":"'+sessionId+'"},"method":"POST"}'

    ).then((response){
      if(response.statusCode == 200){
        Map<String,dynamic> rs = json.decode(response.body)["result"];
        if(rs == null)
          return;
        TicketPrice item = new TicketPrice();
        item.is_vip_layout = 0;
        item.area_id = 2;
        item.type_price = rs["price_after"];
        result.add(item);
      }
    }).catchError((error){

    });
    return result;
  }
}