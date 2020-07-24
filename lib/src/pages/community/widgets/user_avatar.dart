import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snowin/src/config/config.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key key, this.image, this.size}) : super(key: key);
  final String image;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 0.12 * size.width,
        height: 0.12 * size.width,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: image != null && image != ""
                  ? NetworkImage(Config.apiImageBaseUrl + image)
                  : AssetImage('assets/images/male.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
