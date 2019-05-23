import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MenuFour extends StatefulWidget{
  @override
  MenuFourState createState()=> new MenuFourState();
}

class MenuFourState extends State<MenuFour>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBody();
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> _refreshKey.currentState.show());
  }

  GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey<RefreshIndicatorState>();

  Widget GetBody() {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _refreshLocalGallery,
      child: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<Post>(
              future: fetchPost(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                return Text(snapshot.data.body);
              },
            ),
            RaisedButton(
              child: Center(child: Icon(Icons.refresh),),

              onPressed: (){
                _refreshKey.currentState.show(atTop: false);
              },
            )
          ],
        )
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async{
    setState(() {
      userId = (1+(new Random()).nextInt(10)).toString();
    });

  }

  String userId = (1+(new Random()).nextInt(10)).toString();
  Future<Post> fetchPost() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/posts/'+userId);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class Post{
  final int userId;
  final int id;
  final String title;
  final String body;
  Post({int this.userId,int this.id,String this.title,String this.body});
  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"]
    );
  }

}