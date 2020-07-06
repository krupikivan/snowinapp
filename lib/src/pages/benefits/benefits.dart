import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/widgets/custom_appbar_pages.dart';
import 'package:snowin/src/widgets/custom_benefit_card.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';

import '../../widgets/custom_bottom_menu.dart';

class Benefits extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();

  final TextEditingController controller;

  Benefits({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goBack(context),
      child: Scaffold(
        key: scaffoldDrawer,
        appBar: PreferredSize(
            child: CustomAppbarPages(
              scaffoldDrawer: scaffoldDrawer,
              back: false,
              context: context,
              title: "BENEFICIOS",
            ),
            preferredSize: Size(double.infinity, 70)),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 3,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      hintText: '10 beneficios en Chapelco',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.all(13),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15))))),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                    child: Text('BANNER PUBLICITARIO',
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              Expanded(
                flex: 3,
                child: Consumer<BenefitProvider>(
                  builder: (context, benefit, _) => benefit.listBenefit.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: benefit.listBenefit.length,
                          itemBuilder: (BuildContext context, int index) =>
                              BenefitCard(
                                benefit: benefit.listBenefit[index],
                                action: () {
                                  benefit.benefitTapped =
                                      benefit.listBenefit[index];
                                  Navigator.pushNamed(
                                      context, '/benefitDetail');
                                },
                              )),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomFabIcon(
                  heroTag: "btnFilter",
                  isPrimary: false,
                  icon: Icons.filter_list,
                  action: () => null),
              SizedBox(
                width: 15,
              ),
              CustomFabIcon(
                  heroTag: "btnScan",
                  isPrimary: true,
                  icon: Icons.camera_enhance,
                  action: () => null),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> goBack(context) async {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }
}
