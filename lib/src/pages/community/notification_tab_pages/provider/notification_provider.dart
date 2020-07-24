import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/item_kv.dart';
import 'package:snowin/src/models/notifications.dart';
import 'package:snowin/src/repository/community_repository.dart';

class NotificationProvider with ChangeNotifier {
  List<Notifications> _notificationList = [];
  UnmodifiableListView<Notifications> get notificationList =>
      UnmodifiableListView(_notificationList);
  set notificationList(List<Notifications> notificationList) {
    _notificationList = notificationList;
    notifyListeners();
  }

  //Manage Limit fetching------------------------------
  int _limit;
  int get limit => _limit;
  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

  //Manage loading data------------------------------
  bool _loading;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _title;
  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String _comment;
  String get comment => _comment;
  set comment(String value) {
    _comment = value;
    notifyListeners();
  }

  String _sensacionGeneral;
  String get sensacionGeneral => _sensacionGeneral;
  set sensacionGeneral(String value) {
    _sensacionGeneral = value;
    notifyListeners();
  }

  String _calidadNieve;
  String get calidadNieve => _calidadNieve;
  set calidadNieve(String value) {
    _calidadNieve = value;
    notifyListeners();
  }

  String _clima;
  String get clima => _clima;
  set clima(String value) {
    _clima = value;
    notifyListeners();
  }

  bool _sortIdNotifications;
  bool get sortIdNotifications => _sortIdNotifications;
  set sortIdNotifications(bool value) {
    _sortIdNotifications = value;
    notifyListeners();
  }

  bool _sortSeed;
  bool get sortSeed => _sortSeed;
  set sortSeed(bool value) {
    _sortSeed = value;
    notifyListeners();
  }

  bool _sortCalificacion;
  bool get sortCalificacion => _sortCalificacion;
  set sortCalificacion(bool value) {
    _sortCalificacion = value;
    notifyListeners();
  }

  String _esperaMedios;
  String get esperaMedios => _esperaMedios;
  set esperaMedios(String value) {
    _esperaMedios = value;
    notifyListeners();
  }

  String _viento;
  String get viento => _viento;
  set viento(String value) {
    _viento = value;
    notifyListeners();
  }

//Manage Calidad nieve------------------------------
  List<ItemKV> _calidadNieveItems;
  List<ItemKV> get calidadNieveItems => _calidadNieveItems;
  set calidadNieveItems(List<ItemKV> value) {
    _calidadNieveItems = value;
    notifyListeners();
  }

//Manage Tracking item------------------------------
  List<ItemKV> _trackItems;
  List<ItemKV> get trackItems => _trackItems;
  set trackItems(List<ItemKV> value) {
    _trackItems = value;
    notifyListeners();
  }

//Manage Clima item------------------------------
  List<ItemKV> _climaItems;
  List<ItemKV> get climaItems => _climaItems;
  set climaItems(List<ItemKV> value) {
    _climaItems = value;
    notifyListeners();
  }

//Manage Viento item------------------------------
  List<ItemKV> _vientoItems;
  List<ItemKV> get vientoItems => _vientoItems;
  set vientoItems(List<ItemKV> value) {
    _vientoItems = value;
    notifyListeners();
  }

//Manage Sensacion general item------------------------------
  List<ItemKV> _sensacionGeneralItems;
  List<ItemKV> get sensacionGeneralItems => _sensacionGeneralItems;
  set sensacionGeneralItems(List<ItemKV> value) {
    _sensacionGeneralItems = value;
    notifyListeners();
  }

//Manage Sensacion general item------------------------------
  List<ItemKV> _esperaMediosItems;
  List<ItemKV> get esperaMediosItems => _esperaMediosItems;
  set esperaMediosItems(List<ItemKV> value) {
    _esperaMediosItems = value;
    notifyListeners();
  }

//Manage Medias------------------------------
  List<ItemKV> _medias;
  List<ItemKV> get medias => _medias;
  set medias(List<ItemKV> value) {
    _medias = value;
    notifyListeners();
  }

  void pageSum() {
    _page++;
    notifyListeners();
  }

//Handle conection error------------------------------
  bool _hasConnection;
  bool get hasConnection => _hasConnection;
  set hasConnection(bool value) {
    _hasConnection = value;
    notifyListeners();
  }

  bool _showTopButon;
  bool get showTopButon => _showTopButon;
  set showTopButon(bool value) {
    _showTopButon = value;
    notifyListeners();
  }

  int _page;
  int get page => _page;
  set page(int value) {
    _page = value;
    notifyListeners();
  }

  NotificationProvider.init() {
    _limit = 10;
    _page = 0;
    _loading = false;
    _hasConnection = false;
    _showTopButon = false;
    getNotifications();
  }

  Future<void> refreshing() {
    print(" refreshing ... ");
    notifyListeners();
    getNotifications(limit: 10);
  }

  void changeLoading() {
    if (_loading) {
      _loading = false;
    } else {
      _loading = true;
    }
    notifyListeners();
  }

  void startLoader() {
    getNotifications();
  }

  Future<List<Notifications>> getNotifications({int sum, int limit}) async {
    List<Notifications> _list = new List<Notifications>();
    int offset = 0;
    _limit = sum != null ? _limit + sum : _limit;
    List<Notifications> elements = new List<Notifications>();
    await CommunityRepository()
        .notifications(limit.toString(), offset.toString(), prepareFilters())
        .then((response) {
      print('notificaciones');
      print(response);
      if (response['ok']) {
        _hasConnection = true;
        final _castDataType =
            response['data']['data'].cast<Map<String, dynamic>>();
        _list = _castDataType
            .map<Notifications>((json) => Notifications.map(json))
            .toList();
        if (response['data']['data'].isNotEmpty) {
          _notificationList = _list;
          notifyListeners();
        }
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {
          _hasConnection = false;
          notifyListeners();
        }
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });

    return elements;
  }

  String prepareFilters() {
    List<String> filters = List<String>();
    // if(_title.isNotEmpty) filters.add('filtros[titulo]='+_title);
    // if(_comment.isNotEmpty) filters.add('filtros[comentario]='+_comment);
    // if(_calidadNieve.isNotEmpty) filters.add('filtros[calidad_nieve]='+_calidadNieve);
    // if(_clima.isNotEmpty) filters.add('filtros[clima]='+_clima);
    // if(_viento.isNotEmpty) filters.add('filtros[viento]='+_viento);
    // if(_esperaMedios.isNotEmpty) filters.add('filtros[espera_medios]='+_esperaMedios);

    // filters.add(_sortIdNotifications
    //     ? 'ordenes[idnotificaciones]=ASC'
    //     : 'ordenes[idnotificaciones]=DESC');
    // filters.add(_sortSeed ? 'ordenes[visto]=ASC' : 'ordenes[visto]=DESC');

    // return filters.join('&');
  }
}
