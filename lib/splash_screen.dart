import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_splash_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;

  void navigationpage() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset('assets/video.mp4')..addListener(() => setState(() {}))
    ..setLooping(true)
    ..initialize().then((value) => _controller.play());
    Future.delayed(Duration(seconds: 9), ()  {
      navigationpage();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      _controller != null && _controller.value.isInitialized ? Center(
        child: AspectRatio(
          aspectRatio: 3/3,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
              child: ClipRect(child: VideoPlayer(_controller), clipper: RectClipper())
          ),
        ),
      ) : Container(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      )
    );
  }
}

class RectClipper extends CustomClipper<Rect> {

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(0, 0, 1075, 600);
  }
}
