import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/share/preference.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation animation,
      delayedAnimation,
      muchDelayAnimation,
      transfor,
      fadeAnimation;
  AnimationController animationController;
  final _preferences = new Preferences();
  final firebaseAnalyticsProvider = FirebaseAnalyticsProvider();
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    transfor = BorderRadiusTween(
            begin: BorderRadius.circular(125.0),
            end: BorderRadius.circular(0.0))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    new Timer(new Duration(seconds: 3), () {
      _checkRegistrationStatus();
    });

    firebaseAnalyticsProvider.logLogin();
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: new Container(
              decoration: new BoxDecoration(color: Colors.white),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Flexible(
                    flex: 1,
                    child: new Center(
                      child: FadeTransition(
                          opacity: fadeAnimation,
                          child: Image.asset(
                            "assets/images/snowin.png",
                            height: 100.0,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

/////////////////////////////////////////////////////////////////////////////////////NEW CODE
//////////////////////////////////////////////////////////////Functions
  _checkRegistrationStatus() async {
    print('check registration status ...');
    if (_preferences.token.toString().isNotEmpty) {
      print('token found: ' + _preferences.token.toString());
      print('go to reports page');
      Provider.of<UserProvider>(context, listen: false).fetchUserData();
      Navigator.pushNamed(context, '/reports');
    } else {
      print('no token found, go to registration page');
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/wellcome', (Route<dynamic> route) => false);
    }
  }
}
