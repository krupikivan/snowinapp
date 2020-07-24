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

  String _perfilSelected;
  String get perfilSelected => _perfilSelected;
  set perfilSelected(String list) {
    _perfilSelected = list;
    notifyListeners();
  }

  UserProvider.init() {
    fetchUserData();
    getNiveles();
    getPerfiles();
    _loading = false;
  }

  changeVisible(bool value) {
    if (value) {
      _user.visible = "1";
      cambiarVisible("1");
    } else {
      _user.visible = "0";
      cambiarVisible("0");
    }
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    await SnowinRepository().getUserLoginData().then((response) {
      print('User data response');
      print(response);
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
      print(response);
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
      print(response);
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
      print(response);
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
      print(response);
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
        .actualizarActividad(_perfilSelected)
        .then((response) {
      print(response);
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }

  Future<void> cambiarVisible(String visible) async {
    await SnowinRepository().cambiarVisibilidad(visible).then((response) {
      print(response);
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
      print(response);
      if (response['success']) {
      } else {
        throw Exception('Error');
      }
    });
  }
}
