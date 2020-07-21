import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:snowin/src/share/preference.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';

class SnowinRepository {
  static SnowinRepository _instance = new SnowinRepository._internal();
  SnowinRepository._internal();
  factory SnowinRepository() => _instance;
  Dio dio = Dio();

  static final _prefs = Preferences();

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  static Map<String, String> _securedHeaders = {
    'Authorization': 'Bearer ${_prefs.token}',
  };

  Map<String, String> get securedHeaders => _securedHeaders;
  Map<String, String> get headers => _headers;

  Future<Map<String, dynamic>> obtenerwellcome() async {
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        final resp =
            await http.get(Config.apiUrl + 'bienvenida', headers: headers);
        if (resp.statusCode >= 200 && resp.statusCode <= 299) {
          final decodeResp = json.decode(resp.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(resp);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      print(e.toString());
      return retornarErrorDesconocido();
    }
  }

  Future<Map> posicion(Position position) async {
    //configurar servicio
    String service = Config.apiUserPosicion;
    //Respuesta
    http.Response response;
    Map body = {
      'latitud': '${position.latitude}',
      'longitud': '${position.longitude}',
      'altura': '${position.altitude}'
    };
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            headers: _securedHeaders, body: body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'success': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> loadEmuns() async {
    print('call end point: enums');

    //configurar servicio
    String service = Config.apiReportsUrl + "enums";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: _securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> getUserLoginData() async {
    print('call end point: Get user Login');

    //configurar servicio
    String service = Config.apiUserUrl + _prefs.userid;

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: _securedHeaders);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> getUserProfileImage() async {
    print('call end point: Get user Profile Image');

    //configurar servicio
    String service = Config.apiUserProfileImage;

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: _securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> manejadorErroresResp(http.Response resp) async {
    if (resp.statusCode == 422) {
      final decodeResp = json.decode(resp.body);
      return {'ok': false, 'errores': decodeResp};
    } else {
      final decodeResp = json.decode(resp.body);
      List result = List();
      result.add({
        'field': 'error',
        'message': decodeResp['message'] ??
            'Ha ocurrido un error! Inténtelo más tarde.'
      });
      return {'ok': false, 'errores': result};
    }
  }

  Future<Map> actualizarBio(String text) async {
    //configurar servicio
    String service = Config.apiUserUrl + 'actualizar-biografia';
    //Respuesta
    http.Response response;
    Map body = {
      'texto': '$text',
    };
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            headers: _securedHeaders, body: body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'success': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> actualizarUserImage(String url) async {
    //configurar servicio
    String service = Config.apiUserUrl + 'actualizar-foto';
    //Respuesta
    var response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        var request = http.MultipartRequest('POST', Uri.parse(service));
        request.files.add(await http.MultipartFile.fromPath('foto', url));
        request.headers['Authorization'] = securedHeaders['Authorization'];
        response = await request.send();
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          return {
            'ok': true,
            // 'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> actualizarNivel(String text) async {
    //configurar servicio
    String service = Config.apiUserUrl + 'nivel';
    //Respuesta
    http.Response response;
    Map body = {
      'nivel': '$text',
    };
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            headers: _securedHeaders, body: body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'success': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> actualizarActividad(String text) async {
    //configurar servicio
    String service = Config.apiUserUrl + 'perfil';
    //Respuesta
    http.Response response;
    Map body = {
      'perfil': '$text',
    };
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            headers: _securedHeaders, body: body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'success': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> cambiarVisibilidad(String visible) async {
    //configurar servicio
    String service = Config.apiUserUrl + 'cambiar-visibilidad?visible=$visible';
    //Respuesta
    http.Response response;
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.post(Uri.encodeFull(service), headers: _securedHeaders);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'success': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> getNiveles() async {
    print('call end point: niveles');

    //configurar servicio
    String service = Config.apiUserUrl + "niveles";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: _securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  Future<Map> getPerfiles() async {
    print('call end point: actividad');

    //configurar servicio
    String service = Config.apiUserUrl + "perfiles";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: _securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return manejadorErroresResp(response);
        }
      } else {
        return retornarErrorConexion();
      }
    } catch (e) {
      return retornarErrorDesconocido();
    }
  }

  retornarErrorDesconocido() {
    List decodeResp = List();
    decodeResp.add({
      'field': 'error_desconocido',
      'message': 'Ha ocurrido un error! Inténtelo más tarde.'
    });
    return {'ok': false, 'errores': decodeResp};
  }

  retornarErrorConexion() {
    List decodeResp = List();
    decodeResp.add({
      'field': 'error_desconocido',
      'message':
          'Usted no tiene conexión en estos momentos! Verifique e inténtelo más tarde.'
    });
    return {'ok': false, 'errores': decodeResp};
  }
}
