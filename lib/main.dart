import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/Menu/MenuLib.dart';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),

    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> with TickerProviderStateMixin{
  // Default placeholder text
  int _menuIndex = 0;
  List<Widget> _listMenu;
  TabController _tabController;

  void BuildMenu(){
    _listMenu = new List<Widget>();
    for(int i=0;i<4;i++){
      _listMenu.add(new ListTile(
        title: Text("Menu $i"),
        onTap: (){
          setState(() {
            _menuIndex = i;
          });
          Navigator.of(context).pop();
        },
      ));
    }
  }

  Widget SwitchBody() {
    switch(_menuIndex){
      case 0:return new MenuFirst();
      case 1:return new MenuSecond();
      case 2:MenuThird _menuThird = new MenuThird();
            _menuThird.SetTabController(_tabController);
            return _menuThird;
      case 3:return new MenuFour();

    }
  }



  int TabNumber(){
    if(_menuIndex == 2)
      return 2;
    return 0;
  }

  TabBar GetTabBarView(){
    if(_menuIndex == 2){
      return new TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.list),),
          Tab(icon:Icon(Icons.grid_on))
        ],
        controller: _tabController,
        indicatorColor: Colors.white,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(length: 2, vsync: this);
    BuildMenu();
    return DefaultTabController(
      length: TabNumber(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Sample App 1"),
            bottom: GetTabBarView(),
          ),
          drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(child: Text("Header"),decoration: BoxDecoration(color: Color(0)),),
                  Column(
                    children: _listMenu,
                  )
                ],
              )
          ),
          body: SwitchBody()
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App abc"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text("Header"),decoration: BoxDecoration(color: Color(0)),),
            Column(
              children: _listMenu,
            )
          ],
        )
      ),
      body: SwitchBody()
    );
  }

}
