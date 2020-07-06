import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/pages/drawer/widget/custom_appbar_drawer.dart';
import 'package:snowin/src/widgets/custom_benefit_card.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';

class MyBenefits extends StatelessWidget {
  MyBenefits({Key key}) : super(key: key);
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
              title: "MIS BENEFICIOS",
            ),
            preferredSize: Size(double.infinity, 70)),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 3,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Historial de beneficios utilizados',
                style: TextStyle(fontSize: 22),
              ),
              // Expanded(
              //   flex: 3,
              //   child: Consumer<BenefitProvider>(
              //     builder: (context, benefit, _) => ListView.builder(
              //         scrollDirection: Axis.vertical,
              //         itemCount: benefit.listBenefit.length,
              //         itemBuilder: (BuildContext context, int index) =>
              //             benefit.listBenefit.isEmpty
              //                 ? SizedBox()
              //                 : BenefitCard(
              //                     benefit: benefit.listBenefit[index],
              //                     action: () => null)),
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: CustomFabIcon(
            heroTag: "btnFilterBenefits",
            icon: Icons.filter_list,
            action: () => null,
            isPrimary: false,
          ),
        ));
  }
}
