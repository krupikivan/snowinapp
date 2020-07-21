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

  Future<Map> getAllMessages(String limit, String offset,
      [String filters = '']) async {
    print('call end point: notificaciones/listar');
    print(filters);

    //configurar servicio
    String service = Config.apiUserUrl + "mensaje";
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
