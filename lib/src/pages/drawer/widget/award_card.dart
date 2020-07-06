import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snowin/src/models/award.dart';

class AwardCard extends StatelessWidget {
  const AwardCard({Key key, this.award}) : super(key: key);
  final Award award;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(13)),
        border: Border.all(width: 1, color: Colors.grey[400]),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            isThreeLine: true,
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                      width: 2, style: BorderStyle.solid, color: Colors.white)),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(FontAwesomeIcons.award, color: Colors.yellow),
              ),
            ),
            title: _getText('El ${award.date1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getText(award.detail),
                _getText('por tus reportes.'),
                SizedBox(height: 10),
                _getText('CANJEASTE ESTE PREMIO'),
                _getText(award.date2.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getText(String txt) {
    return Text(
      txt,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 19),
    );
  }
}
