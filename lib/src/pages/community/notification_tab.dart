import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/provider/user_chat.dart';

class NotificationsTab extends StatelessWidget {
  final String title = "Tu amigo Carlitos94 esta en Chapelco ahora.";
  final String subtitle = "Contactalo!";
  final IconData icon = Icons.message;
  final IconData icon2 = Icons.people;

  @override
  Widget build(BuildContext context) {
    Provider.of<CommunityTabsProvider>(context, listen: false).inSecondTab =
        false;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Consumer<UserProvider>(
        builder: (context, user, _) => user.userList == null
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                shrinkWrap: true,
                itemCount: user.userList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _getUserItem(context, user.userList[index], user),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black,
                  indent: 25,
                  endIndent: 15,
                ),
              ),
      ),
    );
  }

  Widget _getUserItem(
      BuildContext context, User user, UserProvider userProvider) {
    return ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon2),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.image),
            ),
          ],
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          icon,
          size: 18,
        ),
        onTap: () {
          userProvider.userTapped = user;
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (ctx) => UserChat(
          //               context: ctx,
          //             )));
          Navigator.pushReplacementNamed(context, '/userChat');
        });
  }
}
