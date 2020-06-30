import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/benefit.dart';

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

  void getBenefits() {
    final List<Benefit> _list = [];
    final Benefit benefit1 = Benefit.fromMap(
        'https://www.chapelcogolf.com/wp-content/uploads/2016/08/Nuevo-Edificio-Club-House-Chapelco-Golf-Resort-2014-DAC_1888-copia-copia-copia.jpg',
        'Cerro Chapelco',
        '10%',
        'Pases, equipos y clases grupales');
    final Benefit benefit2 = Benefit.fromMap(
        'https://d2bgjx2gb489de.cloudfront.net/gbb-blogs/wp-content/uploads/2016/11/03174444/Mountains-ski-resort-Bad-Gastein-Austria-71155632.jpg',
        'Austria Ski Ranch',
        '20%',
        'Lun a jueves de 18 a 20 hs');
    final Benefit benefit3 = Benefit.fromMap(
        'https://q-cf.bstatic.com/images/hotel/max1280x900/880/88071318.jpg',
        'Las leñas',
        '10%',
        'Pases, equipos y clases grupales');
    _list.add(benefit1);
    _list.add(benefit3);
    _list.add(benefit2);
    _listBenefit = _list;
    notifyListeners();
  }

  Benefit _benefitTapped;

  Benefit get benefitTapped => _benefitTapped;

  set benefitTapped(Benefit benefit) {
    _benefitTapped = benefit;
    notifyListeners();
  }
}
