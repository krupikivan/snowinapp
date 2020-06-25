import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:snowin/src/models/report.dart';

import 'package:snowin/src/pages/reports/widgets/ranking.dart';
import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/pages/reports/widgets/total_comments.dart';



class ReportTile extends StatefulWidget {
  final Report report;
  final AfterSendCallback afterSend;

  ReportTile({ Key key, this.report, this.afterSend}) : super(key: key);

  @override
  ReportTileState createState() => new ReportTileState(report);
}

class ReportTileState extends State<ReportTile> {
  Report report;

  ReportTileState(this.report);



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
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person_pin, color: Colors.white, size: 22,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(report.user.username.toString(), style: TextStyle(fontSize: 16, color: Colors.white),),
                          AutoSizeText(report.user.nivel.toString(), style: TextStyle(fontSize: 14, color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
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
                      AutoSizeText(report.centro.name.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                      AutoSizeText(report.comentario.toString(), style: TextStyle(fontSize: 17),)
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RankingW(ranking: report.copos.toString(), votes: report.user.ranking.toString()),
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

typedef AfterSendCallback = void Function();

