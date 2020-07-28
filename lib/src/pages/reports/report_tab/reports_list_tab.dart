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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    if (mounted)
      Provider.of<ReportProvider>(context, listen: false).fetchData(true);
  }
}
