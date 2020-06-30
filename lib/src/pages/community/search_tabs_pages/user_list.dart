import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/pages/community/provider/export.dart';

class UserList extends StatelessWidget {
  const UserList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Colors.black,
          height: 1,
        ),
        Consumer<UserProvider>(
          builder: (context, user, _) => ListView.separated(
            shrinkWrap: true,
            itemCount: user.userList.length,
            itemBuilder: (BuildContext context, int index) => _getUserItem(
                context, user.userList[index], Icons.message, user),
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.black,
              height: 1,
            ),
          ),
        )
      ],
    );
  }

  Widget _getUserItem(BuildContext context, User user, IconData icon,
      UserProvider userProvider) {
    return ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.image),
            ),
          ],
        ),
        title: Text(user.nombre),
        subtitle: Text(user.status),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'a 500 m',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(width: 10),
            Icon(
              icon,
              size: 18,
            ),
          ],
        ),
        onTap: () {
          userProvider.userTapped = user;
          Navigator.pushReplacementNamed(context, '/userProfile');
        });
  }
}
