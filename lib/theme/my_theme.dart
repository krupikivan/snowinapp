import 'package:flutter/material.dart';

ThemeData themeData() {
  TextTheme _basicTextTheme(TextTheme basic) {
    return basic.copyWith(
      headline1: basic.headline1.copyWith(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          color: Colors.grey[600],
          fontWeight: FontWeight.w600),
      headline2: basic.headline1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 20,
        color: Color.fromRGBO(29, 113, 184, 1),
      ),
      headline3: basic.bodyText1.copyWith(
          fontFamily: 'RobotoCondensed',
          fontSize: 16,
          color: Colors.grey[600],
          fontWeight: FontWeight.w400),
      headline4: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 14,
        color: Colors.grey[500],
      ),
      headline5: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff72bfff),
      ),
      headline6: basic.bodyText2.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      caption: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 25,
        color: Colors.grey[600],
      ),
      bodyText1: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        color: Colors.black,
      ),
      bodyText2: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 16,
        color: Colors.black,
      ),
      //Titulos del perfil
      subtitle1: basic.bodyText1.copyWith(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff1d72b7),
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xff1d72b7),
    backgroundColor: Colors.grey[800],
    primaryColorLight: Color(0xff8ecbfd),
    primaryColorDark: Color.fromRGBO(15, 83, 137, 1),
    hoverColor: Color.fromRGBO(0, 0, 0, 0.7),
    disabledColor: Colors.grey[600],
    highlightColor: Color.fromRGBO(200, 205, 208, 1), //Icon from bottom bar nav
    accentColor: Color.fromRGBO(255, 216, 52, 1), //Color from notification icon
    errorColor: Color(0xffed1c24),
  );
}
