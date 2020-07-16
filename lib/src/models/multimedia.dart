class Multimedia {
  var id;
  var ruta;
  var estado;
  var reportId;
  var tipo;
  var fecha;
  var tabla;

  Multimedia(this.id, this.ruta, this.estado, this.reportId, this.tipo,
      this.fecha, this.tabla);

  Multimedia.map(dynamic data) {
    this.id = data.containsKey('id') ? data['id'] : 0;
    this.ruta = data.containsKey('url') ? data['url'].toString() : "";
    this.estado = data.containsKey('estado') ? data['estado'].toString() : "";
    this.reportId =
        data.containsKey('registro_id') ? data['registro_id'].toString() : "";
    this.tipo = data.containsKey('tipo') ? data['tipo'].toString() : "";
    this.fecha = data.containsKey('fecha_creacion')
        ? data['fecha_creacion'].toString()
        : "";
    this.tabla = data.containsKey('tabla') ? data['tabla'].toString() : "";
  }
}
