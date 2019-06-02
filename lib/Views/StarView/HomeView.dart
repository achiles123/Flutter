import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/News.dart';

class HomeView extends StatefulWidget{
  Movie _movie;
  News _news;
  List<Movie> _movieHome = null;
  List<News> _newsVoucher = null;

  HomeView(){
    _movie = new Movie();
    _news = new News();
  }

  @override
  HomeViewState createState() {
    // TODO: implement createState
    return new HomeViewState();
  }
}

class HomeViewState extends State<HomeView>{
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    widget._movie = new Movie();
    _pageController = PageController(viewportFraction: 0.8);
  }

  Widget GetMovieHome(){
    List<Widget> result = new List<Widget>();
    if(widget._movieHome != null){
      for(int index =0;index<widget._movieHome.length;index++){
        if(index > 2)
          break;
        Widget item = Container(
            height: MediaQuery.of(context).size.width*1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(1, 3),
                    blurRadius: 2,
                    spreadRadius: -1,

                  ),
                ]
            ),
            margin: EdgeInsets.only(bottom:7,left: 7,right: 7),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              elevation: 1,
              child:Stack(
                children: <Widget>[
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget._movieHome[index].poster_url),fit: BoxFit.fill),
                      ),

                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.center,
                            colors: [
                              Color(0xff000000),
                              Colors.black.withOpacity(0.0)
                            ]
                        ),
                        //color: Colors.transparent
                      ),
                    ),
                  ),// Linear gradient
                  Positioned(
                    bottom:0,
                    left: 10,
                    child: Container(
                      alignment: FractionalOffset.topLeft,
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.14,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("ĐANG CHIẾU",style: TextStyle(color: Colors.white,fontSize: 15,),),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child:  Text(widget._movieHome[index].film_name_vn,
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 24),overflow: TextOverflow.clip,softWrap: false,)

                          ),
                        ],
                      ),
                    ),
                  ),// Movie name
                  Positioned(
                    bottom:0,
                    right: 10,
                    child: Container(
                      alignment: FractionalOffset.topRight,
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.12,
                      child: Column(
                        children: <Widget>[
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minWidth: 60,
                            child: RaisedButton(
                              child: Text("ĐẶT VÉ",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),),
                              color: Colors.deepOrange,
                              onPressed: (){

                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),// Book button
                  Positioned(
                    top:10,
                    right: 10,
                    child: Container(
                      alignment: FractionalOffset.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.7),

                      ),
                      width: MediaQuery.of(context).size.width*0.18,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget._movieHome[index].avg_point_showing.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon((widget._movieHome[index].avg_point_all >= 2?Icons.star:(widget._movieHome[index].avg_point_all<=0?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                              Icon((widget._movieHome[index].avg_point_all >= 4?Icons.star:(widget._movieHome[index].avg_point_all<=2?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                              Icon((widget._movieHome[index].avg_point_all >= 6?Icons.star:(widget._movieHome[index].avg_point_all<=4?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                              Icon((widget._movieHome[index].avg_point_all >= 8?Icons.star:(widget._movieHome[index].avg_point_all<=6?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                              Icon((widget._movieHome[index].avg_point_all >= 10?Icons.star:(widget._movieHome[index].avg_point_all<=8?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),// Rating score
                  if(widget._movieHome[index].film_age != 0)
                    Positioned(
                      top:10,
                      left: 10,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.08,
                        height: MediaQuery.of(context).size.height*0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("C"+widget._movieHome[index].film_age.toString(),style: TextStyle(color: Colors.white,fontSize: 12),)

                          ],
                        ),
                      ),
                    ),// Age warning

                ],
              ),
            )
        );
        result.add(item);
      }
    }
    return Column(children: result,);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          widget._movieHome = null;
          widget._newsVoucher = null;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: Color(0xfff2f2f2),),
          Container(
            height: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child:  StreamBuilder(
                    stream: widget._newsVoucher == null?Stream.fromFuture(widget._news.GetVoucher()).asBroadcastStream():Stream.fromFuture(new Future<List<News>>(()=>widget._newsVoucher)).asBroadcastStream(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting && widget._newsVoucher == null)
                        return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
                      else{
                        if(snapshot.data != null)
                          widget._newsVoucher = snapshot.data;
                        if(widget._newsVoucher != null){
                          return PageView.builder(
                              controller: _pageController,
                              itemCount: widget._newsVoucher.length,
                              itemBuilder: (context,index){
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 0),
                                  curve: Curves.easeOutBack,
                                  margin: EdgeInsets.only( bottom: 5,top: 5,right: 10,left: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(1, 5),
                                            color: Colors.black.withOpacity(0.5)
                                        )
                                      ],
                                      image: DecorationImage(image: NetworkImage(widget._newsVoucher[index].image_full),fit: BoxFit.fill)
                                  ),
                                  child: InkWell(
                                    onTap: (){},
                                  ),
                                );
                              }
                          );
                        }else{
                          return Container();
                        }
                      }
                    },
                  ),// News voucher,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,left: 7),
                  alignment: Alignment.centerLeft,
                  child: Text("Phim được yêu thích nhất",style: TextStyle(fontSize: 18),),
                ),
                FutureBuilder(
                  future:  widget._movieHome == null?widget._movie.GetMoviePlaying():new Future<List<Movie>>(()=>widget._movieHome),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting && widget._movieHome == null)
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
                    else{
                      if(snapshot.data != null)
                        widget._movieHome = snapshot.data;

                      if(widget._movieHome != null){
                        return  GetMovieHome();
                      }
                      else{
                        return Center(
                          child: RaisedButton(
                              child: Text("Tải lại"),
                              onPressed: (){
                                setState(() {

                                });
                              }
                          ),
                        );
                      }

                    }

                  },
                ),// Movie

              ],
            ),
          ),

        ],
      ),





    );
  }
}