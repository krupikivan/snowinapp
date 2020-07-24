import 'package:snowin/src/models/user.dart';

class Notifications {
  var id;
  var notificacion;
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
  }
}
