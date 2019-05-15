import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/Menu/Menu.dart';

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

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  int _menuIndex = 0;
  List<Widget> _listMenu;

  void BuildMenu(){
    _listMenu = new List<Widget>();
    for(int i=0;i<3;i++){
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

  Widget SwitchMenu() {
    switch(_menuIndex){
      case 0:return new MenuFirst();
      case 1:return new MenuSecond();
      case 2:return new MenuThird();

    }
  }

  @override
  Widget build(BuildContext context) {
    BuildMenu();
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
      body: Center(
        child: Column(
          children: <Widget>[
            SwitchMenu(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      )
    );
  }

}
