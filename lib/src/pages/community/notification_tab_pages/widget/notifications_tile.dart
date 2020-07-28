import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/notifications.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'package:snowin/src/pages/community/provider/community_provider.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'package:snowin/src/pages/community/widgets/user_avatar.dart';

class NotificationsTile extends StatelessWidget {
  final Notifications notifications;

  const NotificationsTile({Key key, this.notifications}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final community = Provider.of<CommunityProvider>(context, listen: false);
    final noti = Provider.of<NotificationProvider>(context, listen: false);
    final chat = Provider.of<ChatProvider>(context, listen: false);
    return InkWell(
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          children: [
            ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _getIcon(notifications),
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
                onTap: () async {
                  if (notifications.tipo == TipoNotificacion.Mensaje_Nuevo) {
                    community.userTapped = notifications.userNotifica;
                    noti.updateNotification(notifications.id);
                    await chat.getConversacion(notifications.userNotifica.id);
                    Navigator.of(context)
                        .pushNamed('/userChat', arguments: context);
                  } else if (notifications.tipo ==
                      TipoNotificacion.Solicitud_Amistad_Nueva) {
                    community.userTapped = notifications.userNotifica;
                    Navigator.pushNamed(context, '/userProfile');
                  } else {}
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

  Widget _getIcon(Notifications noti) {
    IconData icon;
    switch (noti.tipo) {
      case TipoNotificacion.Amigo_Cercano:
        icon = Icons.people;
        break;
      case TipoNotificacion.SOS:
        icon = Icons.warning;
        break;
      case TipoNotificacion.Solicitud_Amistad_Aceptada:
        icon = Icons.people_outline;
        break;
      case TipoNotificacion.Solicitud_Amistad_Nueva:
        icon = Icons.person_add;
        break;
      case TipoNotificacion.Mensaje_Nuevo:
        icon = Icons.message;
        break;
      case TipoNotificacion.Nueva_Campana:
        icon = Icons.new_releases;
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Icon(icon),
    );
  }
}
