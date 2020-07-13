import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';

class RegisterProvider {
  static final _prefs = new Preferences();

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  // final Map<String, String> securedHeaders = {
  //   'Authorization': 'Bearer ' + _prefs.token
  // };
  final Map<String, String> securedHeaders = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImp0aSI6IjRmMWcyM2ExMmFhIn0.eyJpc3MiOiJzbm93aW4uY29tIiwiYXVkIjoic25vd2luLmNvbSIsImp0aSI6IjRmMWcyM2ExMmFhIiwiaWF0IjoxNTk0NjQ4OTMyLCJleHAiOjE1OTQ4MjE3MzIsInVpZCI6MzF9.D4zNRISineQA49rmxhBys4pnQJmglYIFbxKCxfbsnn4'
  };

  static RegisterProvider _instance = new RegisterProvider._internal();
  RegisterProvider._internal();
  factory RegisterProvider() => _instance;

  //terminos y condiciones
  Future<Map> legal() async {
    print('call end point: legal');

    //configurar servicio
    String service = Config.apiUrl + "legal";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service), headers: headers);

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

  //profile types
  Future<Map> perfiles() async {
    print('call end point: perfiles');
    print(securedHeaders);

    //configurar servicio
    String service = Config.apiUserData + "perfiles";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  //save profile types
  Future<Map> perfil(String perfil) async {
    print('call end point: perfil');
    print(perfil);
    print(securedHeaders);

    //configurar servicio
    String service = Config.apiUserUrl + "perfil";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'perfil': perfil}, headers: securedHeaders);

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

  //levels
  Future<Map> niveles() async {
    print('call end point: niveles');

    //configurar servicio
    String service = Config.apiUserUrl + "niveles";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response =
            await http.get(Uri.encodeFull(service), headers: securedHeaders);

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

  //save level
  Future<Map> nivel(String nivel) async {
    print('call end point: nivel');
    print(nivel);
    print(securedHeaders);

    //configurar servicio
    String service = Config.apiUserData + "nivel";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'nivel': nivel}, headers: securedHeaders);

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
