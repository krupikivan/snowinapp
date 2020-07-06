import 'package:flutter/material.dart';

class AppBarSos extends StatelessWidget {
  AppBarSos({
    @required this.scaffoldDrawer,
  });
  final GlobalKey<ScaffoldState> scaffoldDrawer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 90,
                color: Theme.of(context).errorColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.popUntil(
                          context, ModalRoute.withName('/reports')),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          scaffoldDrawer.currentState.openEndDrawer(),
                      icon: Icon(
                        Icons.menu,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(
                'S.O.S CONTACTAR ASISTENCIA',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
