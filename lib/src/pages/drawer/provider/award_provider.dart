import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:snowin/src/models/award.dart';

class AwardsProvider with ChangeNotifier {
  List<Award> _listAward;
  List<Award> get listAward => _listAward;

  set listAward(List<Award> list) {
    _listAward = list;
    notifyListeners();
  }

  AwardsProvider.init() {
    final List<Award> _list = [];
    final String date1 = formatDate('2020-05-05');
    final String date2 = formatDate('2020-06-15');
    String detail = 'GANASTE ALQUILER DE EQUIPAMIENTO EN SNOW RENTAL';
    Award award1 = Award.fromMap(date1, date2, detail);
    _list.add(award1);
    _listAward = _list;
    notifyListeners();
  }

  String formatDate(String date) {
    DateTime parse = DateTime.parse(date);
    return DateFormat("dd/MM/yyyy").format(parse);
  }
}
