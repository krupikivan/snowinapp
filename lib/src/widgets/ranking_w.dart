import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:snowin/src/utils/app_localization.dart';

class RankingW extends StatefulWidget {
  final String title;
  final double rating;
  final int rateCount;
  final AfterRateCallback afterRate;

  RankingW(
      {Key key,
      this.title = 'Valora',
      this.rating = 0.0,
      this.rateCount = 5,
      this.afterRate})
      : super(key: key);

  @override
  RankingWState createState() => new RankingWState(title, rating, rateCount);
}

class RankingWState extends State<RankingW> {
  String title;
  int rateCount;
  double rating;

  RankingWState(this.title, this.rating, this.rateCount);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          AutoSizeText(title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          SmoothStarRating(
              allowHalfRating: false,
              onRatingChanged: (val) {
                setState(() {
                  rating = val;
                });
              },
              starCount: rateCount,
              rating: rating,
              size: size.width * 0.09,
              defaultIconData: Icons.ac_unit,
              filledIconData: Icons.ac_unit,
              halfFilledIconData: Icons.ac_unit,
              color: Colors.black,
              borderColor: Colors.grey,
              spacing: 0.0),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: RaisedButton(
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: AutoSizeText(
                    _t(context, "cancel").toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    print(rating);
                    Navigator.pop(context);
                    widget.afterRate(rating);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: AutoSizeText(
                    _t(context, "send").toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }
}

typedef AfterRateCallback = void Function(double value);
