import 'dart:convert';

import 'package:snowin/src/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:snowin/src/repository/snowin_repository.dart';

import '../providers/connectivity_provider.dart';

class CommunityRepository {
  SnowinRepository snowinProvider = SnowinRepository();

  static CommunityRepository _instance = new CommunityRepository._internal();
  CommunityRepository._internal();
  factory CommunityRepository() => _instance;

  Future<Map> notifications(String limit, String offset,
      [String filters = '']) async {
    print('call end point: notificaciones');
    print(filters);

    //configurar servicio
    String service = Config.apiNotificationsUrl;
    // service += '?limit=' + limit + '&offset=' + offset;
    // service += filters.isNotEmpty ? ('&' + filters) : '';

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

  Future<Map> nearestUsers(String limit, String offset,
      [String filters = '']) async {
    print('call end point: usuarios-cercanos');
    print(filters);

    //configurar servicio
    String service = Config.apiUserUrl + "usuarios-cercanos";
    service += '?limit=' + limit + '&offset=' + offset;
    service += filters.isNotEmpty ? ('&' + filters) : '';

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

  Future enviarSolicitud(int id) async {
    print('call end point: enviar-solicitud');
    //configurar servicio
    String service = Config.apiUserUrl + "solicitud-amistad";

    Map body = {
      'destino_user_id': '$id',
      'mensaje': 'Nueva solicitud',
    };

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders, body: body);
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

  Future eliminarSolicitud(int id) async {
    print('call end point: enviar-solicitud');
    //configurar servicio
    String service = Config.apiUserUrl + "solicitud-amistad/$id";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.delete(Uri.encodeFull(service),
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

  Future getSolicitudesEnviadas() async {
    //configurar servicio
    String service = Config.apiUserUrl + 'solicitud-amistad?tipo=enviadas';
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
}
