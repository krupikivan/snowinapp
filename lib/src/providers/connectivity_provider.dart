import 'package:connectivity/connectivity.dart';

class ConnectivityProvider {
  static final ConnectivityProvider _instancia =
      new ConnectivityProvider._internal();

  factory ConnectivityProvider() {
    return _instancia;
  }

  ConnectivityProvider._internal();

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
