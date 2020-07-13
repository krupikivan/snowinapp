import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';

class SnowinProvider with ChangeNotifier {
  static final _prefs = new Preferences();

  // Position _userPosition;
  // Position get userPosition => _userPosition;
  // set userPosition(Position userPos) {
  //   _userPosition = userPos;
  //   posicion(userPos);
  //   notifyListeners();
  // }

  // SnowinProvider.init() {
  //   Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((position) {
  //     _userPosition = position;
  //     notifyListeners();
  //   });
  // }

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  final Map<String, String> securedHeaders = {
    'Authorization': 'Bearer ' + _prefs.token
  };

  static SnowinProvider _instance = new SnowinProvider._internal();
  SnowinProvider._internal();
  factory SnowinProvider() => _instance;

  Future<Map<String, dynamic>> obtenerwellcome() async {
    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        final resp =
            await http.get(Config.apiWelcome + 'bienvenida', headers: headers);
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

  Future<Map> detalleCentroSki(String idCentro) async {
    print('call end point: detalles-centro-ski');

    //configurar servicio
    String service = Config.apiCentroSkiUrl + "detalles-centro-ski/" + idCentro;

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

  Future<Map> recomendedTraks() async {
    print('call end point: advertencias');

    //configurar servicio
    String service = Config.apiCentroSkiUrl + "advertencias";

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

  Future<Map> closestFriends() async {
    print('call end point: coordenadas-amigos');

    //configurar servicio
    String service = Config.apiUserUrl + "coordenadas-amigos";

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
            headers: securedHeaders, body: body);
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

  Future<Map> sendReport(
      String pistaId,
      String titulo,
      String comentario,
      String calidadNieve,
      String esperaMedios,
      String viento,
      String clima,
      String sensacionGeneral,
      List<File> multimedias) async {
    print('call end point: crear');
    print(pistaId);
    print(titulo);
    print(comentario);
    print(calidadNieve);
    print(esperaMedios);
    print(viento);
    print(clima);
    print(sensacionGeneral);
    print(multimedias.length.toString());

    //configurar servicio
    String service = Config.apiReportsUrl + "crear";

    //Respuesta
    var response;

    try {
      final conex = await ConnectivityProvider().check();
      if (conex) {
        var request = new http.MultipartRequest("POST", Uri.parse(service));
        request.fields['pista_id'] = pistaId;
        request.fields['titulo'] = titulo;
        request.fields['comentario'] = comentario;
        request.fields['calidad_nieve'] = calidadNieve;
        request.fields['espera_medios'] = esperaMedios;
        request.fields['viento'] = viento;
        request.fields['clima'] = clima;
        request.fields['sensacion_general'] = sensacionGeneral;

        multimedias.forEach((media) {
          var stream =
              new http.ByteStream(DelegatingStream.typed(media.openRead()));
          media.length().then((length) {
            var mediaFile = new http.MultipartFile('foto', stream, length,
                filename: basename(media.path));
            request.files.add(mediaFile);
          });
        });

        request.headers['Authorization'] = 'Bearer ' + _prefs.token;

        response = await request.send();

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

  Future<Map> notifications(String limit, String offset,
      [String filters = '']) async {
    print('call end point: notificaciones/listar');
    print(filters);

    //configurar servicio
    String service = Config.apiNotificationsUrl + "listar";
    service += '?limit=' + limit + '&offset=' + offset;
    service += filters.isNotEmpty ? ('&' + filters) : '';

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

  Future getBenefits() async {
    //configurar servicio
    String service = Config.apiBeneficiosUrl;
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

  Future getMyBenefits() async {
    //configurar servicio
    String service = Config.apiMisBeneficiosUrl;
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

  Future getAllUsers() async {
    //configurar servicio
    String service = Config.apiTodosLosUsuarios;
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
