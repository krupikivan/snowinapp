import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double width;
  final Color borderColor;
  final OnPressCallback onPressed;

  CustomIconButton({
    this.icon,
    this.iconColor,
    this.iconSize,
    this.width,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      child: IconButton(
          icon: Icon(icon),
          iconSize: iconSize,
          color: iconColor,
          onPressed: onPressed,
      ),
    );
  }

}


typedef OnPressCallback = void Function();