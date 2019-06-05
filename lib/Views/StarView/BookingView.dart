import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BookingView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookingViewState();
  }
}

class BookingViewState extends State<BookingView> with TickerProviderStateMixin{
  Movie _movie ;
  DateTime _dateTime = DateTime.now();
  TabController _tabController;
  Timer _timer;
  Animation<Color> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _animationController = new AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    CurvedAnimation cuver = new CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = ColorTween(begin: Colors.black,end: Colors.white).animate(cuver);
    _animation.addStatusListener((listener){
      if(listener == AnimationStatus.completed){
        _animationController.reverse();
      }
      if (listener == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
    if(_timer == null){
      _timer = Timer.periodic(Duration(seconds: 1), (timer){
        setState(() {
          _dateTime = DateTime.now();
        });
      });
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _movie = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_movie.film_name_vn,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.deepOrangeAccent,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(text:"Lịch chiếu",),
              Tab(text:"Bình luận",),
              Tab(text:"Thông tin",),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(FontAwesomeIcons.clock,size: 15,),
                Container(width: 3,),
                Text(DateFormat("HH").format(_dateTime)),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context,child){
                    return Text(":",style: TextStyle(color: _animation.value),);
                  },
                ),
                Text(DateFormat("mm").format(_dateTime)),
                Container(width: 5,),
              ],
            )
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}