import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/widget/notifications_tile.dart';

class ListNotificationTiles extends StatelessWidget {
  const ListNotificationTiles({Key key, this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notif, _) => notif.notificationList.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(5.0),
              controller: controller,
              itemCount: notif.notificationList.length + 1,
              itemBuilder: (context, i) {
                if (i < notif.notificationList.length)
                  return NotificationsTile(
                      notifications: notif.notificationList[i]);
                else
                  return SizedBox(height: 70.0);
              })
          : notif.loading
              ? ListTile(
                  title: Text('Buscando ...'),
                )
              : ListTile(
                  title: Text(!notif.hasConnection
                      ? 'Verifique su conexion'
                      : 'No hay registros'),
                ),
    );
  }
}
