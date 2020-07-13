import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstagramButton extends StatelessWidget {
  const InstagramButton({Key key, this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            ])),
        width: size.width * 0.87,
        height: 48,
        child: RaisedButton(
          color: Colors.transparent,
          onPressed: () {
            //Navigator.pushNamed(context, '/wellcome-conditions');
            // if (!fbLogin && !instLogin) {
            //     instagramLogin();
            // }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
              ),
              Text("Ingresa con tu cuenta de Instagram",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}
