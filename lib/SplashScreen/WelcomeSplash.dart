import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WelcomeSplash extends StatefulWidget{
  @override
  WelcomSplashState createState() {
    // TODO: implement createState
    return new WelcomSplashState();
  }
}

class WelcomSplashState extends State<WelcomeSplash> with TickerProviderStateMixin{
  VideoPlayerController _videoPlayerController;
  VoidCallback listener;
  Animation<double> _animation;
  AnimationController _animationController;
  bool _visible = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener =() {
      setState(() {

      });
    };
   /* _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    _animation = new CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
    setState(() {
      _visible = !_visible;
    });*/
    _videoPlayerController = VideoPlayerController.asset("assets/video/welcomevid.mp4")
    ..addListener(listener)
    ..setVolume(0)
    ..initialize()
    ..play();

    _videoPlayerController.play();

  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async=> true,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/image/end_game.jpg",
                  fit: BoxFit.cover,
                  height: _animation.value * MediaQuery.of(context).size.height,
                  width: _animation.value * MediaQuery.of(context).size.width),
              ],
            ),*/
            AspectRatio(
              aspectRatio: 9/16,
              child: VideoPlayer(_videoPlayerController)
            )
          ],

        ),
      ),
    ) ;
  }
}
