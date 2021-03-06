import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Movie.dart';

class MoviePlayingView extends StatefulWidget{
  Movie _movie;
  List<Movie> _moviePlaying = null;

  @override
  MoviePlayingState createState() {
    // TODO: implement createState
    return new MoviePlayingState();
  }
}

class MoviePlayingState extends State<MoviePlayingView>{
  
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    widget._movie = new Movie();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          widget._moviePlaying = null;
        });
      },
      child: FutureBuilder(
        future:  widget._moviePlaying == null?widget._movie.GetMoviePlaying():new Future<List<Movie>>(()=>widget._moviePlaying),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting && widget._moviePlaying == null)
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.orangeAccent,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),);
          else{
            if(snapshot.data != null)
              widget._moviePlaying = snapshot.data;
            if(widget._moviePlaying!= null){
              return ListView.builder(
                  itemCount: widget._moviePlaying.length>17?17:widget._moviePlaying.length,
                  itemBuilder: (context,index){
                    return Container(
                        height: MediaQuery.of(context).size.width*0.4,
                        width: MediaQuery.of(context).size.width*0.9,
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
                                  Navigator.of(context).pushNamed("/booking",arguments: widget._moviePlaying[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget._moviePlaying[index].poster_landscape_mobile != null?widget._moviePlaying[index].poster_landscape_mobile:(widget._moviePlaying[index].poster_landscape != null?widget._moviePlaying[index].poster_landscape:widget._moviePlaying[index].poster_thumb)),
                                        fit: BoxFit.fill
                                    ),
                                  ),

                                ),
                              ),

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
                                      Text(widget._moviePlaying[index].avg_point_showing.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon((widget._moviePlaying[index].avg_point_all >= 2?Icons.star:(widget._moviePlaying[index].avg_point_all<=0?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                          Icon((widget._moviePlaying[index].avg_point_all >= 4?Icons.star:(widget._moviePlaying[index].avg_point_all<=2?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                          Icon((widget._moviePlaying[index].avg_point_all >= 6?Icons.star:(widget._moviePlaying[index].avg_point_all<=4?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                          Icon((widget._moviePlaying[index].avg_point_all >= 8?Icons.star:(widget._moviePlaying[index].avg_point_all<=6?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                          Icon((widget._moviePlaying[index].avg_point_all >= 10?Icons.star:(widget._moviePlaying[index].avg_point_all<=8?Icons.star_border:Icons.star_half)),color: Colors.red,size: 12,),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),// Rating score
                              Positioned(
                                bottom: 10,
                                left:10,
                                child: Container(
                                  alignment: FractionalOffset.centerLeft,
                                  width: MediaQuery.of(context).size.width*0.15,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        (index+1).toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,

                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),// Index
                              if(widget._moviePlaying[index].film_age != 0)
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
                                        Text("C"+widget._moviePlaying[index].film_age.toString(),style: TextStyle(color: Colors.white,fontSize: 12),)

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
      ),
    );
  }
}