import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final OnPressCallback onPressed;
  final String text;
  final Color color;
  final double height;
  final double width;

  CustomButton({
    this.text,
    this.color,
    this.height,
    this.width,
    this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: color,
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 22, color: Colors.white),),
      ),
    );
  }
}


typedef OnPressCallback = void Function();