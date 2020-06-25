class SkiCenter {
  var id;
  var name;
  var latitud;
  var longitud;

  SkiCenter(this.id, this.name, this.latitud, this.longitud);

  SkiCenter.map(dynamic data) {
    this.id = data.containsKey('idcentro_ski')? data['idcentro_ski'] : 0;
    this.name = data.containsKey('nombre_c')? data['nombre_c'].toString() : "";
    this.latitud = data.containsKey('latitud')? data['latitud'].toString() : "";
    this.longitud = data.containsKey('longitud')? data['longitud'].toString() : "";
  }
}