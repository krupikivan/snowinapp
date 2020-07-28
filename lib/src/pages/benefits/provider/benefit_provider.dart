import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/benefit.dart';
import 'package:snowin/src/models/my_benefit.dart';
import 'package:snowin/src/repository/benefit_repository.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class BenefitProvider with ChangeNotifier {
  List<Benefit> _listBenefit = [];
  List<MyBenefit> _listMyBenefit = [];

  UnmodifiableListView<Benefit> get listBenefit =>
      UnmodifiableListView(_listBenefit);

  set listBenefit(List<Benefit> list) {
    _listBenefit = list;
    notifyListeners();
  }

  UnmodifiableListView<MyBenefit> get listMyBenefit =>
      UnmodifiableListView(_listMyBenefit);

  set listMyBenefit(List<MyBenefit> list) {
    _listMyBenefit = list;
    notifyListeners();
  }

  //Manage loading data------------------------------
  bool _loading;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  BenefitProvider.init() {
    _loading = false;
    _limit = 10;
    fetchBenefits();
    fetchMyBenefits();
  }

  void refreshing() {
    print(" refreshing ... ");
    _limit = 10;
    fetchBenefits();
  }

  //Manage Limit fetching benefits------------------------------
  int _limit;
  int get limit => _limit;
  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

  void loadMore({bool myBenefits}) {
    _limit += 10;
    if (myBenefits) {
      fetchMyBenefits();
    } else {
      fetchBenefits();
    }
  }

  void fetchBenefits() {
    _loading = true;
    notifyListeners();
    int offset = _limit - 10;
    BenefitRepository()
        .getBenefits(_limit.toString(), offset.toString(), prepareFilters())
        .then((response) async {
      print(response);
      if (response['ok']) {
        print('Cantidad de beneficios: ' +
            response['data']['data'].length.toString());
        if (response['data']['data'].isNotEmpty) {
          await compute(beneficioFromJson, response['data']['data'])
              .then((value) {
            _listBenefit = value;
          });
        }
        _loading = false;
        notifyListeners();
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {
          _loading = false;
          notifyListeners();
        }
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
      _loading = false;
      notifyListeners();
    });
  }

  void fetchMyBenefits() {
    _loading = true;
    notifyListeners();
    int offset = _limit - 10;
    BenefitRepository()
        .getMyBenefits(_limit.toString(), offset.toString(), prepareFilters())
        .then((response) async {
      print(response);
      if (response['ok']) {
        if (response['data']['data'].isNotEmpty) {
          await compute(misBeneficiosFromJson, response['data']['data'])
              .then((value) {
            _listMyBenefit = value;
          });
        }
        _loading = false;
        notifyListeners();
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {
          _loading = false;
          notifyListeners();
        }
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
      _loading = false;
      notifyListeners();
    });
  }

  String prepareFilters() {
    List<String> filters = List<String>();
    return filters.join('&');
  }

  Benefit _benefitTapped;

  Benefit get benefitTapped => _benefitTapped;

  set benefitTapped(Benefit benefit) {
    _benefitTapped = benefit;
    notifyListeners();
  }
}
