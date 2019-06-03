import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie{
  final double avg_point;
  final double avg_point_all;
  final double avg_point_showing;
  final String count_comment;
  final String count_like;
  final String count_share;
  final int film_age;
  final double film_duration;
  final int film_id;
  final String film_language;
  final String film_name;
  final String film_name_en;
  final String film_name_vn;
  final String film_slug;
  final String film_slug_new;
  final String film_url;
  final String film_version;
  final double has_session;
  final double imdb_point;
  final double is_new;
  final String media_id;
  final String pg_rating;
  final String poster_landscape;
  final String poster_landscape_mobile;
  final String poster_thumb;
  final String poster_url;
  final String publish_date;
  final String showing_date;
  final double status_id;
  final double total_rating;
  final double type_id;

  Movie({
    this.avg_point,this.avg_point_all,this.avg_point_showing,this.count_comment,this.count_like,this.count_share,this.film_age,this.film_duration,this.film_id,
    this.film_language,this.film_name,this.film_name_en,this.film_name_vn,this.film_slug,this.film_slug_new,this.film_url,this.film_version,this.has_session,
    this.imdb_point,this.is_new,this.media_id,this.pg_rating,this.poster_landscape,this.poster_landscape_mobile,this.poster_thumb,this.poster_url,this.publish_date,
    this.showing_date,this.status_id,this.total_rating,this.type_id
  });

  factory Movie.parseJson(Map<String,dynamic> json)  {
   return Movie(
      avg_point: double.parse(json["avg_point"].toString()),
      avg_point_all: double.parse(json["avg_point_all"].toString()),
      avg_point_showing: double.parse(json["avg_point_showing"].toString()),
      count_comment: json["count_comment"],
      count_like: json["count_like"],
      count_share: json["count_share"],
      film_age: int.parse(json["film_age"].toString()),
      film_duration: double.parse(json["film_duration"].toString()),
      film_id: int.parse(json["film_id"].toString()),
      film_language: json["film_language"],
      film_name: json["film_name"],
      film_name_en: json["film_name_en"],
      film_name_vn: json["film_name_vn"],
      film_slug: json["film_slug"],
      film_slug_new: json["film_slug_new"],
      film_url: json["film_url"],
      film_version: json["film_version"],
      has_session: double.parse(json["has_session"].toString()),
      imdb_point: double.parse(json["imdb_point"].toString()),
      is_new: double.parse(json["is_new"].toString()),
      media_id: json["media_id"],
      pg_rating: json["pg_rating"],
      poster_landscape: json["poster_landscape"],
      poster_landscape_mobile: json["poster_landscape_mobile"],
      poster_thumb: json["poster_thumb"],
      poster_url: json["poster_url"],
      publish_date: json["publish_date"],
      showing_date: json["showing_date"],
      status_id: double.parse(json["status_id"].toString()),
      total_rating: double.parse(json["total_rating"].toString()),
      type_id: double.parse(json["type_id"].toString()),
    );
  }

  static Future<Movie> GetById(int movieId) async {
    var result = await http.post(
      "https://123phim.vn/apitomapp",
      headers: {"Content-Type": "application/json"},
      body: '{"param":{"url":"/film/detail?film_id='+movieId.toString()+'","keyCache":"movie-detail'+movieId.toString()+'"},"method":"GET"}'
    ).then((response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];
        return originData.map((x) => Movie.parseJson(x));
      }
    });
  }

  Future<List<Movie>> GetMoviePlaying()  async {
    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/film/list?status=2","keyCache":"showing-film"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];

        return originData.map((x)=>Movie.parseJson(x)).toList();
      }
    });
    return result;
  }

  Future<List<Movie>> GetMovieComing()  async {

    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/film/list?status=1","keyCache":"main-films-coming"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];

        return originData.map((x)=>Movie.parseJson(x)).toList();
      }
    });
    return result;
  }

}
