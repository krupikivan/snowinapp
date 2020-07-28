import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/widgets/custom_appbar_pages.dart';
import 'package:snowin/src/widgets/custom_benefit_card.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';
import 'package:snowin/src/widgets/error_connection.dart';

import '../../widgets/custom_bottom_menu.dart';

class Benefits extends StatefulWidget {
  final TextEditingController controller;

  Benefits({Key key, this.controller}) : super(key: key);

  @override
  _BenefitsState createState() => _BenefitsState();
}

class _BenefitsState extends State<Benefits> {
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final conex = Provider.of<ConnectionStatus>(context);
    return WillPopScope(
      onWillPop: () => goBack(context),
      child: RefreshIndicator(
          key: refreshkey,
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
            body: conex != null && conex.status == Status.HasConnection
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextField(
                            controller: widget.controller,
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                contentPadding: const EdgeInsets.all(13),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))))),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                        ),
                        Expanded(
                          flex: 3,
                          child: Consumer<BenefitProvider>(
                            builder: (context, benefit, _) => benefit
                                    .listBenefit.isNotEmpty
                                ? ListView.builder(
                                    controller: _scrollController,
                                    itemCount: benefit.listBenefit.length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        BenefitCard(
                                          benefit: benefit.listBenefit[index],
                                          action: () {
                                            benefit.benefitTapped =
                                                benefit.listBenefit[index];
                                            Navigator.pushNamed(
                                                context, '/benefitDetail');
                                          },
                                        ))
                                : benefit.loading
                                    ? Center(child: CircularProgressIndicator())
                                    : ListTile(
                                        title: Text(
                                            'No hay beneficios por el momento'),
                                      ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ErrorConnection(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
                conex.status != null && conex.status == Status.HasConnection
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Consumer<BenefitProvider>(
                          builder: (context, bene, _) => bene.loading
                              ? CircularProgressIndicator()
                              : Row(
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
                      )
                    : SizedBox(),
          ),
          onRefresh: () async {
            refreshkey.currentState.show(atTop: true);
            Provider.of<BenefitProvider>(context, listen: false).refreshing();
          }),
    );
  }

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<BenefitProvider>(context, listen: false)
          .loadMore(myBenefits: false);
    }
  }

  Future<bool> goBack(context) async {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }
}
