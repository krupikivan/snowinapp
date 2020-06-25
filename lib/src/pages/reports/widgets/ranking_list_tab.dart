import 'package:flutter/material.dart';

import 'package:snowin/src/pages/reports/widgets/ranking_tile.dart';

class RankingListTab extends StatelessWidget {
  final List ranking;

  RankingListTab({
    @required this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical:15),
      child: ListView.builder (
        padding: EdgeInsets.only(bottom:70),
        itemCount: ranking.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return RankingTile(ranking: ranking[index], index: index);
        }
      )
    );
  }

}