import 'package:flutter/material.dart';

class UserLoadingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
              color: Colors.white, width: 5.0, style: BorderStyle.solid),
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/logo.png'))),
    );
  }
}
