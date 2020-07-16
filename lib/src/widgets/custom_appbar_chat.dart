import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/widgets/user_avatar.dart';

class CustomAppbarChat extends StatelessWidget {
  CustomAppbarChat({
    @required this.scaffoldDrawer,
    this.context,
  });
  final GlobalKey<ScaffoldState> scaffoldDrawer;
  final BuildContext context;

  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    _getData(size),
                  ],
                ),
                IconButton(
                  onPressed: () => scaffoldDrawer.currentState.openEndDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getData(Size size) {
    return Consumer<CommunityProvider>(
      builder: (context, user, _) => Row(
        children: <Widget>[
          UserAvatar(
            image: user.userTapped.image,
            size: size,
          ),
          SizedBox(width: 10),
          Text(
            user.userTapped.nombre,
            style: TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
