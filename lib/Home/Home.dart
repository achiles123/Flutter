import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/User.dart';
import 'package:flutter_app/Views/StarView/HomeView.dart';
import 'package:flutter_app/Views/StarView/MovieComingView.dart';
import 'package:flutter_app/Views/StarView/MoviePlayingView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  TabController _starBarController;
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
    _starBarController = new TabController(length: 3, vsync: this);
    _bottomIndex = 0;
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
      controller: _starBarController,
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
                    bottom: TabBar(
                      controller: _starBarController,
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
              });
            },
          ),
        )
    );
  }
}