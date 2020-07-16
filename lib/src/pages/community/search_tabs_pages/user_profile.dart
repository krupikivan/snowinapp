import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/widgets/custom_appbar_profile.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';
import 'package:snowin/src/widgets/custom_list_info.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _inviteSent;
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _inviteSent = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CommunityProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarProfile(
            scaffoldDrawer: scaffoldDrawer,
          ),
          preferredSize: Size(double.infinity, 70)),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomMenu(
        item: 2,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                child:
                    user.userTapped.image != null && user.userTapped.image != ""
                        ? Image.network(
                            Config.apiImageBaseUrl + user.userTapped.image,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/user.png'),
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
                  child: Text('${user.userTapped.distancia.truncate()}',
                      style: TextStyle(color: Colors.grey[300]))),
              Positioned(
                right: 20,
                bottom: -20,
                child: CustomFabIcon(
                  heroTag: 'btnProfileFriend',
                  isPrimary: !_inviteSent,
                  icon: Icons.person_add,
                  action: () => _inviteSent ? null : _showPopup(context),
                ),
              )
            ],
          ),
          CustomListInfo(title: 'Bio', info: user.userTapped.biografia ?? ''),
          CustomListInfo(
              title: 'Practica', info: user.userTapped.actividad ?? ''),
          CustomListInfo(title: 'Nivel', info: user.userTapped.nivel ?? '')
        ],
      ),
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
