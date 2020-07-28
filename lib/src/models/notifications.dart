import 'package:snowin/src/models/user.dart';

enum TipoNotificacion {
  Amigo_Cercano,
  Solicitud_Amistad_Nueva,
  Solicitud_Amistad_Aceptada,
  Mensaje_Nuevo,
  Nueva_Campana,
  SOS,
  ERROR
}

class Notifications {
  var id;
  var notificacion;
  TipoNotificacion tipo;
  var visto;
  User userNotifica;

  Notifications(this.id, this.notificacion, this.visto, this.userNotifica);

  Notifications.map(dynamic data) {
    this.id =
        data.containsKey('idnotificaciones') ? data['idnotificaciones'] : 0;
    this.notificacion =
        data.containsKey('notificacion') ? data['notificacion'] : '';
    this.visto = data.containsKey('visto') ? data['visto'] : 0;
    this.userNotifica = data.containsKey('user_notifica')
        ? User.map(data['user_notifica'][0])
        : 0;
    this.tipo = data.containsKey('tipo')
        ? _getTipo(data['tipo'])
        : TipoNotificacion.ERROR;
  }
  _getTipo(String tipoNot) {
    switch (tipoNot) {
      case 'MENSAJE_NUEVO':
        return TipoNotificacion.Mensaje_Nuevo;
        break;
      case 'NUEVA CAMPAÑA':
        return TipoNotificacion.Nueva_Campana;
        break;
      case 'SOLICITUD_AMISTAD_NUEVA':
        return TipoNotificacion.Solicitud_Amistad_Nueva;
        break;
      case 'SOLICITUD_AMISTAD_ACEPTADA':
        return TipoNotificacion.Solicitud_Amistad_Aceptada;
        break;
      case 'AMIGO CERCANO':
        return TipoNotificacion.Amigo_Cercano;
        break;
      case 'SOS':
        return TipoNotificacion.SOS;
        break;
      default:
        return TipoNotificacion.ERROR;
    }
  }
}
