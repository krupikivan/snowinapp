import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:snowin/src/models/report.dart';

import 'package:snowin/src/pages/reports/widgets/ranking_vote.dart';
import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/pages/reports/widgets/total_comments.dart';
import 'package:snowin/src/widgets/marquee.dart';



class ReportsTile extends StatefulWidget {
  final Report report;
  final AfterValorateCallback afterValorate;

  ReportsTile({ Key key, this.report, this.afterValorate}) : super(key: key);

  @override
  ReportsTileState createState() => new ReportsTileState(report);
}

class ReportsTileState extends State<ReportsTile> {
  Report report;

  ReportsTileState(this.report);



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('repaint');
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical:8),
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
        ]
      ),
      child: Row(
        children: [
          Container(
            width: size.width*0.35,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image(
                    width: size.width*0.35,
                    height: 150,
                    fit: BoxFit.cover,
                    image: report.multimedias.isNotEmpty?
                              NetworkImage(report.multimedias.first.ruta.toString())
                              :
                              Image.asset('assets/images/no_image.png',fit: BoxFit.fill).image,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(5),
                  title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Marquee(
                              child: Wrap(
                                  children: <Widget>[
                                    Icon(Icons.person_pin, color: Colors.white, size: 22,),
                                    Text(report.user.username.toString(), style: TextStyle(fontSize: 16, color: Colors.white),),
                                  ]
                              ),
                              textDirection : TextDirection.ltr,
                              animationDuration: Duration(seconds: 3),
                              backDuration: Duration(milliseconds: 5000),
                              pauseDuration: Duration(milliseconds: 2500),
                          ),
                    ],
                  ),
                  subtitle: AutoSizeText(report.user.nivel.toString(), style: TextStyle(fontSize: 14, color: Colors.white),),
                )
              ],
            ),
          ),
          Container(
            width: size.width*0.55,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Time(time: report.fecha.toString()),
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
                                AutoSizeText(report.centro.name.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                              ],
                          ),
                      AutoSizeText(report.comentario.toString().trim().length > 100? (report.comentario.toString().trim().substring(0, 96) + ' ...') : report.comentario.toString().trim(), style: TextStyle(fontSize: 17),)
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RankingVote(
                        reportId: report.id.toString(),
                        ranking: report.copos.toString(),
                        votes: report.user.ranking.toString(),
                        onValorate: (value, message) {
                            widget.afterValorate(value, message);
                        },),
                      TotalComments(total: report.cantComentarios.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

typedef AfterValorateCallback = void Function(double value, String message);

