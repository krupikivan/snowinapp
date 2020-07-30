import 'package:flutter/material.dart';

class CustomAppbarDrawer extends StatelessWidget {
  CustomAppbarDrawer({
    @required this.scaffoldDrawer,
    this.title,
    this.context,
    this.showLogo,
    this.route = '/reports',
  });
  final GlobalKey<ScaffoldState> scaffoldDrawer;
  final String title;
  final String route;
  final BuildContext context;
  final bool showLogo;

  @override
  Widget build(context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, route),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                showLogo
                    ? Image.asset(
                        'assets/images/logo.png',
                        height: 55,
                        width: 55,
                      )
                    : SizedBox(
                        width: 0,
                      ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
}
