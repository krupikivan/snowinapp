import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String userName = 'Juan Carlos';
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
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
                Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hola',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          userName,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Mi perfil',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _drawerListTextStyle(
                    'Visible', Icons.lock_open, null, isSwitched),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).primaryColorLight,
              ),
            ],
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
        color: selected == true
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
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, _getRoute(txt));
      },
    );
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
