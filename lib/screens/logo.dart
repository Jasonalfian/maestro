import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    lockScreen();
  }

  void lockScreen(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route(){
    Navigator.pushNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage("images/bgbaru.png"), fit: BoxFit.cover),
    ),
    constraints: BoxConstraints.expand(),
            child: Center(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    route();
                  },
                  child: ZoomIn(
                    duration: Duration(milliseconds: 1500),
                    child: Spin(
                      duration: Duration(milliseconds: 1500),
                      child: CircleAvatar(
                        radius: 125,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("images/logobaru.png"),
                      ),
                    ),
                  ),
                )
              ],
            )
            ),

      ),
    );
  }
}
