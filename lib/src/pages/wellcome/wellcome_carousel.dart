import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'package:snowin/src/utils/instagram.dart' as instagram;

import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/config/config.dart';

import 'package:snowin/src/providers/snowin_provider.dart';
import 'package:snowin/src/providers/login_provider.dart';



class WellcomeCarousel extends StatefulWidget {
  @override
  _WellcomeCarouselState createState() => _WellcomeCarouselState();
}

class _WellcomeCarouselState extends State<WellcomeCarousel> {
  static final FacebookLogin _facebookSignIn = new FacebookLogin();
  static final Preferences _preferences = Preferences();

  CarouselController buttonCarouselController = CarouselController();
  int _currentIndex=0;
  SnowinProvider snowinprovider = SnowinProvider();
  LoginProvider loginprovider = LoginProvider();

  List list = [];
  List<Widget> item = [];

  bool fbLogin = false, instLogin = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: FutureBuilder<Map>(
                future: _cargarDatos(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                      return CarouselSlider(
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          onPageChanged: (value, item){
                            setState(() {
                              _currentIndex = value;
                            });
                          },
                          height: double.infinity,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.1,
                          initialPage: 0,
                        ),
                        items: item,
                      );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                }
              )
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        buttonCarouselController.jumpToPage(0);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal:8),
                        width: 13,
                        height: 13,
                        decoration: new BoxDecoration(
                          color: (_currentIndex==0)?Color.fromRGBO(121, 121, 121, 1):Color.fromRGBO(208, 208, 208, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        buttonCarouselController.jumpToPage(1);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal:8),
                        width: 13,
                        height: 13,
                        decoration: new BoxDecoration(
                          color: (_currentIndex==1)?Color.fromRGBO(121, 121, 121, 1):Color.fromRGBO(208, 208, 208, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        buttonCarouselController.jumpToPage(2);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal:8),
                        width: 13,
                        height: 13,
                        decoration: new BoxDecoration(
                          color: (_currentIndex==2)?Color.fromRGBO(121, 121, 121, 1):Color.fromRGBO(208, 208, 208, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _cargarDatos(
      BuildContext context) async {
    Map respList = await snowinprovider.obtenerwellcome();
    if (list.length == 0) {
      if (respList['ok']) {
        if (respList['data'] != null) {
          list = respList['data'];
          list.forEach((element) {
            item.add(
               _carouselItem(context, element['ruta'], element['username'], element['descripcion'])
            );
          });
        }
      }
    }
    return respList;
  }


  Widget _carouselItem(BuildContext context, String image, String autor, String step){
    final size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        //color: Colors.amber
      ),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height*0.53,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                ),
                Container(
                  height: size.height*0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:size.height*0.045),
                        alignment: Alignment.center,
                        child: Image(
                          height: size.height*0.18,
                          image: AssetImage("assets/images/logo-snowin.png"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom:size.height*0.05),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                          ),
                          child: Text("Foto de $autor.", style: TextStyle(fontSize: 19),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          (step== 'Pantalla 1')?
            Column(
              children: [
                SizedBox(height: size.height*0.015,),
                Text(
                  "Bienvenido!", 
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromRGBO(124, 123, 123, 1)),
                ),
                SizedBox(height: size.height*0.020,),
                Text(
                  "Snowin App es una comunidad\n de esquiadores\n y snowboardistas que informan\n en tiempo real sobre el estado\n de los Centros de Ski.",
                  style: TextStyle(fontSize: 23, color: Color.fromRGBO(140, 140, 139, 1)), 
                  textAlign: TextAlign.center,
                ),
              ],
            )
          :(step== 'Pantalla 2')? 
            Column(
              children: [
                SizedBox(height: size.height*0.015,),
                Text(
                  "Más que deportes", 
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromRGBO(124, 123, 123, 1)),
                ),
                SizedBox(height: size.height*0.020,),
                Text(
                  "Contactate con\n otros usuarios,\n recibí descuentos y premios.", 
                  style: TextStyle(fontSize: 23, color: Color.fromRGBO(140, 140, 139, 1)), 
                  textAlign: TextAlign.center,
                ),
              ],
            )
          :
            Column(
              children: [
                SizedBox(height: size.height*0.015,),
                Text(
                  "Comenzar",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromRGBO(124, 123, 123, 1)),
                ),
                SizedBox(height: size.height*0.020,),
                Container(
                  width: size.width*0.87,
                  height: 48,
                  child: RaisedButton(
                    color: Color.fromRGBO(59, 89, 152, 1),
                    onPressed: (){
                      //Navigator.pushNamed(context, '/wellcome-conditions');
                      if (!fbLogin && !instLogin) {
                          facebookLogin();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FaIcon(FontAwesomeIcons.facebookSquare, color: Colors.white),
                        Text("Ingresa con tu cuenta de Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.025,),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(79, 91, 213, 1),
                        Color.fromRGBO(150, 47, 191, 1),
                        Color.fromRGBO(214, 41, 118, 1),
                        Color.fromRGBO(250, 126, 30, 1),
                        Color.fromRGBO(254, 218, 117, 1),
                      ]
                    )
                  ),
                  width: size.width*0.87,
                  height: 48,
                  child: RaisedButton(
                    color: Colors.transparent,
                    onPressed: (){
                      //Navigator.pushNamed(context, '/wellcome-conditions');
                      if (!fbLogin && !instLogin) {
                          instagramLogin();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.white,),
                        Text("Ingresa con tu cuenta de Instagram", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }



/////////////////////////////////////////////////////////////////////////////////////NEW CODE
//////////////////////////////////////////////////////////////Functions
  //facebook login
  Future<void> facebookLogin() async {
      setState(() { fbLogin = true; });
      await _facebookSignIn.logIn(['email']).then((fbResponse) {
                print(fbResponse.status);

                switch (fbResponse.status) {
                  case FacebookLoginStatus.loggedIn:
                    http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${fbResponse.accessToken.token}')
                            .then((graphResponse) {
                                var profile = json.decode(graphResponse.body);
                                print(profile.toString());

                                LoginProvider().fbLogin(fbResponse.accessToken.token).then((response) {
                                    if(response['success']) {
                                        _preferences.email       = profile['email'];
                                        _preferences.nombre      = profile['first_name'];
                                        _preferences.apellidos   = profile['last_name'];
                                        _preferences.userid      = response['data']['id'] != null? (response['data']['id']).toString() : '';
                                        _preferences.status      = response['data']['status'] != null? (response['data']['status']).toString() : '';
                                        _preferences.token       = response['data']['token'] != null? response['data']['token'] : '';

                                        print('go to terms and conditions');
                                        fbLogin = false;
                                        _preferences.registerFrom = '1';
                                        Navigator.pushNamed(context, '/wellcome-conditions');
                                    } else {
                                       throw new Exception(response['message']);
                                    }
                                });
                            })
                            .catchError((error) {
                                print(error.toString());
                                fbLogin = false;
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
                fbLogin = false;
            });
  }

  //instagram login
  Future<void> instagramLogin() async {
      setState(() { instLogin = true; });
      await instagram.getToken(Config.instagramAppId, Config.instagramAppSecret).then((instResponse) {
                print(instResponse);

                if (instResponse != null) {
                }
                else {
                }

                instLogin = false;
            }).catchError((error) {
                print(error.toString());
                instLogin = false;
            });
  }

}