import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';

class CustomAppbarProfile extends StatelessWidget {
  CustomAppbarProfile({
    @required this.scaffoldDrawer,
  });
  final GlobalKey<ScaffoldState> scaffoldDrawer;

  @override
  Widget build(BuildContext context) {
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
                    _getData(),
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

  Widget _getData() {
    return Consumer<CommunityProvider>(
      builder: (context, user, _) => Text(
        '${user.userTapped.nombre}',
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.white, fontSize: 25),
      ),
    );
  }
}
