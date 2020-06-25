import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Location extends StatelessWidget {
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
            decoration: BoxDecoration(
              //color: Colors.amber
            ),
            child: ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height*0.53,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcThTHeG53wo1i16DC_lI2IE9R3sP--Mj8I4BmxiRjnWanR8No3A&usqp=CAU"),
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
                                child: Text("Foto de Foto de Sofia93.", style: TextStyle(fontSize: 19),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.015,),
                Column(
                  children: [
                    Text(
                      "Para disfrutar\n de una experiencia completa,\n necesitamos saber tu ubicación.",
                      style: TextStyle(fontSize: 22, color: Color.fromRGBO(140, 140, 139, 1)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Algunas funciones como el botón de SOS requieren esto.",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height*0.03,),
                    Container(
                      width: size.width*0.87,
                      height: 48,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: (){
                          Navigator.pushNamed(context, '/wellcome-profile-type');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FaIcon(FontAwesomeIcons.mapMarkerAlt, color: Colors.white),
                            SizedBox(width: 10,),
                            Text("Compartir ubicación", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                            SizedBox(width: 10,),
                            FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.012,),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}