import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/community/search_tab.dart';
import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/notifications_list_tab.dart';
import 'package:snowin/src/widgets/custom_count_notif.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/error_connection.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  TabController _tabControllerCommunity;

  @override
  void initState() {
    super.initState();
    _tabControllerCommunity = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabControllerCommunity.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final conex = Provider.of<ConnectionStatus>(context);
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: CustomBottomMenu(
          item: 2,
        ),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            height: size.height,
            child: Stack(
              children: [
                CustomAppbar(
                  context: context,
                  image:
                      "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  height: 70.0,
                  title: 'COMUNIDAD',
                ),
                Positioned(
                  top: 70.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    children: [
                      Container(
                        height: 48,
                        child: TabBar(
                            controller: _tabControllerCommunity,
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor:
                                Color.fromRGBO(159, 159, 159, 1.0),
                            indicatorColor: Color.fromRGBO(29, 29, 27, 1.0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                child: Row(
                                  children: <Widget>[
                                    CustomCountNotif(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: AutoSizeText('NOTIFICACIONES',
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 17)),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('BUSCAR AMIGOS',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        height: size.height -
                            (70 +
                                48 +
                                75 +
                                10), //El alto de la pantalla menos el AppBar, Tabs y MainMenu
                        child: conex != null &&
                                conex.status == Status.HasConnection
                            ? TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _tabControllerCommunity,
                                children: <Widget>[
                                    NotificationsListTab(),
                                    SearchTab(),
                                  ])
                            : ErrorConnection(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: goBack,
    );
  }

//////////////////////////////////////////////////////////////Widgets

//////////////////////////////////////////////////////////////Functions
  Future<bool> goBack() async {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }
}
