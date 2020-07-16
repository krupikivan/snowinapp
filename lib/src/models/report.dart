import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/models/pist.dart';
import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/multimedia.dart';

class Report {
  var id;
  var comentario;
  var calificacion;
  var fecha;
  var userId;
  var pistaId;
  var reporteDe;
  var titulo;
  var borrador;
  var ubicacion;
  var calidadNieve;
  var esperaMedios;
  var viento;
  var clima;
  var sensacionGeneral;
  var compartir;
  var cantComentarios;
  var copos;
  var coposUsuarios;

  User user;
  Pist pista;
  SkiCenter centro;
  List<Multimedia> multimedias;

  Report(
      this.id,
      this.comentario,
      this.calificacion,
      this.fecha,
      this.userId,
      this.pistaId,
      this.reporteDe,
      this.titulo,
      this.borrador,
      this.ubicacion,
      this.calidadNieve,
      this.esperaMedios,
      this.viento,
      this.clima,
      this.sensacionGeneral,
      this.compartir,
      this.cantComentarios,
      this.copos,
      this.coposUsuarios,
      this.user,
      this.pista,
      this.centro,
      this.multimedias);

  Report.map(dynamic data) {
    this.id = data.containsKey('idreporte') ? data['idreporte'] : 0;
    this.comentario =
        data.containsKey('comentario') ? data['comentario'].toString() : "";
    this.calificacion =
        data.containsKey('calificacion') ? data['calificacion'].toString() : "";
    this.fecha = data.containsKey('fecha') ? data['fecha'].toString() : "";
    this.userId = data.containsKey('user_id') ? data['user_id'].toString() : "";
    this.pistaId = data.containsKey('pista_idpista')
        ? data['pista_idpista'].toString()
        : "";
    this.reporteDe =
        data.containsKey('reporte_de') ? data['reporte_de'].toString() : "";

    this.titulo = data.containsKey('titulo') ? data['titulo'].toString() : "";
    this.borrador =
        data.containsKey('borrador') ? data['borrador'].toString() : "";
    this.ubicacion =
        data.containsKey('ubicacion') ? data['ubicacion'].toString() : "";
    this.calidadNieve = data.containsKey('calidad_nieve')
        ? data['calidad_nieve'].toString()
        : "";
    this.esperaMedios = data.containsKey('espera_medios')
        ? data['espera_medios'].toString()
        : "";
    this.viento = data.containsKey('viento') ? data['viento'].toString() : "";
    this.clima = data.containsKey('clima') ? data['clima'].toString() : "";
    this.sensacionGeneral = data.containsKey('sensacion_general')
        ? data['sensacion_general'].toString()
        : "";
    this.compartir =
        data.containsKey('compartir') ? data['compartir'].toString() : "";
    this.cantComentarios =
        data.containsKey('cant_comentarios') ? data['cant_comentarios'] : 0;
    this.copos = data.containsKey('copos')
        ? data['copos'] != null ? data['copos'] : 0
        : 0;
    this.coposUsuarios = data.containsKey('copos_usuarios')
        ? data['copos_usuarios'] != null ? data['copos_usuarios'] : 0
        : 0;

    this.user = data.containsKey('user') ? User.map(data['user']) : null;

    this.pista = data.containsKey('pistaSki') && data['pistaSki'] != null
        ? Pist.map(data['pistaSki'])
        : null;

    this.centro =
        data.containsKey('centroSki') ? SkiCenter.map(data['centroSki']) : null;

    multimedias = new List<Multimedia>();
    if (data.containsKey('multimedia') && (data['multimedia'] != null)) {
      if (data['multimedia']['data'].isNotEmpty) {
        data['multimedia']['data'].forEach((multimedia) {
          multimedias.add(Multimedia.map(multimedia));
        });
      } else {
        multimedias = [];
      }
    }
  }
}
