import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/pages/reports/widgets/report_card.dart';
import 'package:snowin/src/utils/dialogs.dart';

class ReportTiles extends StatelessWidget {
  const ReportTiles({Key key, this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    return report.allReports != null
        ? report.allReports.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.all(5.0),
                controller: controller,
                scrollDirection: Axis.vertical,
                itemCount: report.allReports.length + 1,
                itemBuilder: (context, i) {
                  if (i < report.allReports.length)
                    return ReportCard(
                      actualReport: report.allReports[i],
                      afterValorate: (ranking, votes, message) {
                        if (ranking != 0) {
                          report.allReports
                              .firstWhere((element) =>
                                  element.id.toString() ==
                                  report.allReports[i].id.toString())
                              .copos = ranking;
                          report.allReports
                              .firstWhere((element) =>
                                  element.id.toString() ==
                                  report.allReports[i].id.toString())
                              .coposUsuarios = votes;
                          DialogHelper.showSimpleDialog(
                              context, 'Reporte evaluado');
                        } else {
                          DialogHelper.showErrorDialog(context, message);
                        }
                      },
                    );
                  else
                    return SizedBox(height: 70.0);
                })
            : report.isLoading
                ? ListTile(
                    title: Text('Buscando ...'),
                  )
                : ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('No hay registros'),
                      ),
                    ],
                  )
        : CircularProgressIndicator();
  }
}
