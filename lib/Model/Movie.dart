
class Movie{
  final int avg_point;
  final int avg_point_all;
  final int avg_point_showing;
  final String count_comment;
  final String count_like;
  final String count_share;
  final int film_age;
  final int film_duration;
  final int film_id;
  final String film_language;
  final String film_name;
  final String film_name_en;
  final String film_name_vn;
  final String film_slug;
  final String film_slug_new;
  final String film_url;
  final String film_version;
  final int has_session;
  final int imdb_point;
  final int is_new;
  final String media_id;
  final String pg_rating;
  final String poster_landscape;
  final String poster_landscape_mobile;
  final String poster_thumb;
  final String poster_url;
  final String publish_date;
  final String showing_date;
  final int status_id;
  final int total_rating;
  final int type_id;

  Movie({
    this.avg_point,this.avg_point_all,this.avg_point_showing,this.count_comment,this.count_like,this.count_share,this.film_age,this.film_duration,this.film_id,
    this.film_language,this.film_name,this.film_name_en,this.film_name_vn,this.film_slug,this.film_slug_new,this.film_url,this.film_version,this.has_session,
    this.imdb_point,this.is_new,this.media_id,this.pg_rating,this.poster_landscape,this.poster_landscape_mobile,this.poster_thumb,this.poster_url,this.publish_date,
    this.showing_date,this.status_id,this.total_rating,this.type_id
  });

  factory Movie.parseJson(Map<String,dynamic> json){
    return Movie(
      avg_point: json["avg_point"],
      avg_point_all: json["avg_point_all"],
      avg_point_showing: json["avg_point_showing"],
      count_comment: json["count_comment"],
      count_like: json["count_like"],
      count_share: json["count_share"],
      film_age: json["film_age"],
      film_duration: json["film_duration"],
      film_id: json["film_id"],
      film_language: json["film_language"],
      film_name: json["film_name"],
      film_name_en: json["film_name_en"],
      film_name_vn: json["film_name_vn"],
      film_slug: json["film_slug"],
      film_slug_new: json["film_slug_new"],
      film_url: json["film_url"],
      film_version: json["film_version"],
      has_session: json["has_session"],
      imdb_point: json["imdb_point"],
      is_new: json["is_new"],
      media_id: json["media_id"],
      pg_rating: json["pg_rating"],
      poster_landscape: json["poster_landscape"],
      poster_landscape_mobile: json["poster_landscape_mobile"],
      poster_thumb: json["poster_thumb"],
      poster_url: json["poster_url"],
      publish_date: json["publish_date"],
      showing_date: json["showing_date"],
      status_id: json["status_id"],
      total_rating: json["total_rating"],
      type_id: json["type_id"],
    );
  }

}