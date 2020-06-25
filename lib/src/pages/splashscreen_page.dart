import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:http/http.dart' as http;

import 'package:snowin/src/providers/login_provider.dart';

import 'package:permission_handler/permission_handler.dart';



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
  static final FacebookLogin facebookSignIn = new FacebookLogin();

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
      // if (_preferences.token != '') {
      //   _comprobarPermisos();
      // } else {
      //   Navigator.of(context)
      //       .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      // }
      Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });

    firebaseAnalyticsProvider.logLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: new Container(
              decoration:
                  new BoxDecoration(color: Colors.white),
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



  _comprobarPermisos() async {
    print('check location permission');
    PermissionHandler().checkPermissionStatus(PermissionGroup.location)
      .then((PermissionStatus status) {
          print(status.toString());
          print('check camera permission');
          PermissionHandler().checkPermissionStatus(PermissionGroup.camera)
              .then((PermissionStatus status2) {
                  print(status2.toString());

                  //CHECK AUTOLOGIN
                  tryAutoLogin();
          });
    });
  }


/////////////////////////////////////////////////////////////////////////////////////NEW CODE
//////////////////////////////////////////////////////////////Functions
  //auto login
  void tryAutoLogin() {
      if (_preferences.accessToken.toString().isNotEmpty) {
          //comprobar si es de facebook o de instagram el autologin
          switch(_preferences.registerFrom) {
              case '1':
                facebookLogin();
                break;
              case '2':
                instagramLogin();
                break;
              default:
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                break;
          }
      } else {
          //sino directo al proceso de registro
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
  }

  //facebook login
  Future<void> facebookLogin() async {
      await facebookSignIn.logIn(['email']).then((fbResponse) {
                print(fbResponse.status);

                switch (fbResponse.status) {
                  case FacebookLoginStatus.loggedIn:
                    http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${fbResponse.accessToken.token}')
                            .then((graphResponse) {
                                var profile = json.decode(graphResponse.body);
                                print(profile.toString());

                                LoginProvider().fbLogin(fbResponse.accessToken.token).then((response) {
                                    if(response['success']) {
                                        _preferences.accessToken = fbResponse.accessToken.token;
                                        _preferences.email       = profile['email'];
                                        _preferences.nombre      = profile['first_name'];
                                        _preferences.apellidos   = profile['last_name'];
                                        _preferences.userid      = response['data']['id'] != null? (response['data']['id']).toString() : '';
                                        _preferences.status      = response['data']['status'] != null? (response['data']['status']).toString() : '';
                                        _preferences.token       = response['data']['token'] != null? response['data']['token'] : '';

                                        print('go to reports page');
                                        _preferences.registerFrom = '1';
                                        Navigator.pushNamed(context, '/reports');
                                    } else {
                                       throw new Exception(response['message']);
                                    }
                                });
                            })
                            .catchError((error) {
                                print(error.toString());
                                throw new Exception(error.toString());
                            });
                    break;
                  case FacebookLoginStatus.cancelledByUser:
                    throw new Exception('Login cancelled by the user.');
                    break;
                  case FacebookLoginStatus.error:
                    throw new Exception('Facebook gave us: ${fbResponse.errorMessage}');
                    break;
                }
            }).catchError((error) {
                print(error.toString());

                Navigator.of(context).pushNamedAndRemoveUntil(
                        '/intro', (Route<dynamic> route) => false,
                        arguments: {'existe': true});
            });
  }

  //instagram login
  Future<void> instagramLogin() async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                        '/intro', (Route<dynamic> route) => false,
                        arguments: {'existe': true});
  }

}
