import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/pages/reports/widgets/fab_widget.dart';
import 'package:snowin/src/pages/reports/report_tab/report_tiles.dart';

class ReportsListTab extends StatefulWidget {
  ReportsListTab({Key key}) : super(key: key);

  @override
  ReportsListTabState createState() => new ReportsListTabState();
}

class ReportsListTabState extends State<ReportsListTab> {
  double deviceHeight = 0;
  bool _showTopButon = false;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(scrollListener);
    Provider.of<ReportProvider>(context, listen: false).startLoader(false);
  }

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: RefreshIndicator(
          key: refreshkey,
          child: Stack(
            children: <Widget>[
              ReportTiles(
                controller: _scrollController,
              ),
              FabWidget(
                scrollController: _scrollController,
              ),
            ],
          ),
          onRefresh: () async {
            refreshkey.currentState.show(atTop: true);
            report.refreshing(false);
          }),
    );
  }

  void scrollListener() {
    if (_scrollController.position.pixels > deviceHeight) {
      if (!_showTopButon) {
        setState(() {
          _showTopButon = true;
        });
      }
    } else {
      if (_showTopButon) {
        setState(() {
          _showTopButon = false;
        });
      }
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    if (mounted)
      Provider.of<ReportProvider>(context, listen: false).changeLoading();
    fetchData();
  }

  void fetchData() async {
    final report = Provider.of<ReportProvider>(context, listen: false);
    await report.fetchAllReports(); //.then((elements) {
    if (mounted) {
      if (report.page == 0) {
        // report.clearReports();
      }
      report.changeLoading();
      report.pageSum();
    }
  }

  void showWarningsDialog(String message) {
    print('show warnings dialog');
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 224, 0, 1),
                        border: Border.all(style: BorderStyle.none),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: ListTile(
                      title: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0)),
                          ListTile(
                            title: Text(
                              message,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              softWrap: true,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
