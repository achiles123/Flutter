
class MovieVersion{
  final String session_id;
  final String session_link;
  final String session_status;
  final String session_time;
  final String cinema_id;
  final int is_vip_layout;
  final String room_id;
  final String room_title;
  final int area_id;
  final String area_name;
  final String area_name_en;
  final String description;
  final String type_code;
  final String type_description;
  final String type_description_en;
  final String type_long_desc;
  final String type_long_desc_en;
  final int type_max;
  final int type_price;


  MovieVersion({this.session_id,this.cinema_id,this.session_link,this.session_status,this.session_time,this.is_vip_layout,this.room_id,this.room_title,
    this.area_id,this.area_name,this.area_name_en,this.description,this.type_code,this.type_description,this.type_description_en,this.type_long_desc,
    this.type_long_desc_en,this.type_max,this.type_price});

  factory MovieVersion.partseJson(Map<String,dynamic> json){
    return MovieVersion(
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
      type_price: json["cinema_slug"],

    );
  }
}