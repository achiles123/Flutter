import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Model/User.dart';
import 'package:flutter_app/Views/StarView/HomeView.dart';
import 'package:flutter_app/Views/StarView/MovieComingView.dart';
import 'package:flutter_app/Views/StarView/MoviePlayingView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../GlobalData.dart';
import '../PopupHepler.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState()=> new HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  TextEditingController _txtSearch;
  PopupHelper _popup;
  User _user;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  TabController _barController;
  int _bottomIndex;
  HomeView _homeView;
  MoviePlayingView _moviePlayingView;
  MovieComingView _movieComingView;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _txtSearch = new TextEditingController();
    _popup = new PopupHelper(context);
    _user = new User(context);
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _refreshKey = new GlobalKey<RefreshIndicatorState>();
    _barController = new TabController(length: 3, vsync: this);
    _bottomIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(GlobalData.locationId == -1){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                  onWillPop: () async =>false,
                  child: Container(
                      height: MediaQuery.of(context).size.height-50,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: AlertDialog(
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          contentPadding: EdgeInsets.all(5),
                          actions: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height*0.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: GlobalData.locations.length,
                                    itemBuilder: (context,index){
                                      return Container(
                                        child: Row(
                                          children: <Widget>[
                                            Card(
                                              child:  Radio(
                                                value: GlobalData.locationId == -1 && index == 0?1:(GlobalData.locationId == index?1:0),
                                                onChanged: (value){
                                                  if(value == 1)
                                                    GlobalData.locationId = index;
                                                },
                                              ),
                                            ),

                                            Container(
                                              child: Text(GlobalData.locations[index],style: TextStyle(fontSize: 12,color: Colors.black),),
                                            )
                                          ],
                                        ),
                                      );

                                    },
                                  ),
                                ),// Location panel
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    child: Text("Chọn",textAlign: TextAlign.center,),
                                    textTheme: ButtonTextTheme.primary,
                                    onPressed: ()=> Navigator.of(context).pop(),
                                  ),
                                ),// Location confirm
                              ],
                            ),
                          ],
                        )
                  )
              );
            }
        );
      }
    });
  }

  Future<Null> _refreshState() async{
    setState(() {
      _bottomIndex = _bottomIndex;

    });

  }

  Widget StarBody() {
    _homeView = _homeView == null?new HomeView():_homeView;
    _moviePlayingView = _moviePlayingView == null?new MoviePlayingView():_moviePlayingView;
    _movieComingView = _movieComingView == null?new MovieComingView():_movieComingView;
    return TabBarView(
      controller: _barController,
      children: <Widget>[
        _homeView,
        _moviePlayingView,
        _movieComingView
      ],
    );
  }

  Widget BodyData() {
    switch(_bottomIndex){
      case 0: return StarBody();
      default: return Container();
    }
  }

  Widget TabBarData(){
    switch(_bottomIndex){
      case 0:return TabBar(
        controller: _barController,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(text: "Home",),
          Tab(text: "Đang chiếu",),
          Tab(text: "Sắp chiếu",),
        ],
      );
      case 1:return TabBar(
        controller: _barController,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(text: "Rạp gần đây",),
          Tab(text: "Hệ thống rạp",),
        ],
      );
      case 2:return TabBar(
        controller: _barController,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(text: "Điện ảnh 24h",),
          Tab(text: "Đánh giá",),
          Tab(text: "Khuyến mãi",),
        ],
      );
      case 3:return TabBar(
        controller: _barController,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
        ],
      );
      case 4:return TabBar(
        controller: _barController,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(text: "Tài khoản",),
          Tab(text: "Vé đã mua",),
          Tab(text: "Thông báo",),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => FirebaseAuth.instance.currentUser() == null?true:false,
        child:Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
                return <Widget>[
                  SliverAppBar(
                    leading: Container(),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBarData(),
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
                  )
                ];
              },

              body: BodyData()
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
                switch(index){
                  case 0:_barController = new TabController(length: 3, vsync: this);break;
                  case 1:_barController = new TabController(length: 2, vsync: this);break;
                  case 2:_barController = new TabController(length: 3, vsync: this);break;
                  case 3:_barController = new TabController(length: 0, vsync: this);break;
                  case 4:_barController = new TabController(length: 3, vsync: this);break;
                }
              });
            },
          ),
        )
    );
  }
}