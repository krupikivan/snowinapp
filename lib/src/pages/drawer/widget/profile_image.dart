import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/user_provider.dart';

class UserImage extends StatefulWidget {
  UserImage({Key key}) : super(key: key);
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  @override
  void initState() {
    super.initState();
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      if (user.loading) {
        setState(() {
          imageCache.clear();
        });
      }
      return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
                color: Colors.white, width: 5.0, style: BorderStyle.solid),
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Config.apiImageBaseUrl + user.user.image))),
      );
    });
  }
}
