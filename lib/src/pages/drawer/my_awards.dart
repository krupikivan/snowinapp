import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:snowin/src/pages/drawer/provider/award_provider.dart';
import 'package:snowin/src/pages/drawer/widget/award_card.dart';
import 'package:snowin/src/pages/drawer/widget/custom_appbar_drawer.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/main_menu.dart';

class MyAwards extends StatelessWidget {
  MyAwards({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldDrawer,
        appBar: PreferredSize(
            child: CustomAppbarDrawer(
              scaffoldDrawer: scaffoldDrawer,
              context: context,
              showLogo: false,
              title: "MIS PREMIOS",
            ),
            preferredSize: Size(double.infinity, 70)),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: MainMenu(
          item: 3,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          // child: Consumer<AwardsProvider>(
          //   builder: (context, award, _) => award.listAward.isEmpty
          //       ? _noAwards()
          //       : Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Text(
          //               _getText(award.listAward.length),
          //               style: TextStyle(fontSize: 22),
          //             ),
          //             Expanded(
          //               flex: 3,
          //               child: Consumer<AwardsProvider>(
          //                 builder: (context, award, _) => ListView.builder(
          //                     itemCount: award.listAward.length,
          //                     itemBuilder: (BuildContext context, int index) =>
          //                         AwardCard(award: award.listAward[index])),
          //               ),
          //             ),
          //           ],
          //         ),
          // ),
        ));
  }

  String _getText(int length) {
    switch (length) {
      case 1:
        return 'Obtuviste $length premio';
        break;
      default:
        return 'Obtuviste $length premios';
        break;
    }
  }

  Widget _noAwards() {
    return Center(
        child: Text(
      'No existen premios ganados',
      style: TextStyle(fontSize: 25),
    ));
  }
}
