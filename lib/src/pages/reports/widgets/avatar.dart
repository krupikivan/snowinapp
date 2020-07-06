import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final double height;
  final String image;

  Avatar({
    this.height,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}