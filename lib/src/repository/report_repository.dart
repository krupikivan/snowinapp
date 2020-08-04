import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class ReportRepository {
  SnowinRepository snowinProvider = SnowinRepository();
  Dio dio = Dio();
  static ReportRepository _instance = new ReportRepository._internal();
  ReportRepository._internal();
  factory ReportRepository() => _instance;

  Future<Map> reportes(String limit, String offset,
      [String filters = '']) async {
    print('call end point: reporte/listar');
    print(filters);

    //configurar servicio
    String service = Config.apiReportsUrl + "listar";
    service += '?limit=' + limit + '&offset=' + offset;
    service += filters.isNotEmpty ? ('&' + filters) : '';

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        //Automaticamente al agregar un reporte se agrega un header content-type => null
        Map head = snowinProvider.securedHeaders;
        print(snowinProvider.securedHeaders['Authorization']);
        head.removeWhere((k, v) => v == null);
        response = await http.get(Uri.encodeFull(service), headers: head);

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

  Future<Map> comentarios(String limit, String offset,
      [String filters = '']) async {
    print('call end point: reporte/listar');
    print(filters);

    //configurar servicio
    String service = Config.apiReportsUrl + "comentario";
    service += '?limit=' + limit + '&offset=' + offset;
    service += filters.isNotEmpty ? ('&' + filters) : '';

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        //Automaticamente al agregar un reporte se agrega un header content-type => null
        Map head = snowinProvider.securedHeaders;
        head.removeWhere((k, v) => v == null);
        response = await http.get(Uri.encodeFull(service), headers: head);

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

  Future<Map> centroSki() async {
    print('call end point: centro-ski');

    //configurar servicio
    String service = Config.apiUserUrl + "centro-ski";

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

  Future<Map> detalleCentroSki(String idCentro) async {
    print('call end point: detalles-centro-ski');

    //configurar servicio
    String service = Config.apiCentroSkiUrl + "detalles-centro-ski/" + idCentro;

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

  Future<Map> rankings(String limit, String offset,
      [String filters = '']) async {
    print('call end point: listar-ranking');
    print(filters);

    //configurar servicio
    String service = Config.apiUserUrl + "listar-ranking";
    // service += '?limit=' + limit + '&offset=' + offset;
    // service += filters.isNotEmpty? ('&' + filters) : '';

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

  Future<Map> valorar(String reportId, String copos) async {
    print('call end point: valorar');

    //configurar servicio
    String service = Config.apiReportsUrl + "valorar";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'reporte_id': reportId, 'copos': copos},
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

  Future<Map> comentario(String reportId, String comment) async {
    print('call end point: comentario');

    //configurar servicio
    String service = Config.apiReportsUrl + "comentario";

    //Respuesta
    http.Response response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        response = await http.post(Uri.encodeFull(service),
            body: {'reporte_id': reportId, 'comentario': comment},
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

  Future<Map> centroSkiWarning() async {
    print('call end point: advertencias');

    //configurar servicio
    String service = Config.apiCentroSkiUrl + "advertencias";

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

  Future<Map> closestFriends() async {
    print('call end point: coordenadas-amigos');

    //configurar servicio
    String service = Config.apiUserUrl + "coordenadas-amigos";

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

  Future<Map> sendReport(
      {String pistaId,
      String titulo,
      String comentario,
      String centerSky,
      String calidadNieve,
      String esperaMedios,
      String viento,
      String clima,
      String sensacionGeneral,
      List<File> multimedias}) async {
    print('call end point: crear');

    //configurar servicio
    String service = Config.apiReportsUrl + "crear";

    //Respuesta
    var response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
//--------------------------DIO-----------------------------------
        FormData formData;
        List mediaFile = [];
        multimedias.map((element) {
          var file = MultipartFile.fromFileSync(element.path, filename: 'foto');
          mediaFile.add(file);
        });
        formData = FormData.fromMap({
          if (pistaId != null) 'pista_id': pistaId,
          'titulo': titulo,
          'comentario': comentario,
          'calidad_nieve': calidadNieve,
          'espera_medios': esperaMedios,
          'centro_ski_id': centerSky,
          'viento': viento,
          'clima': clima,
          'sensacion_general': sensacionGeneral,
          'foto': [
            for (var i = 0; i < multimedias.length; i++)
              {
                await MultipartFile.fromFile(multimedias[i].path,
                    filename: 'foto$i')
              }.toList()
          ]
        });

        response = await dio.post(service,
            data: formData,
            options: Options(headers: snowinProvider.securedHeaders));

//--------------------------DIO-----------------------------------

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = response.data;
          return {
            'ok': decodeResp['success'],
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
