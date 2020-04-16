import 'package:flutter/material.dart';
import 'package:maestro/components/rounded_button.dart';
import 'package:animate_do/animate_do.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 60,
                child: ZoomIn(
                  duration: Duration(seconds: 1),
                  child: Text('Are you ready to make your own lyrics ?',
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),SizedBox(
                height: 10,
              ),
              FadeIn(
                duration: Duration(milliseconds: 1100),
                child: RoundedButton(
                  colour: Color(0xff8269E8),
                  title: 'Start',
                  size: 25,
                  normal: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                ),
              )
            ],
          )),
      ),
    );
  }
}
