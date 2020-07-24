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
    fetchBenefits();
    fetchMyBenefits();
  }

  void fetchBenefits() {
    _loading = true;
    notifyListeners();
    BenefitRepository().getBenefits().then((response) {
      print(response);
      if (response['ok']) {
        _loading = false;
        compute(beneficioFromJson, response['data']['data']).then((value) {
          _listBenefit = value;
          notifyListeners();
        });
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {
          _loading = false;
          notifyListeners();
        }
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  void fetchMyBenefits() {
    _loading = true;
    notifyListeners();
    BenefitRepository().getMyBenefits().then((response) {
      print(response);
      if (response['ok']) {
        compute(misBeneficiosFromJson, response['data']['data']).then((value) {
          _listMyBenefit = value;
          notifyListeners();
        });
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {
          _loading = false;
          notifyListeners();
        }
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Benefit _benefitTapped;

  Benefit get benefitTapped => _benefitTapped;

  set benefitTapped(Benefit benefit) {
    _benefitTapped = benefit;
    notifyListeners();
  }
}
