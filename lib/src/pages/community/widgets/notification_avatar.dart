import 'package:flutter/material.dart';

class NotificationAvatar extends StatelessWidget {
  const NotificationAvatar({Key key, this.notif}) : super(key: key);

  final String notif;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Color.fromRGBO(255, 216, 52, 1),
      child: Text(
        notif,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
