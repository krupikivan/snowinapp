List<Benefit> beneficioFromJson(var list) {
  return list.map<Benefit>((item) => Benefit.fromJson(item)).toList();
}

class Benefit {
  int id;
  int puntos;
  String nombre;
  String descripcion;
  String imagen;
  double latitud;
  double longitud;

  Benefit({
    this.id,
    this.puntos,
    this.nombre,
    this.descripcion,
    this.imagen,
    this.latitud,
    this.longitud,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        id: json["comercio_id"] as int,
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["urlImagen"],
        latitud: json["latitud"] as double,
        longitud: json["longitud"] as double,
        puntos: json["puntos"] as int,
      );
}
