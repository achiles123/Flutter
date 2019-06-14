
class MovieInformation{
  final double avg_point;
  final int avg_point_all;
  final int avg_point_showing;
  final int film_age;
  final String film_category;
  final String film_country;
  final String film_description_mobile;
  final String film_description_web_short;
  final String film_director;
  final int film_duration;
  final String film_id;
  final String film_name;
  final String film_name_en;
  final String film_name_vn;
  final String film_url;
  final String film_version;
  final int has_session;
  final double imdb_point;
  final int is_favorite;
  final int is_watched;
  final String layout_style;
  final List<Map<String,dynamic>> list_actor;
  final List<Map<String,dynamic>> list_image_thumbnail;
  final List<Map<String,dynamic>> list_image_view;
  final List<Map<String,dynamic>> list_news;
  final List<Map<String,dynamic>> list_trailer;
  final String media_id;
  final String meta_keyword;
  final String pg_rating;
  final String poster;
  final String poster_landscape;
  final String poster_landscape_mobile;
  final String publish_date;
  final String showing_date;
  final int status_id;
  final int total_comment;
  final int total_rating;
  final int up_vote;

  MovieInformation({this.avg_point, this.avg_point_all, this.avg_point_showing, this.film_age, this.film_category, this.film_country, this.film_description_mobile,
    this.film_description_web_short, this.film_director, this.film_duration, this.film_id, this.film_name, this.film_name_en, this.film_name_vn, this.film_url,
    this.film_version, this.has_session, this.imdb_point, this.is_favorite, this.is_watched, this.layout_style, this.list_actor, this.list_image_thumbnail,
    this.list_image_view, this.list_news, this.list_trailer, this.media_id, this.meta_keyword, this.pg_rating, this.poster, this.poster_landscape,
    this.poster_landscape_mobile, this.publish_date, this.showing_date, this.status_id, this.total_comment, this.total_rating, this.up_vote,});

  factory MovieInformation.parseJson(Map<String,dynamic> json){
    List<dynamic> actorList = json["list_actor"];
    List<dynamic> thumbnailList = json["list_image_thumbnail"];
    List<dynamic> imageList = json["list_image_view"];
    List<dynamic> newsList = json["list_news"];
    List<dynamic> trailerList = json["list_trailer"];

    return MovieInformation(
      avg_point: json["avg_point"],
      avg_point_all: json["avg_point_all"],
      avg_point_showing: json["avg_point_showing"],
      film_age: json["film_age"],
      film_category: json["film_category"],
      film_country: json["film_country"],
      film_description_mobile: json["film_description_mobile"],
      film_description_web_short: json["film_description_web_short"],
      film_director: json["film_director"],
      film_duration: json["film_duration"],
      film_id: json["film_id"],
      film_name: json["film_name"],
      film_name_en: json["film_name_en"],
      film_name_vn: json["film_name_vn"],
      film_url: json["film_url"],
      film_version: json["film_version"],
      has_session: json["has_session"],
      imdb_point: double.parse(json["imdb_point"].toString()),
      is_favorite: json["is_favorite"],
      is_watched: json["is_watched"],
      layout_style: json["layout_style"],
      list_actor: actorList.map((f)=> Map<String,dynamic>.from(f)).toList(),
      list_image_thumbnail: thumbnailList.map((f)=> Map<String,dynamic>.from(f)).toList(),
      list_image_view: imageList.map((f)=> Map<String,dynamic>.from(f)).toList(),
      list_news: newsList.map((f)=> Map<String,dynamic>.from(f)).toList(),
      list_trailer: trailerList.map((f)=> Map<String,dynamic>.from(f)).toList(),
      media_id: json["media_id"],
      meta_keyword: json["meta_keyword"],
      pg_rating: json["pg_rating"],
      poster: json["poster"],
      poster_landscape: json["poster_landscape"],
      poster_landscape_mobile: json["poster_landscape_mobile"],
      publish_date: json["publish_date"],
      showing_date: json["showing_date"],
      status_id: json["status_id"],
      total_comment: json["total_comment"],
      total_rating: json["total_rating"],
      up_vote: json["up_vote"],
    );
  }
}