import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:snowin/src/models/connection_status.dart';

class ConnectivityProvider {
  StreamController<ConnectionStatus> _statusController =
      StreamController.broadcast();
  Stream<ConnectionStatus> get statusController => _statusController.stream;

  Connectivity connectivity = Connectivity();

  ConnectivityProvider() {
    _statusController = StreamController<ConnectionStatus>();
    _invokeListener();
  }

  _invokeListener() async {
    connectivity.checkConnectivity().then((result) {
      _statusController.sink.add(_getConnectivityResult(result));
    });

    connectivity.onConnectivityChanged.listen((result) {
      _statusController.sink.add(_getConnectivityResult(result));
    });
  }

  ConnectionStatus _getConnectivityResult(connectivityResult) {
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      return ConnectionStatus(status: Status.HasConnection);
    } else {
      return ConnectionStatus(status: Status.NoConnection);
    }
  }

  Future<bool> check() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}
