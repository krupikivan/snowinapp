import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snowin/src/models/slider_model.dart';

import 'facebook_button.dart';
import 'instagram_button.dart';

class OnboardItem extends StatelessWidget {
  const OnboardItem({Key key, this.model, this.index}) : super(key: key);
  final SliderModel model;
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.53,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(model.image),
              ),
            ),
            Container(
              height: size.height * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.045),
                    alignment: Alignment.center,
                    child: Image(
                      height: size.height * 0.18,
                      image: AssetImage("assets/images/logo-snowin.png"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.05),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      child: Text(
                        "Foto de ${model.author}.",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        index == 0
            ? _getIndex0(size)
            : index == 1 ? _getIndex1(size) : _getIndex2(size),
      ],
    );
  }

  Widget _getIndex0(Size size) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          Text(
            "Bienvenido!",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(124, 123, 123, 1)),
          ),
          SizedBox(
            height: size.height * 0.020,
          ),
          Text(
            "Snowin App es una comunidad\n de esquiadores\n y snowboardistas que informan\n en tiempo real sobre el estado\n de los Centros de Ski.",
            style: TextStyle(
                fontSize: 23, color: Color.fromRGBO(140, 140, 139, 1)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _getIndex1(Size size) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.015,
        ),
        Text(
          "Más que deportes",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(124, 123, 123, 1)),
        ),
        SizedBox(
          height: size.height * 0.020,
        ),
        Text(
          "Contactate con\n otros usuarios,\n recibí descuentos y premios.",
          style:
              TextStyle(fontSize: 23, color: Color.fromRGBO(140, 140, 139, 1)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _getIndex2(Size size) {
    return Column(children: [
      SizedBox(
        height: size.height * 0.015,
      ),
      Text(
        "Comenzar",
        style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(124, 123, 123, 1)),
      ),
      SizedBox(
        height: size.height * 0.020,
      ),
      FacebookButton(size: size),
      SizedBox(
        height: size.height * 0.025,
      ),
      InstagramButton(size: size),
    ]);
  }
}
