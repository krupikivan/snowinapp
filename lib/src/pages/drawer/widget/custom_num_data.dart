import 'package:flutter/material.dart';

class CustomNumData extends StatelessWidget {
  const CustomNumData({Key key, this.title, this.number}) : super(key: key);
  final String title;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          number.toString(),
          style: _getStyle(context),
        ),
      ],
    );
  }

  _getStyle(context) {
    switch (title) {
      case 'Mensajes':
        return Theme.of(context)
            .textTheme
            .headline1
            .apply(color: Colors.lightBlue);
        break;
      case 'Solicitudes':
        return Theme.of(context)
            .textTheme
            .headline1
            .apply(color: Colors.purple);
        break;
      default:
        return Theme.of(context).textTheme.headline1;
    }
  }
}
