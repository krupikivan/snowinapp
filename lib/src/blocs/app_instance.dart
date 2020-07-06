import 'package:flutter/material.dart';

class AppInstance extends InheritedWidget {
  static AppInstance _instancia;

  factory AppInstance({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new AppInstance._internal(key: key, child: child);
    }
    return _instancia;
  }

  AppInstance._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
