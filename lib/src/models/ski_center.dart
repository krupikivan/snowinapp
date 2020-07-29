import 'package:snowin/src/models/pist.dart';

class SkiCenter {
  var id;
  var name;
  var latitud;
  var longitud;
  var imagen;

  List<Pista> pistas;

  SkiCenter(this.id, this.name, this.latitud, this.longitud, this.pistas,
      this.imagen);

  SkiCenter.map(dynamic data) {
    this.id = data.containsKey('idcentro_ski') ? data['idcentro_ski'] : 0;
    this.name = data.containsKey('nombre_c') ? data['nombre_c'].toString() : "";
    this.latitud = data.containsKey('latitud') ? data['latitud'].toString() : 0;
    this.longitud =
        data.containsKey('longitud') ? data['longitud'].toString() : 0;
    this.imagen = data.containsKey('urlImagenPistas')
        ? data['urlImagenPistas'].toString()
        : "";

    List list = new List<Pista>();
    if (data.containsKey('pistas') && (data['pistas'] != null)) {
      data['pistas']['data'].forEach((pista) {
        list.add(Pista.map(pista));
      });
      this.pistas = list;
    }
  }
}
