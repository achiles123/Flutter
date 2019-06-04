import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Movie.dart';
class Comment{
  final String avatar;
  final int comment_id;
  final String content;
  final String date_add;
  final String date_update;
  final String facebook_id;
  final int film_id;
  final String fullname;
  final String guest_email;
  final String guest_name;
  final String is_admin;
  final int is_buy_ticket;
  final List<dynamic> list_image;
  final String rate;
  final int total_chilren_comment;
  final int up_vote;
  final int user_id;
  final int user_like;
  final String username;
  final int vote;
  final String zalo_id;
  Movie movie;

  Comment({this.avatar,this.comment_id,this.content,this.date_add,this.date_update,this.facebook_id,this.film_id,this.fullname,this.guest_email,this.guest_name,this.is_admin,this.is_buy_ticket,this.list_image,this.rate,this.total_chilren_comment,this.up_vote,this.user_id,this.user_like,this.username,this.vote,this.zalo_id});

  factory Comment.parseJson(Map<String,dynamic> json){
    return Comment(
      avatar: json["avatar"],
      comment_id: json["comment_id"],
      content: json["content"],
      date_add: json["date_add"],
      date_update: json["date_update"],
      facebook_id: json["facebook_id"],
      film_id: json["film_id"],
      fullname: json["fullname"],
      guest_email: json["guest_email"],
      guest_name: json["guest_name"],
      is_admin: json["is_admin"],
      is_buy_ticket: json["is_buy_ticket"],
      list_image: json["list_image"],
      rate: json["rate"],
      total_chilren_comment: json["total_chilren_comment"],
      up_vote: json["up_vote"],
      user_id: json["user_id"],
      user_like: json["user_like"],
      username: json["username"],
      vote: json["vote"],
      zalo_id: json["zalo_id"],
    );
  }

  Future SetMovie()async{
    await Movie.GetById(this.film_id).then((value){
      this.movie = value;
    });
  }

  Future<List<Comment>> GetByMovie(int movieId,{int count=1000}) async {
    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/film/comment?film_id=$movieId&offset=0&count=$count","keyCache":"no-cache"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"]["comments"];
        return originData.map((x)=>Comment.parseJson(x)).toList();
      }
    }).catchError((error){

    });
    return result;
  }

  Future<List<Comment>> GetTopComment(List<int> listMovie) async{
    List<Comment> result = new List<Comment>();
    for(int movieId in listMovie){
      result = await GetByMovie(movieId,count: 10).then((items) {
        items.sort((item1,item2) => int.parse(item1.rate)<int.parse(item2.rate)?1:-1);
        if(items.length != 0){
          result.add(items[0]);
        }

        return result;
      });

      await result[result.length-1].SetMovie();
    }
    return result;
  }
}