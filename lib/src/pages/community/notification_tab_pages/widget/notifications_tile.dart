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
            ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.people),
                    UserAvatar(
                      size: size,
                      image: notifications.userNotifica.image.toString(),
                    ),
                  ],
                ),
                title: AutoSizeText(notifications.userNotifica.nombre),
                subtitle: AutoSizeText(notifications.notificacion),
                trailing: Icon(
                  Icons.message,
                  size: 18,
                ),
                onTap: () {
                  // userProvider.userTapped = user;
                  // Navigator.pushNamed(context, '/userChat');
                }),
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
