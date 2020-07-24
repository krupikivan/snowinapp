import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorConnection extends StatelessWidget {
  const ErrorConnection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.12, vertical: size.width * 0.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey[200])),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Center(
            child: Text(
          'Verifique su conexion',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Theme.of(context).primaryColor),
        )),
      ),
    );
  }
}
