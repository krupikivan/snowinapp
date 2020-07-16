import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RankingW extends StatelessWidget {
  final String ranking;
  final String votes;

  RankingW({
    @required this.ranking,
    @required this.votes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _generateStart(int.parse(ranking)),
          SizedBox(width: 5,),
          AutoSizeText(votes, style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }

  Widget _generateStart(int ranking){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Icon(Icons.ac_unit, color: (index < ranking)?Color.fromRGBO(29, 29, 27, 1.0):Color.fromRGBO(159, 159, 159, 1.0), size: 14,)
        );
      }),
    );
  }
}