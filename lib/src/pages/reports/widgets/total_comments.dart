import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TotalComments extends StatelessWidget {
  final String total;

  TotalComments({
    @required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.message, size: 14, color: Theme.of(context).primaryColor),
        SizedBox(width: 2),
        AutoSizeText(total, style: TextStyle(fontSize: 16),),
      ],
    );
  }
}