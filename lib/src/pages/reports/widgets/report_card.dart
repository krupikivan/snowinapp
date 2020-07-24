import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/repository/report_repository.dart';

import 'package:snowin/src/utils/dialogs.dart';

import 'package:snowin/src/models/report.dart';

import 'package:snowin/src/pages/reports/ranking_tab/ranking_vote.dart';
import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/pages/reports/widgets/total_comments.dart';
import 'package:snowin/src/pages/reports/report_detail.dart';
import 'package:snowin/src/widgets/marquee.dart';
import 'package:snowin/src/widgets/comment_w.dart';

class ReportCard extends StatelessWidget {
  final Report actualReport;
  final AfterValorateCallback afterValorate;

  const ReportCard({Key key, this.actualReport, this.afterValorate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reports = Provider.of<ReportProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(29, 29, 27, 0.5),
              spreadRadius: 0.0,
              blurRadius: 3.0,
              offset: Offset(0, 0),
            ),
          ]),
      child: InkWell(
        child: Row(
          children: [
            Container(
              width: size.width * 0.35,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      width: size.width * 0.35,
                      height: 150,
                      fit: BoxFit.cover,
                      image: actualReport.multimedias.isNotEmpty
                          ? NetworkImage(Config.apiImageBaseUrl +
                              actualReport.multimedias.first.ruta.toString())
                          : Image.asset('assets/images/no_image.png',
                                  fit: BoxFit.fill)
                              .image,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Marquee(
                          child: Wrap(children: <Widget>[
                            Icon(
                              Icons.person_pin,
                              color: Colors.white,
                              size: 22,
                            ),
                            Text(
                              actualReport.user.username.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ]),
                          textDirection: TextDirection.ltr,
                          animationDuration: Duration(seconds: 3),
                          backDuration: Duration(milliseconds: 5000),
                          pauseDuration: Duration(milliseconds: 2500),
                        ),
                      ],
                    ),
                    subtitle: AutoSizeText(
                      actualReport.user.nivel.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.55,
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Time(time: actualReport.fecha.toString()),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              actualReport.centro.name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ],
                        ),
                        AutoSizeText(
                          actualReport.comentario.toString().trim().length > 100
                              ? (actualReport.comentario
                                      .toString()
                                      .trim()
                                      .substring(0, 96) +
                                  ' ...')
                              : actualReport.comentario.toString().trim(),
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RankingVote(
                          reportId: actualReport.id.toString(),
                          ranking: actualReport.copos.toString(),
                          votes: actualReport.coposUsuarios.toString(),
                          onValorate: (ranking, votes, message) {
                            afterValorate(ranking, votes, message);
                          },
                        ),
                        InkWell(
                            child: TotalComments(
                                total: actualReport.cantComentarios.toString()),
                            onTap: () {
                              showCommentDialog(context);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          print('go to report detail');
          reports.reportSelected = actualReport;
          // reports.resetPage();
          reports.fetchReportComments();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ReportDetail(
                    // report.reportSelected: report,
                    ),
              ));
        },
      ),
    );
  }

  void showCommentDialog(BuildContext context) {
    print('show comment dialog');
    final size = MediaQuery.of(context).size;

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.width * 0.05),
                      child: Column(
                        children: [
                          CommentW(
                            afterComment: (value) {
                              comenta(value, context);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void comenta(String comment, BuildContext context) {
    print(comment);
    ReportRepository()
        .comentario(actualReport.id.toString(), comment)
        .then((response) {
      print('commenta: ');
      print(response);
      if (response['ok']) {
        // setState(() {
        actualReport.cantComentarios =
            int.parse(actualReport.cantComentarios.toString()) + 1;
        // });
        DialogHelper.showSimpleDialog(context, 'Reporte comentado');
      } else {
        DialogHelper.showErrorDialog(context, 'Error al comentar');
        throw new Exception('Error al comentar');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}

typedef AfterValorateCallback = void Function(
    double ranking, int votes, String message);
