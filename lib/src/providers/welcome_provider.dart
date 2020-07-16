import 'package:flutter/material.dart';
import 'package:snowin/src/repository/snowin_repository.dart';
import '../models/slider_model.dart';

class WelcomeProvider with ChangeNotifier {
  SnowinRepository snowinprovider = SnowinRepository();

  List<SliderModel> _listSlider;
  List<SliderModel> get listSlider => _listSlider;
  set listSlider(List<SliderModel> list) {
    _listSlider = list;
    notifyListeners();
  }

  WelcomeProvider.init() {
    _obtenerWelcome();
  }

  _obtenerWelcome() async {
    Map respList = await snowinprovider.obtenerwellcome();
    List<SliderModel> _list = [];
    if (respList['ok']) {
      if (respList['data'] != null) {
        respList['data'].forEach((element) {
          SliderModel item = SliderModel.fromMap(element);
          _list.add(item);
        });
      }
      _listSlider = _list;
      notifyListeners();
    }
  }
}
