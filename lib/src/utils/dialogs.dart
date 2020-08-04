import 'package:flutter/material.dart';

class DialogHelper {
  /// Simple Dialog
  static void showSimpleDialog(context, text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            backgroundColor: Color.fromRGBO(255, 224, 0, 1),
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      text,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  /// Spinning Dialog
  static void showSpinDialog(context, text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            backgroundColor: Color.fromRGBO(255, 224, 0, 1),
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: new CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    title: Text(
                      text,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Notice Dialog
  static void showNoticeDialog(context, text) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Información'),
          backgroundColor: Color.fromRGBO(255, 224, 0, 1),
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Warning Dialog
  static void showWarningDialog(context, text) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Alerta'),
          backgroundColor: Color.fromRGBO(255, 224, 0, 1),
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Error Dialog
  static void showErrorDialog(context, text) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Color.fromRGBO(255, 224, 0, 1),
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
