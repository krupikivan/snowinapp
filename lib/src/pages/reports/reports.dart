import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/reports/widgets/report_top_info.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/pages/reports/report_tab/reports_list_tab.dart';
import 'package:snowin/src/pages/reports/ranking_tab/ranking_list_tab.dart';
import 'package:snowin/src/pages/reports/my_report_tab/my_reports_list_tab.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/pages/reports/widgets/dialog_bottom_content.dart';
import 'package:snowin/src/pages/reports/widgets/dialog_top_content.dart';
import 'package:snowin/src/widgets/error_connection.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with TickerProviderStateMixin {
  Timer _speedTimer;
  TabController _tabControllerReports;

  @override
  void initState() {
    super.initState();
    _tabControllerReports = TabController(vsync: this, length: 3);
    setLocationState();
  }

  @override
  void dispose() {
    _tabControllerReports.dispose();
    _speedTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final conex = Provider.of<ConnectionStatus>(context);
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: CustomBottomMenu(
          item: 1,
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
                  back: false,
                ),
                Positioned(
                  top: 70.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    children: [
                      ReportTopInfo(),
                      Container(
                        height: 48,
                        child: TabBar(
                            controller: _tabControllerReports,
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor:
                                Color.fromRGBO(159, 159, 159, 1.0),
                            indicatorColor: Color.fromRGBO(29, 29, 27, 1.0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('REPORTES',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('RANKING',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('MIS REPORTES',
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
                                70), //El alto de la pantalla menos el AppBar, topInfo, Tabs y MainMenu
                        child: conex != null &&
                                conex.status == Status.HasConnection
                            ? TabBarView(
                                controller: _tabControllerReports,
                                children: <Widget>[
                                    ReportsListTab(),
                                    RankingListTab(),
                                    MyReportsListTab(),
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

  void showWarningsDialog() {
    print('show warnings dialog');
    final size = MediaQuery.of(context).size;
    Provider.of<ReportProvider>(context, listen: false)
        .changeWarningDialog(false);
    showDialog(
      context: context,
      child: Container(
        padding: EdgeInsets.only(top: 15),
        color: Colors.transparent,
        child: Consumer<ReportProvider>(
          builder: (context, reports, _) => Column(
            children: [
              reports.pistasRecomendadas.length > 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.width * 0.05),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 216, 52, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: DialogTopContent(
                        context: context,
                      ),
                    )
                  : Container(),
              reports.closestFriends.length > 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.width * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: DialogBottomContent(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void setLocationState() async {
    final reports = Provider.of<ReportProvider>(context, listen: false);
    await reports.centroSki();

    //cargar novedades del centro ski cercano
    final warning = await reports.fetchCentroSkiWarning();
    if (warning != null) {
      DialogHelper.showSimpleDialog(context, warning.toString());
    }

    // cargar amigos cerca
    await reports.fetchClosestFriends();

    //Mostramos los mensajes en popup
    if (reports.showReportWarnning &&
        (reports.dialogTopVisible || reports.dialogBottomVisible) &&
        !reports.showed) {
      reports.showed = true;
      showWarningsDialog();
    }
  }

  // List<Widget> buildFriends() {
  //   List<Widget> elements = new List<Widget>();

  //   String friends = '', predicade = '';

  //   if (_session.closestFriends.length == 1) {
  //     friends = _session.closestFriends.first.username.toString();
  //     predicade = 'También está en ' + _session.center.name.toString() + '!';
  //   } else {
  //     if (_session.closestFriends.length == 2) {
  //       friends = _session.closestFriends.first.username.toString() +
  //           ' y ' +
  //           _session.closestFriends[1].username.toString();
  //     } else {
  //       friends = _session.closestFriends.first.username.toString() +
  //           ', ' +
  //           _session.closestFriends[1].username.toString() +
  //           ' y ' +
  //           (_session.closestFriends.length - 2).toString() +
  //           ' amigos más';
  //     }
  //     predicade = 'También están en ' + _session.center.name.toString() + '!';
  //   }

  //   elements.add(
  //     AutoSizeText(
  //       friends,
  //       style: TextStyle(
  //           fontSize: 15,
  //           color: Theme.of(context).primaryColor,
  //           fontWeight: FontWeight.bold,
  //           decoration: TextDecoration.none),
  //     ),
  //   );
  //   elements.add(
  //     AutoSizeText(
  //       predicade,
  //       style: TextStyle(
  //           fontSize: 15, color: Colors.black, decoration: TextDecoration.none),
  //     ),
  //   );

  //   return elements;
  // }

  Future<bool> goBack() async {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }
}
