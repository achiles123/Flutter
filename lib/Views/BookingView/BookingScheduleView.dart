import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/CustomWidget/ExpansionPanelCustom.dart';
import 'package:flutter_app/Model/CinemaSchedule.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:flutter_app/Model/TicketPrice.dart';
import 'package:intl/intl.dart';

import '../../GlobalData.dart';
import '../../Helper.dart';
import '../../PopupHepler.dart';

class BookingScheduleView extends StatefulWidget{
  CinemaSchedule _cinemaSchedule;
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
  ScrollController _scrollController = new ScrollController(initialScrollOffset: 115.0,);
  bool _viewType = true;
  int _selectedDay = 0;
  int _selectedCinema = -1;
  int _selectedCinemaAddress = -1;
  bool _toggle = true;
  String _cinemaKey;
  GlobalKey _keyDateView = new GlobalKey();
  Map<String,List<CinemaSchedule>> _scheduleFiltered = new Map<String,List<CinemaSchedule>>();
  CinemaSchedule _scheduleDetail;
  DateFormat _format = new DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();

  }

  Widget GetSchedule({ConnectionState status}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: widget._schedule.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context,index){
              return LayoutBuilder(
                builder: (mContext,constrain){
                  return ExpansionPanelList(
                    key: GlobalKey(debugLabel: "key"+index.toString()),
                    animationDuration: Duration(milliseconds: 700),
                    expansionCallback: (indexChild,status){
                      int a = 1;
                      setState(() {
                        if(_selectedCinema == index){
                          _toggle = !_toggle;
                        }else{
                          _toggle = true;
                        }
                        _selectedCinema = index;
                        _cinemaKey = _scheduleFiltered.keys.elementAt(index);
                        if(_scheduleFiltered[_cinemaKey].length != 0){
                          _scheduleDetail = _scheduleFiltered[_cinemaKey].first;
                        }
                        _selectedCinemaAddress = -1;

                        RenderBox renderBox = mContext.findRenderObject();
                        _scrollController.animateTo(renderBox.localToGlobal(Offset.zero).dy, duration: Duration(microseconds: 1), curve: Curves.ease);
                      });
                    },
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: _selectedCinema == index && _toggle == true,
                        headerBuilder: (context,status){
                          return Container(
                            child: Row(
                              children: <Widget>[
                                Image.network(GlobalData.parentCinema[index].logo,fit: BoxFit.fill,width: 40,),
                                Text(GlobalData.parentCinema[index].name),
                                Text("("+(_scheduleFiltered[_scheduleFiltered.keys.elementAt(index)].length != 0 ?_scheduleFiltered[_scheduleFiltered.keys.elementAt(index)][0].cinemas.length.toString():"0")+")"),
                              ],
                            ),
                          );
                        },// Cinema root
                        body: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min ,
                              children: <Widget>[
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _scheduleDetail != null?_scheduleDetail.cinemas.length:0,
                                    itemBuilder: (context,indexChild){
                                      return ExpansionPanelListCustom(
                                        animationDuration: Duration(milliseconds: 700),
                                        expansionCallback:  (childIndex,status) {
                                          _selectedCinemaAddress = indexChild;
                                        },
                                        children: [
                                          ExpansionPanelCustom(
                                              canTapOnHeader: true,
                                              isExpanded: _selectedCinemaAddress == indexChild,
                                              headerBuilder: (context,status){
                                                return Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(GlobalData.parentCinema[index].shortName,style: TextStyle(color: GlobalData.parentCinema[index].color),),
                                                      Text(" - "+_scheduleDetail.cinemas[indexChild].cinema_name_s2)
                                                    ],
                                                  ),
                                                );
                                              },// Cinema Address
                                              body:  _selectedCinema != index?Container():FutureBuilder(
                                                future: _scheduleDetail.cinemas[indexChild].ticket_price.length == 0 && status != ConnectionState.waiting?_scheduleDetail.cinemas[indexChild].GetTicketPrice(lock: true):Future<List<TicketPrice>>(()=>_scheduleDetail.cinemas[indexChild].ticket_price),
                                                //future: _scheduleDetail.cinemas[indexChild].GetTicketPrice(),
                                                builder: (context,snapshot){
                                                  if(snapshot.connectionState == ConnectionState.waiting && _scheduleDetail.cinemas[indexChild].ticket_price.length == 0){
                                                    if(_selectedCinemaAddress == indexChild)
                                                      return Container(padding: EdgeInsets.all(10),child:  CircularProgressIndicator(),);
                                                    else
                                                      return Container();
                                                  }else{
                                                    if(_scheduleDetail.cinemas[indexChild].ticket_price.length != 0){
                                                      List<String> byDate =  _scheduleDetail.cinemas[indexChild].ticket_price.map((f)=> f.session_time).toSet().toList();
                                                      List<TicketPrice> filteredPrice = new List<TicketPrice>();
                                                      for(String date in byDate){
                                                        filteredPrice.add(_scheduleDetail.cinemas[indexChild].ticket_price.where((x)=> x.session_time == date).first);
                                                      }
                                                      DateFormat formatDate = new DateFormat("yyyy-MM-dd HH:mm:ss");
                                                      DateFormat formatTime = new DateFormat("HH:mm");
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: filteredPrice.length,
                                                        itemBuilder: (context,indexTicket){
                                                          return Container(
                                                            padding:EdgeInsets.all(7),
                                                            child: InkWell(
                                                              onTap: (){
                                                                Navigator.pushNamed(context, "/booking/choose_price",arguments: {
                                                                  "movie": widget._movie,
                                                                  "cinema": GlobalData.parentCinema[index],
                                                                  "address": _scheduleDetail.cinemas[indexChild],
                                                                  "tickets": _scheduleDetail.cinemas[indexChild].ticket_price

                                                                });
                                                              },
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Text(formatTime.format(formatDate.parse(filteredPrice[indexTicket].session_time)),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                                                                  Text(" ~ ",style: TextStyle(color: Colors.black38),),
                                                                  Text(formatTime.format(formatDate.parse(filteredPrice[indexTicket].session_time).add(Duration(minutes:widget._movie.film_information.film_duration))),style: TextStyle(color: Colors.black38),),
                                                                  Spacer(),
                                                                  Text(filteredPrice[indexTicket].version+" - Phụ đề",style: TextStyle(color: Colors.black38),),
                                                                  Spacer(),
                                                                  Text("~"+(filteredPrice[indexTicket].type_price~/1000).toString()+"k",style: TextStyle(color: Colors.black38),),
                                                                ],
                                                              ),
                                                            )
                                                          );// Cinema Ticket Price
                                                        },
                                                      );
                                                    }else{
                                                      if(snapshot.connectionState == ConnectionState.done && _scheduleDetail.cinemas[indexChild].ticket_price.length == 0)
                                                        return Container();
                                                      else
                                                        return Container(padding: EdgeInsets.all(10),child:  CircularProgressIndicator(),);
                                                    }

                                                  }

                                                },
                                              )
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        onRefresh: () async{
          setState(() {
            widget._schedule =  new Map<String,List<CinemaSchedule>>();
            _scheduleFiltered = new Map<String,List<CinemaSchedule>>();
          });
        },
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: widget._movie.film_information == null?widget._movie.GetInformation():Future(()=> null),
              builder: (context,snapshot){
                return Container();
              },
            ),
            FutureBuilder(
                future: widget._schedule.length == 0?widget._cinemaSchedule.GetScheduleByGroup(filmId:widget._movie.film_id,startDate:_format.format(DateTime.now()),endDate:_format.format(DateTime.now().add(Duration(days: 7)))):new Future<Map<String,List<CinemaSchedule>>>(()=>widget._schedule),
                //future: TicketPrice.GetBySession("385000863"),
                builder: (context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && widget._schedule.length == 0)
                    return Center(child: CircularProgressIndicator(),);
                  else{
                    if(snapshot.data != null){
                      widget._schedule = snapshot.data;
                    }

                    if(_scheduleFiltered.length == 0){
                      widget._schedule.forEach((key,value){
                        _scheduleFiltered.addAll({
                          key:value.where((x)=> x.date == DateFormat("yyyyMMdd").format(DateTime.now())).toList()
                        });
                      });
                    }
                    _cinemaKey = _scheduleFiltered.keys.elementAt(0);
                    if(_scheduleFiltered[_scheduleFiltered.keys.elementAt(0)].length != 0){
                      _scheduleDetail = _scheduleFiltered[_scheduleFiltered.keys.elementAt(0)].first;
                    }
                    return Container(
                      color: Colors.white,
                      height: double.infinity,
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
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
                            key: _keyDateView,
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
                                                _toggle = false;
                                                _selectedDay = index;
                                                _scheduleFiltered.clear();
                                                widget._schedule.forEach((key,value){
                                                  _scheduleFiltered.addAll({
                                                    key:value.where((x)=> x.date == DateFormat("yyyyMMdd").format(DateTime.now().add(Duration(days: index)))).toList()
                                                  });
                                                });
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
                          GetSchedule(status: snapshot.connectionState),


                        ],
                      ),


                    );
                  }
                }),

          ],
        )


    );
  }
}