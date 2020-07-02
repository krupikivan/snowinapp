import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:snowin/src/providers/snowin_provider.dart';



class RankingVote extends StatefulWidget {
  final String reportId;
  final String ranking;
  final String votes;
  final OnValorateCallback onValorate;

  RankingVote({ Key key, @required this.reportId, @required this.ranking, @required this.votes, this.onValorate}) : super(key: key);

  @override
  RankingVoteState createState() => new RankingVoteState(reportId, ranking, votes);
}

class RankingVoteState extends State<RankingVote> {
  String reportId;
  String ranking;
  String votes;

  RankingVoteState(this.reportId, this.ranking, this.votes);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SmoothStarRating(
              allowHalfRating: false,
              onRatingChanged: (val) => valorar(val),
              starCount: 5,
              rating: double.parse(ranking),
              size: 20.0,
              defaultIconData: Icons.ac_unit,
              filledIconData: Icons.ac_unit,
              halfFilledIconData: Icons.ac_unit,
              color: Colors.black,
              borderColor: Colors.grey,
              spacing:0.0
          ),
          SizedBox(width: 5,),
          AutoSizeText(votes, style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }

  void valorar(double copos) {
    SnowinProvider().valorar(reportId, copos.round().toString()).then((response) { print('valorar: '); print(response);
          if(response['ok'] && response['data'] == true) {
              widget.onValorate(copos, '');
              setState(() {});
          } else {
              widget.onValorate(0, response['data']['message']);
              throw new Exception(response['data']['message']);
          }
      }).catchError((error) {
          print(error.toString());
      });
  }

}


typedef OnValorateCallback = void Function(double value, String message);