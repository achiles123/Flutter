import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/News.dart';
import 'package:flutter_app/Model/Comment.dart';

import '../../GlobalData.dart';

class HomeView extends StatefulWidget{
  Movie _movie;
  News _news;
  Comment _comment;
  List<Movie> _movieHome = null;
  List<News> _newsVoucher = null;
  List<News> _review = null;
  List<News> _newsMore = null;
  List<Comment> _topComment = null;

  HomeView(){
    _movie = new Movie();
    _news = new News();
    _comment = new Comment();
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

  Widget FavoriteMovie(){
    return FutureBuilder(
      future:  widget._movieHome == null?widget._movie.GetMoviePlaying():new Future<List<Movie>>(()=>widget._movieHome),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting && widget._movieHome == null)
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
        else{
          if(snapshot.data != null)
            widget._movieHome = snapshot.data;

          if(widget._movieHome != null){
            List<Widget> result = new List<Widget>();
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
                            Navigator.of(context).pushNamed("/booking",arguments: widget._movieHome[index]);
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

                                      Navigator.of(context).pushNamed("/booking",arguments: widget._movieHome[index]);
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
            return  Column(children: result,);
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
    );// Movie;
  }

  Widget GetNewsVoucher(){
    return SizedBox(
      height: 150,
      child:  StreamBuilder(
        stream: widget._newsVoucher == null?Stream.fromFuture(widget._news.GetPromotion()).asBroadcastStream():Stream.fromFuture(new Future<List<News>>(()=>widget._newsVoucher)).asBroadcastStream(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting && widget._newsVoucher == null)
            return Center();
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
    );
  }

  Future<List<Movie>> WaitMovieFetched() async {
    while(widget._movieHome == null)
      await Future.delayed(Duration(milliseconds: 500));
    return widget._movieHome;
  }


  Widget MovieToday(){
    return Container(
        margin: EdgeInsets.only(left: 7,right: 7,top: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Rạp đang có phim gì?",style: TextStyle(fontSize: 18),),
                Spacer(),
                InkWell(
                  child: Text("Xem tất cả",style: TextStyle(fontSize: 18,color: Colors.orangeAccent),),
                )
              ],
            ),
            FutureBuilder(
              future: WaitMovieFetched(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Container();
                List<Movie> result = snapshot.data;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: result.length > 3?3:result.length,
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.all(0),
                              width: double.infinity,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(image: NetworkImage(result[index].poster_thumb),fit: BoxFit.fill),
                                    ),

                                  ),// Column 1
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(result[index].film_name_vn,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              if(result[index].film_age != 0)
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.red),
                                                  child: Text("C"+result[index].film_age.toString(),style:TextStyle(color: Colors.white),),
                                                )
                                              ,
                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:
                                                Text(result[index].film_duration.toString()+"p - IMDb "+result[index].imdb_point.toString(),style: TextStyle(color: Colors.black26),),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: FractionalOffset.topLeft,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.withOpacity(0.8),

                                            ),
                                            width: MediaQuery.of(context).size.width*0.15,
                                            height: MediaQuery.of(context).size.height*0.06,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(result[index].avg_point_showing.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Icon((result[index].avg_point_all >= 2?Icons.star:(result[index].avg_point_all<=0?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                    Icon((result[index].avg_point_all >= 4?Icons.star:(result[index].avg_point_all<=2?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                    Icon((result[index].avg_point_all >= 6?Icons.star:(result[index].avg_point_all<=4?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                    Icon((result[index].avg_point_all >= 8?Icons.star:(result[index].avg_point_all<=6?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                    Icon((result[index].avg_point_all >= 10?Icons.star:(result[index].avg_point_all<=8?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),// Column 2
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 5),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      color: Colors.redAccent,
                                      child: Text("ĐẶT VÉ",style: TextStyle(color: Colors.white),),
                                      onPressed: (){

                                      },
                                    ),
                                  ), // Column 3
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    )
                  ],
                );
              },
            ),
          ],
        )

    );
  }


  Widget GetReview(){
    return Container(
      margin: EdgeInsets.only(left: 7,right: 7),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FutureBuilder(
        future: widget._review == null?widget._news.GetReview():new Future<List<News>>(()=>widget._review),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting && widget._review == null)
            return Container();
          else{
            if(snapshot.data != null)
              widget._review = snapshot.data;
            if(widget._review != null){
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget._review.length > 3?3:widget._review.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(3, 5),
                                    blurRadius: 5,
                                    spreadRadius: 0
                                )
                              ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                  image: DecorationImage(image: NetworkImage(widget._review[index].img_lhorizontal),fit: BoxFit.fitWidth,alignment: Alignment.topLeft),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:5),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text("REVIEW",style: TextStyle(fontSize: 18),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      child: Text(widget._review[index].news_title,overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(fontSize: 28,fontWeight: FontWeight.w300),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      child: Text(widget._review[index].news_description,overflow: TextOverflow.ellipsis,maxLines: 4,style: TextStyle(fontSize: 16,color: Colors.black38),),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }else{
              return Container();
            }
          }

        },
      ),
    );
  }

  Widget GetNewsMore(){
    return Container(
        margin: EdgeInsets.only(left: 7,right: 7,top: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Lướt thêm tin mới nhé!",style: TextStyle(fontSize: 18),),
                Spacer(),
                InkWell(
                  child: Text("Xem tất cả",style: TextStyle(fontSize: 18,color: Colors.orangeAccent),),
                )
              ],
            ),
            FutureBuilder(
              future: widget._newsMore == null?widget._news.GetNewsMore():new Future<List<News>>(()=>widget._newsMore),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting && widget._newsMore == null)
                  return Container();
                if(snapshot.data != null)
                  widget._newsMore = snapshot.data;
                if(widget._newsMore != null){
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child:  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget._newsMore.length > 5?5:widget._newsMore.length,
                            itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.all(0),
                                width: double.infinity,
                                height: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(image: NetworkImage(widget._newsMore[index].image_small),fit: BoxFit.fill),
                                      ),

                                    ),// Column 1
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10,),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(widget._newsMore[index].type_id == 4?"Khuyễn mãi":"Điện ảnh 24h",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Colors.black38,fontWeight: FontWeight.w400),),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(widget._newsMore[index].news_title,overflow: TextOverflow.clip,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),// Column 2
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),

                  );
                }else{
                  return Container();
                }

              },
            ),
          ],
        )

    );
  }

  Future<List<Comment>> WaitCommentFetched() async {
    while(widget._movieHome == null)
      await Future.delayed(Duration(milliseconds: 500));
    List<int> listId = new List<int>();
    for(int i = 0;i < widget._movieHome.length;i++){
      if(i > 4)
        break;
      listId.add(widget._movieHome[i].film_id);
    }
    return widget._comment.GetTopComment(listId);
  }

  Widget GetTopComment(){
    return Container(
      margin: EdgeInsets.only(left: 7,right: 7),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FutureBuilder(
        initialData: widget._topComment,
        future: widget._topComment == null?WaitCommentFetched():new Future<List<Comment>>(()=>widget._topComment),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting && widget._topComment == null)
            return Container();
          else{
            if(snapshot.data != null)
              widget._topComment = snapshot.data;
            if(widget._topComment != null){
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget._topComment.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(3, 5),
                                    blurRadius: 5,
                                    spreadRadius: 0
                                )
                              ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(widget._topComment[index].movie.film_name_vn,overflow: TextOverflow.clip,maxLines: 1,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon((widget._topComment[index].movie.avg_point>= 2?Icons.star:(widget._topComment[index].movie.avg_point<=0?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                Icon((widget._topComment[index].movie.avg_point >= 4?Icons.star:(widget._topComment[index].movie.avg_point<=2?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                Icon((widget._topComment[index].movie.avg_point >= 6?Icons.star:(widget._topComment[index].movie.avg_point<=4?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                Icon((widget._topComment[index].movie.avg_point >= 8?Icons.star:(widget._topComment[index].movie.avg_point<=6?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                                Icon((widget._topComment[index].movie.avg_point >= 10?Icons.star:(widget._topComment[index].movie.avg_point<=8?Icons.star_border:Icons.star_half)),color: Colors.red,size: 10,),
                                              ],
                                            ),
                                          ],
                                        ),// Movie name
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.25,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(widget._topComment[index].guest_name,maxLines: 1,overflow: TextOverflow.clip,textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                                Text("Vài giây trước",textAlign: TextAlign.right,style: TextStyle(color: Colors.black38,fontSize: 12))

                                              ],
                                            ),
                                          ),

                                          Stack(
                                            children: <Widget>[
                                              Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    image: DecorationImage(image: NetworkImage(widget._topComment[index].avatar),fit: BoxFit.fill)
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  width: 17,
                                                  height: 17,
                                                  foregroundDecoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(image: AssetImage((widget._topComment[index].facebook_id != ""?"assets/image/facebook.png":"assets/image/zalo.png")),fit: BoxFit.fill),
                                                      border: Border.fromBorderSide(BorderSide(color: Colors.white,width: 2))
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),// User status
                                    ],
                                  )
                              ), //Header
                              Container(
                                height: 95,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.network(widget._topComment[index].movie.poster_landscape,fit: BoxFit.fill,width: 75,height: 90,),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(widget._topComment[index].content,maxLines: 6,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w300),),
                                      ),
                                    ),

                                  ],
                                ),
                              ),// Body
                              Container(
                                width: 70,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.thumb_up,size: 15,color: Colors.blueAccent,),
                                    Text(widget._topComment[index].up_vote.toString(),style: TextStyle(fontWeight: FontWeight.w300),),
                                    Text("Thích",style: TextStyle(fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }else{
              return Container();
            }
          }

        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          widget._movieHome = null;
          widget._newsVoucher = null;
          widget._review = null;
          widget._newsMore = null;
          widget._topComment = null;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: Color(0xffebebeb),),
          Container(
            height: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                GetNewsVoucher(),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 7),
                  alignment: Alignment.centerLeft,
                  child: Text("Phim được yêu thích nhất",style: TextStyle(fontSize: 18),),
                ),
                FavoriteMovie(),
                MovieToday(),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 7),
                  alignment: Alignment.centerLeft,
                  child: Text("Tin nóng nhất hôm nay",style: TextStyle(fontSize: 18),),
                ),
                GetReview(),
                GetNewsMore(),
                Container(
                  margin: EdgeInsets.only(top: 15,left: 7,right: 7),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Cộng đồng bình luận phim",style: TextStyle(fontSize: 18),),
                      Spacer(),
                      InkWell(
                        child: Text("Xem tất cả",style: TextStyle(fontSize: 18,color: Colors.orangeAccent),),
                      ),
                    ],
                  ),
                ),
                GetTopComment()
              ],
            ),
          ),

        ],
      ),

    );
  }
}