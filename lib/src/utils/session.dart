import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/pist.dart';



class Session {
  final _preferences = new Preferences();

  User _user;
  SkiCenter _center;
  Pist _pist;
  List<Pist> _recomendedTraks = List<Pist>();
  List<User> _closestFriends = List<User>();

  bool _showReportWarnning = true;



  //Singleton
  static Session _instance = new Session._internal();
  factory Session() {
    return _instance;
  }
  Session._internal() {
    _user = null;
  }



  Preferences get preferences => _preferences;

  User get user => _user;
  set user(newVal) => _user = newVal;
  void saveUserData(dynamic userData) {
    //save user data
    _user = new User.map(userData);
  }

  SkiCenter get center => _center;
  set center(newVal) => _center = newVal;

  Pist get pist => _pist;
  set pist(newVal) => _pist = newVal;

  List<Pist> get recomendedTraks => _recomendedTraks;
  set recomendedTraks(newVal) => _recomendedTraks = newVal;

  List<User> get closestFriends => _closestFriends;
  set closestFriends(newVal) => _closestFriends = newVal;

  bool get showReportWarnning => _showReportWarnning;
  set showReportWarnning(newVal) => _showReportWarnning = newVal;

}
