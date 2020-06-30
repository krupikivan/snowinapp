import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/widgets/custom_list_info.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _inviteSent;

  @override
  void initState() {
    super.initState();
    _inviteSent = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              child: Image.network(
                user.userTapped.profile,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 90,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).hoverColor, Colors.transparent],
              )),
            ),
            Positioned(
                right: 20,
                top: 10,
                child:
                    Text("a 500 m", style: TextStyle(color: Colors.grey[300]))),
            Positioned(
              right: 20,
              bottom: -20,
              child: FloatingActionButton(
                heroTag: 'btnProfileFriend',
                backgroundColor: _inviteSent == false
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                child: Icon(Icons.person_add, size: 30),
                onPressed: () =>
                    _inviteSent == true ? null : _showPopup(context),
              ),
            )
          ],
        ),
        CustomListInfo(
            title: 'Bio',
            info:
                'Buscadora incansable de aventura. RRPP en Sky Restor Chapelco'),
        CustomListInfo(title: 'Practica', info: 'Ski'),
        CustomListInfo(title: 'Nivel', info: 'Intermedio'),
      ],
    );
  }

  _showPopup(context) {
    setState(() {
      _inviteSent = true;
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          width: MediaQuery.of(context).size.width / 1.3,
          child: ListTile(
            title: Text(
              'Solicitud de amistad enviada',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.person_add,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                Icon(
                  Icons.check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
