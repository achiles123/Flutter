import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';

class BookingView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookingViewState();
  }
}

class BookingViewState extends State<BookingView> with TickerProviderStateMixin{
  Movie _movie ;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movie = ModalRoute.of(context).settings.arguments;
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_movie.film_name_vn,overflow:TextOverflow.ellipsis ,),
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