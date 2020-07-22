import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class ChatRepository {
  SnowinRepository snowinProvider = SnowinRepository();

  static ChatRepository _instance = new ChatRepository._internal();
  ChatRepository._internal();
  factory ChatRepository() => _instance;

  Future<Map> getAllMessages(int id) async {
    print('call end point: user mensajes');

    //configurar servicio
    String service = Config.apiUserUrl + "mensaje?filtros[conversacion_id]=$id";

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
          await http.get(Uri.encodeFull(service),
              headers: snowinProvider.securedHeaders);
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  Future sendMessage(String text, int id) async {
    print('call end point: user mensajes');

    //configurar servicio
    String service = Config.apiUserUrl + "mensaje";

    //Respuesta
    http.Response response;

    Map body = {'to_user_id': '$id', 'message': '$text'};

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
          await http.get(Uri.encodeFull(service),
              headers: snowinProvider.securedHeaders);
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  Future delete(int id) async {
    print('call end point: delete mensaje');

    //configurar servicio
    String service = Config.apiUserUrl + "mensaje/$id";

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
          await http.get(Uri.encodeFull(service),
              headers: snowinProvider.securedHeaders);
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }

  Future<Map> getConversacion(int id) async {
    print('call end point: user conversacion');

    //configurar servicio
    String service = Config.apiUserUrl + "conversacion?filtros[to_user_id]=$id";
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
          await http.get(Uri.encodeFull(service),
              headers: snowinProvider.securedHeaders);
          return snowinProvider.manejadorErroresResp(response);
        }
      } else {
        await http.get(Uri.encodeFull(service),
            headers: snowinProvider.securedHeaders);
        return snowinProvider.retornarErrorConexion();
      }
    } catch (e) {
      return snowinProvider.retornarErrorDesconocido();
    }
  }
}
