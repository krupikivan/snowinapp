import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Time extends StatelessWidget {
  final String time;

  Time({
    @required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.clock, color: Color.fromRGBO(143, 143, 142, 1),size: 16,),
          SizedBox(width: 8),
          AutoSizeText(
            time, 
            style: TextStyle(color: Color.fromRGBO(143, 143, 142, 1), fontSize: 12,),
          ),
        ],
      ),
    );
  }
}