import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/pages/reports/widgets/report_card.dart';
import 'package:snowin/src/utils/dialogs.dart';

class MyReportTiles extends StatelessWidget {
  const MyReportTiles({Key key, this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    return report.allMyReports != null
        ? report.allMyReports.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.all(5.0),
                controller: controller,
                itemCount: report.allMyReports.length + 1,
                itemBuilder: (context, i) {
                  if (i < report.allMyReports.length)
                    return ReportCard(
                      actualReport: report.allMyReports[i],
                      afterValorate: (ranking, votes, message) {
                        if (ranking != 0) {
                          report.allMyReports
                              .firstWhere((element) =>
                                  element.id.toString() ==
                                  report.allMyReports[i].id.toString())
                              .copos = ranking;
                          report.allMyReports
                              .firstWhere((element) =>
                                  element.id.toString() ==
                                  report.allMyReports[i].id.toString())
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
                        title: Text(report.conexion
                            ? 'Verifique su conexion'
                            : 'No hay registros'),
                      ),
                    ],
                  )
        : CircularProgressIndicator();
  }
}
