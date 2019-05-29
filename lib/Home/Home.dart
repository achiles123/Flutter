import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../PopupHepler.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState()=> new HomeState();
}

class HomeState extends State<Home>{
  TextEditingController _txtSearch;
  PopupHelper _popup;
  User _user;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  int _bottomIndex;
  int _starIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtSearch = new TextEditingController();
    _popup = new PopupHelper(context);
    _user = new User(context);
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _refreshKey = new GlobalKey<RefreshIndicatorState>();
    _bottomIndex = 0;
  }

  Future<Null> _refreshState() async{
    setState(() {
      _bottomIndex = _bottomIndex;

    });

  }

  StarBody()  {
    switch(_starIndex){
      case 0:
        Movie movie = new Movie();
        return FutureBuilder(
          future:  movie.GetMoviePlaying(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
            else{

              if(snapshot.data != null){
                List<Movie> data = snapshot.data;
                return ListView.builder(
                    itemCount: data.length>3?3:data.length,
                    itemBuilder: (context,index){
                      return Container(
                          height: MediaQuery.of(context).size.width*1.1,
                          width: MediaQuery.of(context).size.width*0.8,
                          margin: EdgeInsets.all(7),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.antiAlias,
                            borderOnForeground: true,
                            elevation: 1,
                            child:Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(data[index].poster_url),fit: BoxFit.fill),
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
                                          child:  Text(data[index].film_name_vn,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 24),overflow: TextOverflow.clip,)

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
                                      color: Colors.grey.withOpacity(0.5),

                                    ),
                                    width: MediaQuery.of(context).size.width*0.18,
                                    height: MediaQuery.of(context).size.height*0.07,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(data[index].avg_point_showing.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon((data[index].avg_point_all >= 2?Icons.star:Icons.star_half),color: Colors.red,size: 12,),
                                            Icon((data[index].avg_point_all >= 4?Icons.star:Icons.star_half),color: Colors.red,size: 12,),
                                            Icon((data[index].avg_point_all >= 6?Icons.star:Icons.star_half),color: Colors.red,size: 12,),
                                            Icon((data[index].avg_point_all >= 8?Icons.star:Icons.star_half),color: Colors.red,size: 12,),
                                            Icon((data[index].avg_point_all >= 10?Icons.star:Icons.star_half),color: Colors.red,size: 12,),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),// Rating score
                              ],
                            ),
                          )
                      );
                    });
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
        );

    }
  }

  BodyData() {
    switch(_bottomIndex){
      case 0:_starIndex = 0; return StarBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => FirebaseAuth.instance.currentUser() == null?true:false,
        child:DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                leading: Container(),
                bottom: TabBar(
                  labelColor: Colors.deepOrangeAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(text: "Home",),
                    Tab(text: "Đang chiếu",),
                    Tab(text: "Sắp chiếu",),
                  ],
                ),
                actions: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child:TextField(
                        controller: _txtSearch,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tìm kiếm",

                        ),
                        onSubmitted: (value){
                          _popup.ShowPopup(message: value);
                        },
                      )
                  )
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _bottomIndex,
                selectedItemColor: Colors.deepOrangeAccent,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.shifting,
                elevation: 1,
                items: [
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.star),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.boxOpen),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gift),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user),title: Text("")),
                ],
                onTap: (index){
                  setState(() {
                    _bottomIndex = index;
                  });
                },
              ),
              body: BodyData(),
            )
        )

    );
  }
}