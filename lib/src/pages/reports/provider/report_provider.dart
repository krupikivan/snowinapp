import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/item_kv.dart';
import 'package:snowin/src/models/report.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/models/report_comments.dart';
import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/pist.dart';
import 'package:snowin/src/repository/report_repository.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class ReportProvider with ChangeNotifier {
  ReportProvider.init() {
    initiateData();
    fetchClosestFriends();
    fetchAllReports(false);
    fetchAllMyReports(false);
    loadEmuns();
    detalleCentroSki();
  }

  void initiateData() {
    _showReportWarnning = true;
    _showLocationWarnning = true;
    _showReportDetailTutorial = true;
    _isLoading = false;
    _sortIdReporte = false;
    _sortFecha = false;
    _sortCalificacion = false;
    _showTopButon = false;
    _showWarningDialog = false;
    _dialogBottomVisible = false;
    _dialogTopVisible = false;
    _shareFacebook = false;
    _shareInstagram = false;
    _showed = false;
    _speed = false;
    _title = '';
    _comment = '';
    _calidadNieve = '';
    _clima = '';
    _limit = 10;
    _esperaMedios = '';
    _sensacionGeneral = '';
    _track = '';
    _viento = '';
    _reportFrom = [
      ItemKV('', 'Todos'),
      ItemKV('CENTRO_DE_SKI', 'Centro de Ski'),
      ItemKV('PISTA', 'Pista'),
    ];
    _reportFromItem = '';
    // _page = 0;
    _medias = [];
    _pistasRecomendadas = [];
    _mounted = false;
  }

//Manage Ski center------------------------------
  SkiCenter _center;
  SkiCenter get center => _center;
  set center(SkiCenter center) {
    _center = center;
    notifyListeners();
  }

//Manage Pista------------------------------
  Pista _pista;
  Pista get pista => _pista;
  set pista(Pista pista) {
    _pista = pista;
    notifyListeners();
  }

//Manage Report------------------------------
  Report _reportSelected;
  Report get reportSelected => _reportSelected;
  set reportSelected(Report report) {
    _reportSelected = report;
    notifyListeners();
  }

//Scroll mounted------------------------------
  bool _mounted;
  bool get mounted => _mounted;
  set mounted(bool value) {
    _mounted = value;
    notifyListeners();
  }

//Speed------------------------------
  bool _speed;
  bool get speed => _speed;
  set speed(bool value) {
    _speed = value;
    notifyListeners();
  }

//Scroll mounted------------------------------
  bool _showed;
  bool get showed => _showed;
  set showed(bool value) {
    _showed = value;
    notifyListeners();
  }

//Manage New Report------------------------------
  Report _newReport;
  Report get newReport => _newReport;
  set newReport(Report report) {
    _newReport = report;
    notifyListeners();
  }

//Manage Loading data------------------------------
  bool _isLoading;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//Manage Dialog Top------------------------------
  bool _dialogTopVisible;
  bool get dialogTopVisible => _dialogTopVisible;
  set dialogTopVisible(bool value) {
    _dialogTopVisible = value;
    notifyListeners();
  }

//Manage Limit fetching reports------------------------------
  int _limit;
  int get limit => _limit;
  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

//Manage Dialog Bottom------------------------------
  bool _dialogBottomVisible;
  bool get dialogBottomVisible => _dialogBottomVisible;
  set dialogBottomVisible(bool value) {
    _dialogBottomVisible = value;
    notifyListeners();
  }

//Manage Top button------------------------------
  bool _showTopButon;
  bool get showTopButon => _showTopButon;
  set showTopButon(bool value) {
    _showTopButon = value;
    notifyListeners();
  }

//Manage Centro ski warning------------------------------
  List<Pista> _pistasRecomendadas;
  List<Pista> get pistasRecomendadas => _pistasRecomendadas;
  set pistasRecomendadas(List<Pista> list) {
    _pistasRecomendadas = list;
    notifyListeners();
  }

//Manage Reports List------------------------------
  List<Report> _allReports = [];
  List<Report> get allReports => _allReports;
  set allReports(List<Report> list) {
    _allReports = list;
    notifyListeners();
  }

//Manage My Reports List------------------------------
  List<Report> _allMyReports = [];
  List<Report> get allMyReports => _allMyReports;
  set allMyReports(List<Report> list) {
    _allMyReports = list;
    notifyListeners();
  }

//Manage Reports Comments------------------------------
  List<ReportComments> _allComments = [];
  List<ReportComments> get allComments => _allComments;
  set allComments(List<ReportComments> list) {
    _allComments = list;
    notifyListeners();
  }

//Manage Closest Firends------------------------------
  List<User> _closestFriends;
  List<User> get closestFriends => _closestFriends;
  set closestFriends(List<User> list) {
    _closestFriends = list;
    notifyListeners();
  }

//Manage Show Reporting------------------------------
  bool _showReportWarnning;
  bool get showReportWarnning => _showReportWarnning;
  set showReportWarnning(bool value) {
    _showReportWarnning = value;
    notifyListeners();
  }

//Manage Facebook------------------------------
  bool _shareFacebook;
  bool get shareFacebook => _shareFacebook;
  set shareFacebook(bool value) {
    _shareFacebook = value;
    notifyListeners();
  }

//Manage Instagram------------------------------
  bool _shareInstagram;
  bool get shareInstagram => _shareInstagram;
  set shareInstagram(bool value) {
    _shareInstagram = value;
    notifyListeners();
  }

//Manage Show Location warning------------------------------
  bool _showLocationWarnning;
  bool get showLocationWarnning => _showLocationWarnning;
  set showLocationWarnning(bool value) {
    _showLocationWarnning = value;
    notifyListeners();
  }

//Manage Show Detail tutorial------------------------------
  bool _showReportDetailTutorial;
  bool get showReportDetailTutorial => _showReportDetailTutorial;
  set showReportDetailTutorial(bool value) {
    _showReportDetailTutorial = value;
    notifyListeners();
  }

//Manage Calidad nieve------------------------------
  List<ItemKV> _calidadNieveItems;
  List<ItemKV> get calidadNieveItems => _calidadNieveItems;
  set calidadNieveItems(List<ItemKV> value) {
    _calidadNieveItems = value;
    notifyListeners();
  }

//Manage Reporte de------------------------------
  List<ItemKV> _reportFrom;
  List<ItemKV> get reportFrom => _reportFrom;
  set reportFrom(List<ItemKV> value) {
    _reportFrom = value;
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

  void addMediaToList(ItemKV item) {
    _medias.add(item);
    notifyListeners();
  }

  // void resetPage() {
  //   _page = 0;
  //   notifyListeners();
  // }

  void removeMediaFromList(String mediaS) {
    _medias.removeWhere((element) => element.value.toString() == mediaS);
    notifyListeners();
  }

  void addToReportList(elements) {
    _allReports.addAll(elements);
    notifyListeners();
  }

  void hideTutorial() {
    _showReportDetailTutorial = false;
    notifyListeners();
  }

//TODO: No esta cambiando el estado del alert dialog por el context
  void clearFilters() {
    _title = '';
    _comment = '';
    _track = _trackItems[0].value;
    _calidadNieve = _calidadNieveItems[0].value;
    _clima = _climaItems[0].value;
    _viento = _vientoItems[0].value;
    _sensacionGeneral = _sensacionGeneralItems[0].value;
    _esperaMedios = _esperaMediosItems[0].value;
    _sortIdReporte = false;
    _sortFecha = false;
    _sortCalificacion = false;
    notifyListeners();
  }

  // void pageSum() {
  //   _page++;
  //   notifyListeners();
  // }

  Future<void> fetchAllReports(bool sum, {int limit}) async {
    List<Report> _list = new List<Report>();
    int offset = sum ? _limit : 0;
    _limit = sum ? _limit + 10 : _limit;
    await ReportRepository()
        .reportes(_limit.toString(), offset.toString(), prepareFilters())
        .then((response) {
      print('reporte/listar response: ');
      if (response['ok']) {
        _isLoading = false;
        if (response['data'].isNotEmpty) {
          final _castDataType = response['data'].cast<Map<String, dynamic>>();
          _list =
              _castDataType.map<Report>((json) => Report.map(json)).toList();
          _allReports = _list;
          _isLoading = false;
        }
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> fetchReportComments() async {
    List<ReportComments> _list = new List<ReportComments>();
    // int offset = _page * _limit;
    int offset = 0;
    await ReportRepository()
        .comentarios(
            _limit.toString(), offset.toString(), prepareCommentsFilters())
        .then((response) {
      print('reporte/comentarios response: ');
      if (response['ok']) {
        final _castDataType =
            response['data']['data'].cast<Map<String, dynamic>>();
        _list = _castDataType
            .map<ReportComments>((json) => ReportComments.map(json))
            .toList();
        _allComments = _list;
        notifyListeners();
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> fetchAllMyReports(bool sum, {int limit}) async {
    List<Report> _list = new List<Report>();
    int offset = sum ? _limit : 0;
    _limit = sum ? _limit + 10 : _limit;
    await ReportRepository()
        .reportes(_limit.toString(), offset.toString(), prepareMyFilters())
        .then((response) {
      print('reporte/listar propios response: ');
      if (response['ok']) {
        if (response['data'].isNotEmpty) {
          final _castDataType = response['data'].cast<Map<String, dynamic>>();
          _list =
              _castDataType.map<Report>((json) => Report.map(json)).toList();
          _allMyReports = _list;
        }
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
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

  String _viento;
  String get viento => _viento;
  set viento(String value) {
    _viento = value;
    notifyListeners();
  }

  // int _page;
  // int get page => _page;
  // set page(int value) {
  //   _page = value;
  //   notifyListeners();
  // }

  String _esperaMedios;
  String get esperaMedios => _esperaMedios;
  set esperaMedios(String value) {
    _esperaMedios = value;
    notifyListeners();
  }

  String _reportFromItem;
  String get reportFromItem => _reportFromItem;
  set reportFromItem(String value) {
    _reportFromItem = value;
    notifyListeners();
  }

  String _track;
  String get track => _track;
  set track(String value) {
    _track = value;
    notifyListeners();
  }

  bool _sortIdReporte;
  bool get sortIdReporte => _sortIdReporte;
  set sortIdReporte(bool value) {
    _sortIdReporte = value;
    notifyListeners();
  }

  bool _sortFecha;
  bool get sortFecha => _sortFecha;
  set sortFecha(bool value) {
    _sortFecha = value;
    notifyListeners();
  }

  bool _sortCalificacion;
  bool get sortCalificacion => _sortCalificacion;
  set sortCalificacion(bool value) {
    _sortCalificacion = value;
    notifyListeners();
  }

  bool _showWarningDialog;
  bool get showWarningDialog => _showWarningDialog;
  set showWarningDialog(bool value) {
    _showWarningDialog = value;
    notifyListeners();
  }

  void clearData() {
    _title = '';
    _comment = '';
    _medias.clear();
    _clima = '';
    _viento = '';
    _reportFromItem = '';
    _esperaMedios = '';
    _sensacionGeneral = '';
    notifyListeners();
  }

  void fetchData(bool value) {
    _isLoading = true;
    value ? fetchAllReports(true) : fetchAllMyReports(true);
    notifyListeners();
  }

  void startLoader(bool myReports) {
    if (myReports) {
      fetchAllMyReports(false);
    } else {
      fetchAllReports(false);
    }
  }

  void changeWarningDialog(bool value) {
    _showWarningDialog = value;
    notifyListeners();
  }

  Future<void> sendReport() async {
    _isLoading = true;
    notifyListeners();
    List<File> multimedias = List<File>();
    _medias.forEach((media) {
      multimedias.add(File(media.value));
    });

    await ReportRepository()
        .sendReport(_track, _title, _comment, _calidadNieve, _esperaMedios,
            _viento, _clima, _sensacionGeneral, multimedias)
        .then((response) async {
      if (response['ok']) {
        initiateData();
        fetchAllReports(false);
      } else {
        _isLoading = false;
        notifyListeners();
        throw new Exception('Error');
      }
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error.toString());
    });
  }

  bool formIsValid() {
    return (_track.isNotEmpty &&
        _title.isNotEmpty &&
        _comment.isNotEmpty &&
        _calidadNieve.isNotEmpty &&
        _esperaMedios.isNotEmpty &&
        _viento.isNotEmpty &&
        _clima.isNotEmpty &&
        _sensacionGeneral.isNotEmpty);
  }

  String prepareFilters() {
    List<String> filters = List<String>();
    if (_title.isNotEmpty) filters.add('filtros[titulo]=' + _title);
    if (_comment.isNotEmpty) filters.add('filtros[comentario]=' + _comment);
    if (_calidadNieve.isNotEmpty)
      filters.add('filtros[calidad_nieve]=' + _calidadNieve);
    if (_clima.isNotEmpty) filters.add('filtros[clima]=' + _clima);
    if (_viento.isNotEmpty) filters.add('filtros[viento]=' + _viento);
    if (_esperaMedios.isNotEmpty)
      filters.add('filtros[espera_medios]=' + _esperaMedios);

    filters.add(
        _sortIdReporte ? 'ordenes[idreporte]=ASC' : 'ordenes[idreporte]=DESC');
    filters.add(_sortFecha ? 'ordenes[fecha]=ASC' : 'ordenes[fecha]=DESC');
    filters.add(_sortCalificacion
        ? 'ordenes[calificacion]=ASC'
        : 'ordenes[calificacion]=DESC');

    return filters.join('&');
  }

  String prepareMyFilters() {
    List<String> filters = List<String>();
    filters.add('filtros[propios]=1');
    if (_title.isNotEmpty) filters.add('filtros[titulo]=' + _title);
    if (_comment.isNotEmpty) filters.add('filtros[comentario]=' + _comment);
    if (_calidadNieve.isNotEmpty)
      filters.add('filtros[calidad_nieve]=' + _calidadNieve);
    if (_clima.isNotEmpty) filters.add('filtros[clima]=' + _clima);
    if (_viento.isNotEmpty) filters.add('filtros[viento]=' + _viento);
    if (_esperaMedios.isNotEmpty)
      filters.add('filtros[espera_medios]=' + _esperaMedios);

    filters.add(
        _sortIdReporte ? 'ordenes[idreporte]=ASC' : 'ordenes[idreporte]=DESC');
    filters.add(_sortFecha ? 'ordenes[fecha]=ASC' : 'ordenes[fecha]=DESC');
    filters.add(_sortCalificacion
        ? 'ordenes[calificacion]=ASC'
        : 'ordenes[calificacion]=DESC');

    return filters.join('&');
  }

  String prepareCommentsFilters() {
    List<String> filters = List<String>();
    filters.add('filtros[reporte_id]=${_reportSelected.id}');
    return filters.join('&');
  }

  void clearReports() {
    _allReports.clear();
    notifyListeners();
  }

  void hideDialog(int identifier) {
    if (identifier == 1) {
      _dialogTopVisible = false;
    } else {
      _dialogBottomVisible = false;
    }
    notifyListeners();
  }

  Future refreshing(bool myReports) {
    print(" refreshing ... ");
    // _page = 0;
    _limit = 10;
    notifyListeners();
    if (myReports) {
      fetchAllMyReports(false);
    } else {
      fetchAllReports(false);
    }
    // startLoader(mounted);
  }

  // void startLoader(bool mounted) {
  //   if (mounted) _isLoading = !_isLoading;
  //   fetchAllReports();
  // }

  Future<void> loadTraks() async {
    _trackItems = new List<ItemKV>();
    _trackItems.add(ItemKV('', 'Todos'));
    if (_center != null) {
      _center.pistas.forEach((pista) {
        _trackItems.add(new ItemKV(pista.id, pista.descripcion));
        if (_trackItems.length == 1) _track = pista.id.toString();
      });
    }
  }

  Future<void> fetchClosestFriends() async {
    try {
      var response = await ReportRepository().closestFriends();
      print('coordenadas-amigos response: ');
      if (response['ok']) {
        var data = response['data'];

        final _castDataType = data['amigos_serca'].cast<Map<String, dynamic>>();
        closestFriends =
            _castDataType.map<User>((json) => User.map(json)).toList();
        _dialogBottomVisible = closestFriends.length > 0 ? true : false;
        notifyListeners();
      } else {
        throw new Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future fetchCentroSkiWarning() async {
    try {
      var response = await ReportRepository()
          .centroSkiWarning(); //.then((response) async {
      print('advertencias response: ');
      var data;
      if (response['ok']) {
        data = response['data'];
        if (data != false) {
          if (data is String) {
            if (_showLocationWarnning) {
              _showLocationWarnning = false;
              _dialogTopVisible = _pistasRecomendadas.length > 0 ? true : false;
              return data;
            }
          } else {
            // final _castDataType = data.cast<Map<String, dynamic>>();
            // _pistasRecomendadas =
            //     _castDataType.map<Pista>((json) => Pista.map(json)).toList();
            // _dialogTopVisible = _pistasRecomendadas.length > 0 ? true : false;
          }
          notifyListeners();
        }
      } else {
        throw new Exception('Error');
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<void> centroSki() async {
    try {
      var response = await ReportRepository().centroSki();
      print('centro-ski response: ');
      if (response['ok']) {
        var data = response['data'];
        if (data['centroSki'] != null) {
          _center = SkiCenter.map(data['centroSki']);

          if (_center.pistas.isNotEmpty) {
            loadTraks();
            _pista = _center
                .pistas[0]; //Todo: Se deberia poder cargar la mas cercana
          }

          if (data['pista'] != null) {
            Pista pistaRec = Pista.map(data['pista']);
            _pistasRecomendadas.add(pistaRec);
          }
          notifyListeners();
        }
        // if (data['amigos'] != null) {
        //   final _castDataType = data['amigos'].cast<Map<String, dynamic>>();
        //   _closestFriends =
        //       _castDataType.map<User>((json) => User.map(json)).toList();
        //   notifyListeners();
        // }
      } else {
        throw new Exception('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadEmuns() async {
    await SnowinRepository().loadEmuns().then((response) {
      print('enums response: ');
      if (response['ok']) {
        var data = response['data'];

        //cargar combo calidad_nieve
        if (data.containsKey('calidad_nieve')) {
          _calidadNieveItems = new List<ItemKV>();
          _calidadNieveItems.add(ItemKV('', 'Todos'));
          data['calidad_nieve'].forEach((k, v) {
            _calidadNieveItems.add(new ItemKV(k, v));
            if (_calidadNieveItems.length == 1) _calidadNieve = k.toString();
          });
        }

        //cargar combo clima
        if (data.containsKey('clima')) {
          _climaItems = new List<ItemKV>();
          _climaItems.add(ItemKV('', 'Todos'));
          data['clima'].forEach((k, v) {
            _climaItems.add(new ItemKV(k, v));
            if (_climaItems.length == 1) _clima = k.toString();
          });
        }

        //cargar combo viento
        if (data.containsKey('viento')) {
          _vientoItems = new List<ItemKV>();
          _vientoItems.add(ItemKV('', 'Todos'));
          data['viento'].forEach((k, v) {
            _vientoItems.add(new ItemKV(k, v));
            if (_vientoItems.length == 1) _viento = k.toString();
          });
        }

        //cargar combo sensacion_general
        if (data.containsKey('sensacion_general')) {
          _sensacionGeneralItems = new List<ItemKV>();
          _sensacionGeneralItems.add(ItemKV('', 'Todos'));
          data['sensacion_general'].forEach((k, v) {
            _sensacionGeneralItems.add(new ItemKV(k, v));
            if (_sensacionGeneralItems.length == 1)
              _sensacionGeneral = k.toString();
          });
        }

        //cargar combo espera_medios
        if (data.containsKey('espera_medios')) {
          _esperaMediosItems = new List<ItemKV>();
          _esperaMediosItems.add(ItemKV('', 'Todos'));
          data['espera_medios'].forEach((k, v) {
            _esperaMediosItems.add(new ItemKV(k, v));
            if (_esperaMediosItems.length == 1) _esperaMedios = k.toString();
          });
        }
        notifyListeners();
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future valorar(double copos) async {
    ReportRepository()
        .valorar(_reportSelected.id.toString(), copos.round().toString())
        .then((response) {
      print('valorar: ');
      if (response['ok'] && response['data'] == true) {
        // setState(() {
        _showReportDetailTutorial = false;
        _reportSelected.copos = copos.toString();
        _reportSelected.coposUsuarios =
            int.parse(_reportSelected.coposUsuarios.toString()) + 1;
        // });

      } else {
        throw new Exception(response['data']['message']);
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future comenta(String comment) async {
    print(comment);
    ReportRepository()
        .comentario(_reportSelected.id.toString(), comment)
        .then((response) {
      print('commenta: ');
      if (response['ok']) {
        _showReportDetailTutorial = false;
        _reportSelected.cantComentarios =
            int.parse(_reportSelected.cantComentarios.toString()) + 1;
        fetchReportComments();
      } else {
        throw new Exception('Error al comentar');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> detalleCentroSki() async {
    if (_center != null) {
      ReportRepository()
          .detalleCentroSki(_center.id.toString())
          .then((response) {
        print('detalle-centro-ski response: ');
        if (response['ok']) {
          var data = response['data'];
          _center = data['centro_ski'] != null
              ? SkiCenter.map(data['centro_ski'])
              : SkiCenter(0, 'No hay centro', 0.0, 0.0, [], '');
          _pistasRecomendadas = List<Pista>();
          if (data['pistas_recomendadas'] != null) {
            final _castDataType =
                data['pistas_recomendadas'].cast<Map<String, dynamic>>();
            _pistasRecomendadas =
                _castDataType.map<Pista>((json) => Pista.map(json)).toList();
            notifyListeners();
          }
        } else {
          throw new Exception('Error');
        }
      }).catchError((error) {
        print(error.toString());
      });
    }
  }
}
