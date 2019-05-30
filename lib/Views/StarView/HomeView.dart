import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';

class HomeView extends StatefulWidget{
  @override
  HomeViewState createState() {
    // TODO: implement createState
    return new HomeViewState();
  }
}

class HomeViewState extends State<HomeView>{
  Movie _movie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movie = new Movie();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future:  _movie.GetMoviePlaying(),
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
                      height: MediaQuery.of(context).size.width*1,
                      width: MediaQuery.of(context).size.width*0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 3),
                            blurRadius: 2,
                            spreadRadius: -1,

                          ),
                        ]
                      ),
                      margin: EdgeInsets.all(7),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        borderOnForeground: true,
                        elevation: 1,
                        child:Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(data[index].poster_url),fit: BoxFit.fill),
                                ),

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
                                        child:  Text(data[index].film_name_vn,
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 24),overflow: TextOverflow.clip,softWrap: false,)

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
                                  color: Colors.grey.withOpacity(0.7),

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
                                        Icon((data[index].avg_point_all >= 2?Icons.star:(data[index].avg_point_all<=0?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                        Icon((data[index].avg_point_all >= 4?Icons.star:(data[index].avg_point_all<=2?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                        Icon((data[index].avg_point_all >= 6?Icons.star:(data[index].avg_point_all<=4?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                        Icon((data[index].avg_point_all >= 8?Icons.star:(data[index].avg_point_all<=6?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                        Icon((data[index].avg_point_all >= 10?Icons.star:(data[index].avg_point_all<=8?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),// Rating score
                            if(data[index].film_age != 0)
                              Positioned(
                                top:10,
                                left: 10,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width*0.08,
                                  height: MediaQuery.of(context).size.height*0.03,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("C"+data[index].film_age.toString(),style: TextStyle(color: Colors.white,fontSize: 12),)

                                    ],
                                  ),
                                ),
                              ),// Age warning

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