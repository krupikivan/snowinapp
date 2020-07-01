import 'package:snowin/src/models/pist.dart';

class SkiCenter {
  var id;
  var name;
  var latitud;
  var longitud;

  List<Pist> pistas;

  SkiCenter(this.id, this.name, this.latitud, this.longitud, this.pistas);

  SkiCenter.map(dynamic data) {
    this.id = data.containsKey('idcentro_ski')? data['idcentro_ski'] : 0;
    this.name = data.containsKey('nombre_c')? data['nombre_c'].toString() : "";
    this.latitud = data.containsKey('latitud')? data['latitud'].toString() : "";
    this.longitud = data.containsKey('longitud')? data['longitud'].toString() : "";

    pistas = new List<Pist>();
    if(data.containsKey('pistas')) {
        data['pistas'].forEach((pista) {
            pistas.add(Pist.map(pista));
        });
    }
  }
}