import 'dart:convert';
import 'package:http/http.dart' as http;

class News{
  final String date_add;
  final int down_vote;
  final String image;
  final String image2x;
  final String image_full;
  final String image_small;
  final String img_lhorizontal;
  final String img_shorizontal;
  final String news_description;
  final int news_id;
  final String news_slug;
  final String news_slug_new;
  final String news_title;
  final int source_id;
  final int total_comment;
  final int up_vote;
  final String url;
  final int user_like;
  final int type_id;

  News({this.date_add,this.down_vote,this.image,this.image2x,this.image_full,this.image_small,this.img_lhorizontal,this.img_shorizontal,this.news_description,this.news_id,this.news_slug,this.news_slug_new,this.news_title,this.source_id,this.total_comment,this.up_vote,this.url,this.user_like,this.type_id});

  factory News.parseJson(Map<String,dynamic> json,int type_id){
    return News(
      date_add: json["date_add"],
      down_vote: json["down_vote"],
      image: json["image"],
      image2x: json["image2x"],
      image_full: json["image_full"],
      image_small: json["image_small"],
      img_lhorizontal: json["img_lhorizontal"],
      img_shorizontal: json["img_shorizontal"],
      news_description: json["news_description"],
      news_id: json["news_id"],
      news_slug: json["news_slug"],
      news_slug_new: json["news_slug_new"],
      news_title: json["news_title"],
      source_id: json["source_id"],
      total_comment: json["total_comment"],
      up_vote: json["up_vote"],
      url: json["url"],
      user_like: json["user_like"],
      type_id: type_id,
    );
  }

  Future<List<News>> GetPromotion()  async {
    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/news/list?type_id=4&offset=0&count=8&is_hot=-1&p_cinema_id=0","keyCache":"news?type_id=4&offset=0&count=8&is_hot=-1&p_cinema_id=0"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];
        return originData.map((x)=>News.parseJson(x,4)).toList();
      }
    });
    return result;
  }

  Future<List<News>> GetReview()  async {
    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/news/list?type_id=8&offset=0&count=8&is_hot=-1&p_cinema_id=0","keyCache":"news?type_id=8&offset=0&count=8&is_hot=-1&p_cinema_id=0"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];
        return originData.map((x)=>News.parseJson(x,8)).toList();
      }
    });
    return result;
  }

  Future<List<News>> GetNewsMore() async{
    var rsPromotion = await GetPromotion();
    var result = await http.post(
        "https://123phim.vn/apitomapp",
        headers: {"Content-Type": "application/json"},
        body:'{"param":{"url":"/news/list?type_id=1&offset=0&count=8&is_hot=-1&p_cinema_id=0","keyCache":"news?type_id=1&offset=0&count=8&is_hot=-1&p_cinema_id=0"},"method":"GET"}'
    ).then((http.Response response){
      if(response.statusCode == 200){
        Iterable originData = json.decode(response.body)["result"];
        return originData.map((x)=>News.parseJson(x,1)).toList();
      }
    });
    if(rsPromotion.length != 0)
      result.insert(0, rsPromotion[0]);
    return result;
  }


}