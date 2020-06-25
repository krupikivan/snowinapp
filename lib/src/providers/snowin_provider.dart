import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';

class SnowinProvider {
  static final _prefs = new Preferences();

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  final Map<String, String> securedHeaders = {
    'Authorization' : 'Bearer '+_prefs.token
  };

  static SnowinProvider _instance = new SnowinProvider._internal();
  SnowinProvider._internal();
  factory SnowinProvider() => _instance;





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
      return retornarErrorDesconocido();
    }
  }



/////////////////////////////////////////////////////////////////////////////////SERVICIOS DE USUARIO
  Future<Map> centroSki() async {
    print('call end point: centro-ski');

    //configurar servicio
    String service = Config.apiUserUrl + "centro-ski";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  Future<Map> reportes() async {
    print('call end point: reportes');

    //configurar servicio
    String service = Config.apiReportsUrl + "reportes";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  Future<Map> recomendedTraks() async {
    print('call end point: advertencias');

    //configurar servicio
    String service = Config.apiCentroSkiUrl + "advertencias";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  Future<Map> closestFriends() async {
    print('call end point: coordenadas-amigos');

    //configurar servicio
    String service = Config.apiUserUrl + "coordenadas-amigos";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  Future<Map> posicion(String latitude, String longitude, String altitude) async {
    print('call end point: posicion');

    //configurar servicio
    String service = Config.apiUserUrl + "posicion";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
                                    body: {
                                      'latitud': latitude,
                                      'longitud': longitude,
                                      'altura': altitude
                                    },
                                    headers: securedHeaders);

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








/////////////////////////////////////////////////////////////////////////////////TRATAMIENTO DE ERRORES
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
