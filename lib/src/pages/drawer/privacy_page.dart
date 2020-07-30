import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';

import 'widget/custom_appbar_drawer.dart';

class PrivacyPage extends StatelessWidget {
  PrivacyPage({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final conex = Provider.of<ConnectionStatus>(context);
    return Scaffold(
        key: scaffoldDrawer,
        appBar: PreferredSize(
            child: CustomAppbarDrawer(
              scaffoldDrawer: scaffoldDrawer,
              route: '/profile',
              context: context,
              showLogo: false,
              title: "PRIVACIDAD",
            ),
            preferredSize: Size(double.infinity, 70)),
        body: Container(
          child: Consumer<UserProvider>(
            builder: (context, user, _) => user.user == null
                ? SizedBox()
                : Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: user.user.visible == "1"
                              ? Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Icon(
                                  Icons.lock_open,
                                  color: Theme.of(context).disabledColor,
                                ),
                          title: Text(
                            'Visible',
                            style: TextStyle(
                                color: user.user.visible == "1"
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor),
                          ),
                        ),
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
        ),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 2,
        ));
  }
}
