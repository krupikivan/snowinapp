import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/share/preference.dart';

class GetStarted extends StatelessWidget {
  static final Preferences _prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height * 0.53,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://skisnowstar.com/files/2019/11/feature1_1.jpg"),
                        ),
                      ),
                      Container(
                        height: size.height * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.045),
                              alignment: Alignment.center,
                              child: Image(
                                height: size.height * 0.18,
                                image:
                                    AssetImage("assets/images/logo-snowin.png"),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: size.height * 0.05),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "Foto de Foto de Sofia93.",
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Estas ingresando como",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(140, 140, 139, 1)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _prefs.nombre + ' ' + _prefs.apellidos,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: size.width * 0.87,
                          height: 48,
                          child: RaisedButton(
                            color: primaryColor,
                            onPressed: () {
                              //TODO:Borrar esto
                              _prefs.token = Config.ivanTKN;
                              Navigator.pushNamed(context, '/reports');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ingresar",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FaIcon(FontAwesomeIcons.arrowRight,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
