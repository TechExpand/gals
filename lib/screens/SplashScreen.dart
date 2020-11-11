import 'package:flutter/material.dart';
import 'HomePage.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPLASHSTATE();
  }
}

class SPLASHSTATE extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), go_to_home);
  }

  go_to_home() {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF340c64),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            scale: 2.0,
          ),
        ),
      ),
    );
  }
}
