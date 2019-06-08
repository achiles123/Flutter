
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

  CinemaAddress({this.cinema_address,this.cinema_id,this.cinema_image,this.cinema_latitude,this.cinema_longitude,this.cinema_name,this.cinema_name_s1,this.cinema_name_s2,this.cinema_slug});

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
    );
  }
}