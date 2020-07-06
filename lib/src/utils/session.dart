import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/models/item_kv.dart';
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
  bool _showLocationWarnning = true;
  bool _showReportDetailTutorial = true;

  List<ItemKV> _calidadNieveItems;
  List<ItemKV> _climaItems;
  List<ItemKV> _vientoItems;
  List<ItemKV> _sensacionGeneralItems;
  List<ItemKV> _esperaMediosItems;



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

  bool get showLocationWarnning => _showLocationWarnning;
  set showLocationWarnning(newVal) => _showLocationWarnning = newVal;

  bool get showReportDetailTutorial => _showReportDetailTutorial;
  set showReportDetailTutorial(newVal) => _showReportDetailTutorial = newVal;

  List<ItemKV> get calidadNieveItems => _calidadNieveItems;
  set calidadNieveItems(newVal) => _calidadNieveItems = newVal;

  List<ItemKV> get climaItems => _climaItems;
  set climaItems(newVal) => _climaItems = newVal;

  List<ItemKV> get vientoItems => _vientoItems;
  set vientoItems(newVal) => _vientoItems = newVal;

  List<ItemKV> get sensacionGeneralItems => _sensacionGeneralItems;
  set sensacionGeneralItems(newVal) => _sensacionGeneralItems = newVal;

  List<ItemKV> get esperaMediosItems => _esperaMediosItems;
  set esperaMediosItems(newVal) => _esperaMediosItems = newVal;

}
