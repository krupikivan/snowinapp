import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/solicitud.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/repository/community_repository.dart';
import 'package:snowin/src/models/users_near.dart';

class CommunityProvider with ChangeNotifier {
  //Get all users----------------
  List<User> _userList = [];

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  set userList(List<User> userList) {
    _userList = userList;
    notifyListeners();
  }

//Get all users near
  UsersNear _users;
  UsersNear get users => _users;

  set users(UsersNear user) {
    _users = user;
    notifyListeners();
  }

  //Get current user----------------
  User _currentUser;

  User get currentUser => _currentUser;

  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  //Manage Limit fetching------------------------------
  int _limit;
  int get limit => _limit;
  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

  //Manage Connection------------------------------
  bool _hasConnection;
  bool get hasConnection => _hasConnection;
  set hasConnection(bool value) {
    _hasConnection = value;
    notifyListeners();
  }

  //Manage Loading data------------------------------
  bool _loading;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Solicitud> _solicitudesEnviadas;
  List<Solicitud> get solicitudesEnviadas => _solicitudesEnviadas;
  set solicitudesEnviadas(List<Solicitud> value) {
    _solicitudesEnviadas = value;
    notifyListeners();
  }

//Initialize user provider-------------------
  CommunityProvider.init() {
    initiateData();
    getUsers();
    getSolicitudesEnviadas();
  }

  initiateData() {
    _limit = 10;
    _hasConnection = true;
    _loading = true;
  }

  loadMore() {
    getUsers(sum: 10);
  }

//Todo: El admin id esta harcodeado
  int getUserAdminId() {
    return 3;
  }

  void getUsers({int sum}) {
    int offset = 0;
    _limit = sum != null ? _limit + sum : _limit;
    _loading = true;
    notifyListeners();
    print('Limite: $_limit');
    CommunityRepository()
        .nearestUsers(
      _limit.toString(),
      offset.toString(),
    )
        .then((response) {
      print(response);
      if (response['ok']) {
        if (response['data']['name'] == 'Unauthorized') {
          _hasConnection = true;
          _loading = false;
          notifyListeners();
          throw Exception('No esta autorizado');
        } else {
          _hasConnection = true;
          _loading = false;
          compute(usersFromJson, response['data']['usuarios']).then((value) {
            _users = UsersNear.fromJson(response['data'], value);
            notifyListeners();
          });
        }
      } else if (response['errores'][0]['field'] == 'error_conexion') {
        _hasConnection = false;
        _loading = false;
        notifyListeners();
        throw Exception('Error conexion');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getSolicitudesEnviadas() {
    List<Solicitud> _list = [];
    CommunityRepository().getSolicitudesEnviadas().then((response) {
      print(response);
      if (response['ok']) {
        response['data']['data']
            .forEach((element) => _list.add(Solicitud.fromJson(element)));
        _solicitudesEnviadas = _list;
        notifyListeners();
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<bool> enviarSolicitud() async {
    var response = await CommunityRepository().enviarSolicitud(_userTapped.id);
    if (response['ok']) {
      _solicitudesEnviadas.add(Solicitud.fromJson(response['data']));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> eliminarSolicitud() async {
    var solicitud = _solicitudesEnviadas
        .firstWhere((element) => element.destinoId == _userTapped.id);
    var response = await CommunityRepository().eliminarSolicitud(solicitud.id);
    if (response['ok']) {
      _solicitudesEnviadas.remove(solicitud);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  //Get all users----------------
  User _userTapped;

  User get userTapped => _userTapped;

  set userTapped(User userTapped) {
    _userTapped = userTapped;
    notifyListeners();
  }
}
