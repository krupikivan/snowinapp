import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snowin/src/models/notifications.dart';
import 'package:snowin/src/pages/community/widgets/user_avatar.dart';

class NotificationsTile extends StatelessWidget {
  final Notifications notifications;

  const NotificationsTile({Key key, this.notifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 15.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  UserAvatar(
                      image: notifications.userNotifica.image.toString(),
                      size: size),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          notifications.userNotifica.nombre.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color.fromRGBO(159, 159, 159, 1)),
                        ),
                        AutoSizeText(
                          notifications.notificacion.toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container(), flex: 1),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 15.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
