import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class BenefitRepository {
  SnowinRepository snowinProvider = SnowinRepository();

  static BenefitRepository _instance = new BenefitRepository._internal();
  BenefitRepository._internal();
  factory BenefitRepository() => _instance;

  Future getBenefits(String limit, String offset, [String filters = '']) async {
    //configurar servicio
    String service = Config.apiBeneficiosUrl;
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

  Future getMyBenefits(String limit, String offset,
      [String filters = '']) async {
    //configurar servicio
    String service = Config.apiMisBeneficiosUrl;
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
}
