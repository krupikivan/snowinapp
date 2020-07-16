import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import '../widgets/user_tile.dart';

class UserList extends StatelessWidget {
  const UserList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<CommunityProvider>(
      builder: (context, user, _) => user.users == null
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(5.0),
              shrinkWrap: true,
              itemCount: user.users.cantidadUsuarios,
              itemBuilder: (BuildContext context, int index) => UserTile(
                  context: context,
                  size: size,
                  userProvider: user,
                  index: index),
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.black,
                height: 1,
              ),
            ),
    );
  }

  // Widget _getUserItem(BuildContext context, User user, IconData icon,
  //     UserProvider userProvider) {
  //   final size = MediaQuery.of(context).size;
  //   return ListTile(
  //       // leading: Icon(Icons.access_alarms),
  //       leading: UserAvatar(image: user.image, size: size),
  //       title: Text(user.nombre),
  //       // subtitle: Text(user.status),
  //       trailing: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Text(
  //             '${user.distancia}',
  //             style: TextStyle(fontSize: 12),
  //           ),
  //           SizedBox(width: 10),
  //           Icon(
  //             icon,
  //             size: 18,
  //           ),
  //         ],
  //       ),
  //       onTap: () {
  //         userProvider.userTapped = user;
  //         Navigator.pushNamed(context, '/userChat');
  //       });
  // }
}
