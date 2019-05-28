import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  int _bottomIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtSearch = new TextEditingController();
    _popup = new PopupHelper(context);
    _user = new User(context);
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _bottomIndex = 0;
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

            )
        )
      /*Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
          *//*leading:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Icon(Icons.menu),
                highlightColor: Colors.deepPurpleAccent,
                onTap: (){
                  _scaffoldKey.currentState.openDrawer();
                },
              ),// Menu,
              Spacer(),
              InkWell(
                child: Icon(Icons.assignment_ind),
                highlightColor: Colors.deepPurpleAccent,
                onTap: (){
                  _user.EditPopup();
                },
              ),// User Information
            ],
          ),*//*
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child:TextField(
                      controller: _txtSearch,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search,color: Colors.white,),

                      ),
                      onSubmitted: (value){
                        _popup.ShowPopup(message: value);
                      },
                    )
                )
              ],
            ), // Search Field

          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(title: Text("a"),)
            ],
          ),
        ),
      ),*/
    );
  }
}