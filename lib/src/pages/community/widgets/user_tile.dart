import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'package:snowin/src/pages/community/widgets/user_avatar.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key key,
    this.size,
    this.index,
    this.userProvider,
    this.context,
  }) : super(key: key);
  final Size size;
  final int index;
  final CommunityProvider userProvider;
  final BuildContext context;

  @override
  Widget build(context) {
    final chat = Provider.of<ChatProvider>(context, listen: false);
    final User user = userProvider.users.usuarios[index];
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ListTile(
          leading: UserAvatar(image: user.image, size: size),
          title: Text(user.nombre),
          // subtitle: Text(user.status),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${user.distancia}',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.message,
                size: 18,
              ),
            ],
          ),
          onTap: () {
            userProvider.userTapped = user;
            chat.getMensajes(id: user.id);
            Navigator.pushNamed(context, '/userChat');
          }),
    );
  }
}
