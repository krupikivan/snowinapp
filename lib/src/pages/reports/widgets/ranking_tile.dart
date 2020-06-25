import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:snowin/src/models/ranking.dart';

import 'package:snowin/src/pages/reports/widgets/ranking.dart';
import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/pages/reports/widgets/total_comments.dart';



class RankingTile extends StatefulWidget {
  final Ranking ranking;
  final int index;
  final AfterSendCallback afterSend;

  RankingTile({ Key key, this.ranking, this.index, this.afterSend}) : super(key: key);

  @override
  RankingTileState createState() => new RankingTileState(ranking, index);
}

class RankingTileState extends State<RankingTile> {
  Ranking ranking;
  int index;

  RankingTileState(this.ranking, this.index);



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
      width: size.width,
      margin: EdgeInsets.symmetric(vertical:8,),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: index == 0 ? Color.fromRGBO(255, 224, 0, 1.0) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(29, 29, 27, 0.5),
            spreadRadius: 0.0,
            blurRadius: 3.0,
            offset: Offset(0.0, 0.0),
          ),
        ]
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                _avatar(ranking.image.toString(), size),
                SizedBox(width: 10,),
                _description(
                  user: ranking.user.toString(),
                  reports: ranking.reports.toString(),
                  points: ranking.points.toString(),
                  level: ranking.level.toString(),
                  awards: ranking.awards.toString(),
                  size: size,
                  context: context,
                  position: ranking.position.toString()
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width*0.35,
                  child: Time(time: ranking.time.toString())
                ),
                Container(
                  width: size.width*0.46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RankingW(ranking: ranking.ranking.toString(), votes: ranking.votes.toString()),
                      TotalComments(total: ranking.comments.toString(),),
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

  Widget _avatar(String image, Size size) {
    return Container(
      width: 0.15*size.width,
      height: 0.15*size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _description({BuildContext context, String position, String user, String level, String reports, String points, String awards, Size size}) {
    return Container(
      width: 0.7*size.width,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(user, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color.fromRGBO(159, 159, 159, 1)),),
                  AutoSizeText(level, style: TextStyle(fontSize: 13),),
                ],
              ),
              Container(
                alignment: Alignment.center,
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: AutoSizeText(position, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AutoSizeText("$reports reportes - $points pts", style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),)
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(29, 29, 27, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FaIcon(FontAwesomeIcons.trophy, size: 10, color: Color.fromRGBO(255, 224, 0, 1.0),),
                  ),
                  SizedBox(width: 5,),
                  AutoSizeText("$awards premios", style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}

typedef AfterSendCallback = void Function();

