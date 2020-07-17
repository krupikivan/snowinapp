import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';

import '../../config/config.dart';
import '../../widgets/custom_bottom_menu.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_list_info.dart';
import 'widget/account_detail_tile.dart';
import 'widget/custom_appbar_drawer.dart';
import 'widget/custom_num_data.dart';
import 'widget/custom_row_data.dart';
import 'widget/custom_user_info_detail.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    final reports = Provider.of<ReportProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarDrawer(
            scaffoldDrawer: scaffoldDrawer,
            context: context,
            showLogo: false,
            title: "MI PERFIL",
          ),
          preferredSize: Size(double.infinity, 70)),
      body: SingleChildScrollView(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Colors.black),
              height: size.height * 0.18,
              width: double.infinity,
              child: Text('Profile'),
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Nombre de Usuario',
                    style: TextStyle(color: Colors.grey[400], fontSize: 15),
                  ),
                  Text(
                    user.user.username,
                    style: TextStyle(color: Colors.grey[400], fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                              color: Colors.white,
                              width: 5.0,
                              style: BorderStyle.solid),
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  Config.apiImageBaseUrl + user.user.image))),
                    ),
                  ),
                  Text(
                    'PERFIL PUBLICO EN SNOWIN',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  CustomUserInfoDetail(
                    action: () => null,
                    info: 'Bio',
                    title1: user.user.biografia,
                    title2: user.user.localidad,
                  ),
                  CustomUserInfoDetail(
                    action: () => null,
                    info: 'Practica',
                    title1: user.user.actividad,
                  ),
                  CustomUserInfoDetail(
                    action: () => null,
                    info: 'Nivel',
                    title1: user.user.nivel,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'MIS REPORTES',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomRowData(
                    title1: 'Publicados',
                    num1: reports.allMyReports.length,
                    title2: 'Puntos',
                    num2: user.user.puntos,
                    title3: 'Ranking',
                    num3: user.user.ranking,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'COMUNIDAD',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomRowData(
                    title1: 'Amigos',
                    num1: 10,
                    title2: 'Mensajes',
                    num2: 5,
                    title3: 'Solicitudes',
                    num3: user.user.ranking,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'MI CUENTA',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        AccountDetailTile(
                          title: 'Notificaciones',
                          action: () => null,
                        ),
                        AccountDetailTile(
                          title: 'Privacidad',
                          action: () => null,
                        ),
                        AccountDetailTile(
                          title: 'Reportar un problema',
                          action: () => null,
                        ),
                        AccountDetailTile(
                          title: 'Salir de mi cuenta',
                          action: () => null,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomMenu(
        item: 3,
      ),
    );
  }
}
