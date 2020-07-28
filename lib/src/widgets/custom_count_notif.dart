import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';

class CustomCountNotif extends StatelessWidget {
  const CustomCountNotif({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Color.fromRGBO(255, 216, 52, 1),
      child: Consumer<NotificationProvider>(
        builder: (context, noti, _) => noti != null
            ? AutoSizeText(
                '${noti.notificationList.length}',
                style: TextStyle(color: Colors.black),
              )
            : SizedBox(),
      ),
    );
  }
}
