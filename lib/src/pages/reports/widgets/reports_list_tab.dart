import 'package:flutter/material.dart';

import 'package:snowin/src/pages/reports/widgets/report_tile.dart';


class ReportsListTab extends StatelessWidget {

  final List reports;

  ReportsListTab({
    @required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical:15),
      child: ListView.builder (
        padding: EdgeInsets.only(bottom: size.height*0.12),
        itemCount: reports.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ReportTile(report: reports[index]);
        }
      )
    );
  }

}