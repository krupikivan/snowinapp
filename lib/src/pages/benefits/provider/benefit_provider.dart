import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/benefit.dart';
import 'package:snowin/src/providers/snowin_provider.dart';

class BenefitProvider with ChangeNotifier {
  List<Benefit> _listBenefit = [];

  UnmodifiableListView<Benefit> get listBenefit =>
      UnmodifiableListView(_listBenefit);

  set listBenefit(List<Benefit> list) {
    _listBenefit = list;
    notifyListeners();
  }

  BenefitProvider.init() {
    getBenefits();
  }

  void getBenefits() async {
    SnowinProvider().getBenefits().then((response) {
      print(response);
      if (response['ok']) {
        compute(beneficioFromJson, response['data']['data']).then((value) {
          _listBenefit = value;
          notifyListeners();
        });
      } else {
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
