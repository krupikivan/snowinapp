class Pist {
  var id;
  var descripcion;
  var idCentro;
  var visible;
  var nivel;
  var calidadNieve;
  var categoria;
  var longitud;
  var latitud;

  Pist(this.id, this.descripcion, this.idCentro, this.visible, this.nivel,
      this.calidadNieve, this.categoria, this.longitud, this.latitud);

  Pist.map(dynamic data) {
    this.id = data.containsKey('idpista') ? data['idpista'] : 0;
    this.descripcion =
        data.containsKey('descripcion') ? data['descripcion'].toString() : "";
    this.idCentro = data.containsKey('centro_ski_idcentro_ski')
        ? data['centro_ski_idcentro_ski']
        : 0;
    this.visible = data.containsKey('visible') ? data['visible'] : 0;
    this.nivel = data.containsKey('nivel') ? data['nivel'].toString() : "";
    this.calidadNieve = data.containsKey('calidad_nieve')
        ? data['calidad_nieve'].toString()
        : "";
    this.categoria =
        data.containsKey('categoria') ? data['categoria'].toString() : "";
    this.longitud = data.containsKey('longitud')
        ? data['longitud'] != null ? data['longitud'] : 0
        : 0;
    this.latitud = data.containsKey('latitud')
        ? data['latitud'] != null ? data['latitud'] : 0
        : 0;
  }
}
