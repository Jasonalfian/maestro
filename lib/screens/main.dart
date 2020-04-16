import 'package:flutter/material.dart';
import 'package:maestro/screens/logo.dart';
import 'package:maestro/screens/start_screen.dart';
import 'package:maestro/screens/main_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(Maestro());

class Maestro extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: ('/'),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(child: LogoScreen(), type: PageTransitionType.fade);
          case '/start':
            return PageTransition(child: StartScreen(), type: PageTransitionType.fade);
            break;
          case '/main':
            return PageTransition(child: MainScreen(), curve: Curves.easeOutQuart , type: PageTransitionType.rightToLeftWithFade, duration: Duration(milliseconds: 500));
          default:
            return null;
        }
      },
    );
  }
}
