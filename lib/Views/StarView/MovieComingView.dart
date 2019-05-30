import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';
import 'package:intl/intl.dart';

class MovieComingView extends StatefulWidget{
  Movie _movie;
  List<Movie> _movieComing = null;
  
  @override
  MovieComingState createState() {
    // TODO: implement createState
    return new MovieComingState();
  }
}

class MovieComingState extends State<MovieComingView>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._movie = new Movie();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          widget._movieComing = null;
        });
      },
      child: FutureBuilder(
        future:  widget._movieComing == null?widget._movie.GetMovieComing():new Future<List<Movie>>(()=>widget._movieComing),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting && widget._movieComing == null)
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
          else{
            if(snapshot.data != null)
              widget._movieComing = snapshot.data;
            if(widget._movieComing != null){
              return GridView.builder(
                  itemCount: widget._movieComing.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 9/12),
                  itemBuilder: (context,index){
                    return Container(
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
                                    image: DecorationImage(image: NetworkImage(widget._movieComing[index].poster_url),fit: BoxFit.fill),
                                  ),

                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right:10,
                                child: Container(
                                  alignment: FractionalOffset.centerLeft,
                                  width: MediaQuery.of(context).size.width*0.15,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: Colors.grey.withOpacity(0.5)
                                        ),
                                        child: Text(
                                          new DateFormat("dd/MM").format(new DateFormat("yyyy-MM-dd").parse(widget._movieComing[index].publish_date)),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,

                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),// Index
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
      ),
    );
  }
}