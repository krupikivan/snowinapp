class Multimedia {
  var id;
  var ruta;
  var nombre;
  var reportId;

  Multimedia(this.id, this.ruta, this.nombre, this.reportId);

  Multimedia.map(dynamic data) {
    this.id = data.containsKey('idmultimedia')? data['idmultimedia'] : 0;
    this.ruta = data.containsKey('ruta')? data['ruta'].toString() : "";
    this.nombre = data.containsKey('nombre_i')? data['nombre_i'].toString() : "";
    this.reportId =  data.containsKey('reporte_idreporte')? data['reporte_idreporte'].toString() : "";
  }
}