import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snowin/src/repository/snowin_repository.dart';

import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';

class RegisterRepository {
  SnowinRepository snowinProvider = SnowinRepository();

  static RegisterRepository _instance = new RegisterRepository._internal();
  RegisterRepository._internal();
  factory RegisterRepository() => _instance;

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
        response = await http.get(Uri.encodeFull(service),
            headers: snowinProvider.headers);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  //profile types
  Future<Map> perfiles() async {
    print('call end point: perfiles');

    //configurar servicio
    String service = Config.apiUserUrl + "perfiles";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  //save profile types
  Future<Map> perfil(String perfil) async {
    print('call end point: perfil');
    print(perfil);

    //configurar servicio
    String service = Config.apiUserUrl + "perfil";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'perfil': perfil}, headers: snowinProvider.securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
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
        response = await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  //save level
  Future<Map> nivel(String nivel) async {
    print('call end point: nivel');
    print(nivel);

    //configurar servicio
    String service = Config.apiUserUrl + "nivel";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'nivel': nivel}, headers: snowinProvider.securedHeaders);

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          return {
            'ok': true,
            'data': (decodeResp == null) ? decodeResp : decodeResp['data']
          };
        } else {
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }
}
