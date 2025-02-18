import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:flutter_share/flutter_share.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _prefs = new Preferences();
  @override
  Widget build(BuildContext context) {
    final conex = Provider.of<ConnectionStatus>(context);
    return Builder(
      builder: (context) => Drawer(
        child: ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: <
            Widget>[
          DrawerHeader(
            padding: const EdgeInsets.only(top: 30, right: 30),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                              'Hola',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          Consumer<UserProvider>(
                            builder: (context, user, _) => FittedBox(
                              child: Text(
                                _prefs.nombre,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                      },
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Mi perfil',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, user, _) => user.user == null
                ? SizedBox()
                : Row(
                    children: <Widget>[
                      Expanded(
                        child: _drawerListTextStyle('Visible', Icons.lock_open,
                            null, user.user.visible == "1" ? true : false),
                      ),
                      Switch(
                        value: user.user.visible == "1" ? true : false,
                        onChanged: (value) {
                          if (conex.status == Status.HasConnection) {
                            user.changeVisible(value);
                          } else {
                            DialogHelper.showSimpleDialog(
                                context, 'Verifique conexion');
                          }
                        },
                        activeColor: Theme.of(context).primaryColor,
                        activeTrackColor: Theme.of(context).primaryColorLight,
                      ),
                    ],
                  ),
          ),
          _drawerListTextStyle('Mis beneficios', Icons.label, 4, false),
          _drawerListTextStyle('Mis premios', Icons.mood, 5, false),
          _drawerListTextStyle('Consultas', Icons.email, 6, false),
          _drawerListTextStyle('Compartir SNOWIN', Icons.share, null, false),
          _drawerListTextStyle('Salir', Icons.power_settings_new, null, false),
        ]),
      ),
    );
  }

  Widget _drawerListTextStyle(
      String txt, IconData icon, int index, bool selected) {
    final TextStyle style = TextStyle(
        color: selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
        fontSize: 18);
    return ListTile(
      leading: Icon(icon,
          color: selected == true
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor),
      title: Text(
        txt,
        style: style,
      ),
      onTap: () async {
        if (txt == 'Compartir SNOWIN') {
          //TODO: Modificar el compartir app
          await FlutterShare.share(
              title: 'Snowin APP',
              linkUrl: 'https://play.google.com/store',
              text: 'Una app toda una comunidad');
        } else {
          if (txt == 'Consultas') {
            await Provider.of<ChatProvider>(context, listen: false)
                .getConversacion(3);
          } else if (txt == 'Salir') {
            _logout();
            Navigator.of(context).popAndPushNamed('/wellcome');
          }
          Navigator.pop(context);
          Navigator.of(context).pushNamed(_getRoute(txt), arguments: context);
        }
      },
    );
  }

  _logout() {
    _prefs.token = '';
    _prefs.userid = '';
    _prefs.nombre = '';
  }

  String _getRoute(name) {
    switch (name) {
      case 'Mis beneficios':
        return '/myBenefits';
      case 'Mis premios':
        return '/myAwards';
      case 'Consultas':
        return '/ask';
        break;
      default:
        return '';
    }
  }
}
