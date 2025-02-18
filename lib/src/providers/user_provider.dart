import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class UserProvider with ChangeNotifier {
//Manage User Data------------------------------
  User _user;
  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  String _uploading;
  String get uploading => _uploading;
  set uploading(String uploading) {
    _uploading = uploading;
    notifyListeners();
  }

  bool _loading;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  List _niveles;
  List get niveles => _niveles;
  set niveles(List list) {
    _niveles = list;
    notifyListeners();
  }

  String _nivelesSelected;
  String get nivelesSelected => _nivelesSelected;
  set nivelesSelected(String list) {
    _nivelesSelected = list;
    notifyListeners();
  }

  List _perfil;
  List get perfil => _perfil;
  set perfil(List list) {
    _perfil = list;
    notifyListeners();
  }

  UserActivity _perfilSelected;
  UserActivity get perfilSelected => _perfilSelected;
  set perfilSelected(UserActivity value) {
    _perfilSelected = value;
    notifyListeners();
  }

  UserProvider.init() {
    fetchUserData();
    getNiveles();
    getPerfiles();
    _loading = false;
  }

  changeVisible(bool value) async {
    try {
      if (value) {
        _user.visible = "1";
        notifyListeners();
        await cambiarVisible("1");
      } else {
        _user.visible = "0";
        notifyListeners();
        await cambiarVisible("0");
      }
    } catch (e) {
      _user.visible = value ? '0' : '1';
      notifyListeners();
    }
  }

  Future<void> fetchUserData() async {
    await SnowinRepository().getUserLoginData().then((response) {
      print('User data response');
      if (response['ok']) {
        var data = response['data'];
        _user = User.map(data);
        _nivelesSelected = _user.nivel;
        _perfilSelected = _user.actividad;
        notifyListeners();
      } else {
        if (response['errores'][0]['field'] == 'error_conexion') {}
        throw Exception('Error');
      }
    });
  }

  Future<void> getNiveles() async {
    await SnowinRepository().getNiveles().then((response) {
      print('User niveles response');
      if (response['ok']) {
        var data = response['data'];
        _niveles = data;
        _nivelesSelected ?? _niveles[0];
        notifyListeners();
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> getPerfiles() async {
    await SnowinRepository().getPerfiles().then((response) {
      print('User perfiles response');
      if (response['ok']) {
        var data = response['data'];
        _perfil = data;
        _perfilSelected ?? _perfil[0];
        notifyListeners();
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> editBio() async {
    await SnowinRepository().actualizarBio(_user.biografia).then((response) {
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> editUserImage() async {
    _loading = true;
    notifyListeners();
    await SnowinRepository().actualizarUserImage(_uploading).then((response) {
      if (response['ok']) {
        _uploading = null;
      } else {
        throw Exception('Error');
      }
    });
    fetchUserData();
    _loading = false;
    notifyListeners();
  }

  Future<void> editActividad() async {
    _user.actividad = _perfilSelected;
    notifyListeners();
    await SnowinRepository()
        .actualizarActividad(User().getActividadString(_perfilSelected))
        .then((response) {
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> cambiarVisible(String visible) async {
    await SnowinRepository().cambiarVisibilidad(visible).then((response) {
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> sendSOS() async {
    await SnowinRepository().sendSOS().then((response) {
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> editNivel() async {
    _user.nivel = _nivelesSelected;
    notifyListeners();
    await SnowinRepository().actualizarNivel(_nivelesSelected).then((response) {
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }
}
