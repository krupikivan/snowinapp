import 'package:flutter/material.dart';
import 'package:snowin/src/pages/community/widget/notification_avatar.dart';

class MainMenu extends StatelessWidget {
  final int item;

  MainMenu({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75.0,
      color: Color.fromRGBO(19, 64, 103, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _createIconButton(
              context, (item == 1), '/reports', Icons.report, "Reportes", ""),
          _createIconButton(context, (item == 2), '/community', Icons.people,
              "Comunidad", "4"),
          _createIconButton(context, (item == 3), '/benefits', Icons.beenhere,
              "Bneficios", ""),
          _createIconButton(
              context, (item == 4), '/sos', Icons.change_history, "S.O.S", ""),
        ],
      ),
    );
  }

  Widget _createIconButton(BuildContext context, bool selected, String route,
      IconData icon, String text, String notification) {
    final size = MediaQuery.of(context).size;
    if (selected) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, route);
        },
        child: Container(
          color: Color.fromRGBO(15, 83, 137, 1),
          width: size.width * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (notification != "")
                  ? Stack(
                      children: [
                        Icon(icon,
                            size: 35, color: Color.fromRGBO(200, 205, 208, 1)),
                        Positioned(
                          left: 15,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color.fromRGBO(255, 216, 52, 1),
                            child: Text(
                              notification,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    )
                  : Icon(icon,
                      size: 32, color: Color.fromRGBO(200, 205, 208, 1)),
              SizedBox(
                height: 3,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color.fromRGBO(200, 205, 208, 1), fontSize: 12),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, route),
        child: Container(
          width: size.width * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (notification != "")
                  ? Stack(
                      children: [
                        Icon(icon,
                            size: 35, color: Color.fromRGBO(200, 205, 208, 1)),
                        Positioned(
                            left: 15,
                            bottom: 15,
                            child: NotificationAvatar(notif: notification))
                      ],
                    )
                  : Icon(icon,
                      size: 32, color: Color.fromRGBO(200, 205, 208, 1)),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color.fromRGBO(200, 205, 208, 1), fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }
  }
}
