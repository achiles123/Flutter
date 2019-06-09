import 'package:flutter/material.dart';
import 'package:flutter_app/Model/CinemaSchedule.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:intl/intl.dart';

import '../../GlobalData.dart';
import '../../Helper.dart';
import '../../PopupHepler.dart';

class BookingScheduleView extends StatefulWidget{
  CinemaSchedule _cinemaSchedule;
  List<CinemaSchedule> _scheduleByDay;
  Movie _movie;
  Map<String,List<CinemaSchedule>> _schedule;

  BookingScheduleView(){
    _cinemaSchedule = new CinemaSchedule();
    _schedule = new Map<String,List<CinemaSchedule>>();
  }

  void SetMovie(Movie movie){
    _movie = movie;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookingScheduleViewState();
  }
}

class BookingScheduleViewState extends State<BookingScheduleView>{
  ScrollController _scrollController = new ScrollController(initialScrollOffset: 2*50.0);
  bool _viewType = true;
  int _selectedDay = 0;
  int _selectedCinema = 0;

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
  }

  Widget GetSchedule(){
    DateFormat format = DateFormat("yyyy-MM-dd");
    return FutureBuilder(
      future: widget._schedule.length == 0?widget._cinemaSchedule.GetScheduleByGroup(filmId:widget._movie.film_id,startDate:format.format(DateTime.now()),endDate:format.format(DateTime.now().add(Duration(days: 7)))):Future<Map<String,List<CinemaSchedule>>>(()=>widget._schedule),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null)
          return Container();
        else{
          widget._schedule = snapshot.data;
          Map<String,List<CinemaSchedule>> data = snapshot.data;
          return Container(
            height: data.length*50.0,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                return ExpansionPanelList(
                  expansionCallback: (indexChild,status){
                    setState(() {
                      _selectedCinema = index;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: _selectedCinema == index,
                      headerBuilder: (context,status){
                        return Container(
                          child: Row(
                            children: <Widget>[
                              Text(GlobalData.parentCinema[index].name)
                            ],
                          ),
                        );
                      },
                      body: Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            child: ListView.builder(
                              itemCount: data[data.keys.elementAt(index)].length,
                              itemBuilder: (context,indexChild){
                                return Container(
                                  height: 40,
                                  child: Row(
                                    children: <Widget>[
                                      Text(data[data.keys.elementAt(index)][indexChild].)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          );

        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        onRefresh: () async{
          setState(() {
          });
        },
        child: Container(
          color: Colors.white,

          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Vị trí hiện tại",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400),),
                        Text(
                            GlobalData.locations.containsKey(GlobalData.locationId)?GlobalData.locations[GlobalData.locationId]:"",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      activeColor: Colors.deepOrangeAccent,
                      value: GlobalData.locationId == -1?false:true,
                      onChanged: (value){
                        if(value == false){
                          setState(() {
                            GlobalData.locationId = -1;
                          });
                        }else{
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context){
                                return new LocationPopup();
                              }
                          );
                        }
                      },

                    ),

                  ],
                ),
              ),// Change Location
              Divider(),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Lịch chiếu",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400),),
                        Text(
                            _viewType?"Gộp nhóm":"Liệt kê",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      activeColor: Colors.deepOrangeAccent,
                      value: _viewType,
                      onChanged: (value){
                        setState(() {
                          _viewType = value;
                        });
                      },

                    ),

                  ],
                ),
              ),// Change View
              Divider(),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context,index){
                          return Container(
                              width: MediaQuery.of(context).size.width/6,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _selectedDay = index;
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text(Helper.GetNameOfDate(DateTime.now().add(Duration(days: index))),style: TextStyle(fontSize: 14,color: index == _selectedDay?Colors.deepOrangeAccent:Colors.black),),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width/6,
                                          decoration: BoxDecoration(
                                            shape: index == _selectedDay?BoxShape.circle:BoxShape.rectangle,
                                            color: index == _selectedDay?Colors.deepOrange:Colors.transparent,
                                          ),
                                          child: Text(DateTime.now().add(Duration(days: index)).day.toString(),style: TextStyle(color: index == _selectedDay?Colors.white:Colors.black),textAlign: TextAlign.center,)
                                      ),
                                    ),

                                  ],
                                ),
                              )
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),// Date View
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: Text(Helper.GetFullNameOfDate(DateTime.now().add(Duration(days: _selectedDay))),style: TextStyle(color: Colors.black54),),
              ),
              GetSchedule()
            ],
          ),
        )
    );
  }
}