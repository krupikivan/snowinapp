// To parse this JSON data, do
//
//     final choferModel = choferModelFromJson(jsonString);

import 'dart:convert';

ChoferModel choferModelFromJson(String str) =>
    ChoferModel.fromJson(json.decode(str));

String choferModelToJson(ChoferModel data) => json.encode(data.toJson());

class ChoferModel {
  Persona persona;
  Camion camion;
  Acoplado acoplado;
  String centro;

  ChoferModel({
    this.persona,
    this.camion,
    this.acoplado,
    this.centro,
  });

  factory ChoferModel.fromJson(Map<String, dynamic> json) => ChoferModel(
        persona: Persona.fromJson(json["persona"]),
        camion: Camion.fromJson(json["camion"]),
        acoplado: Acoplado.fromJson(json["acoplado"]),
        centro: json["centro"],
      );

  Map<String, dynamic> toJson() => {
        "persona": persona.toJson(),
        "camion": camion.toJson(),
        "acoplado": acoplado.toJson(),
        "centro": centro,
      };
}

class Acoplado {
  int idMarcaAcoplado;
  int idTipoAcoplado;
  int anno;
  String patente;

  Acoplado({
    this.idMarcaAcoplado,
    this.idTipoAcoplado,
    this.anno,
    this.patente,
  });

  factory Acoplado.fromJson(Map<String, dynamic> json) => Acoplado(
        idMarcaAcoplado: json["id_marca_acoplado"],
        idTipoAcoplado: json["id_tipo_acoplado"],
        anno: json["anno"],
        patente: json["patente"],
      );

  Map<String, dynamic> toJson() => {
        "id_marca_acoplado": idMarcaAcoplado,
        "id_tipo_acoplado": idTipoAcoplado,
        "anno": anno,
        "patente": patente,
      };
}

class Camion {
  int idMarcaCamion;
  int idTipoCamion;
  int anno;
  String patente;

  Camion({
    this.idMarcaCamion,
    this.idTipoCamion,
    this.anno,
    this.patente,
  });

  factory Camion.fromJson(Map<String, dynamic> json) => Camion(
        idMarcaCamion: json["id_marca_camion"],
        idTipoCamion: json["id_tipo_camion"],
        anno: json["anno"],
        patente: json["patente"],
      );

  Map<String, dynamic> toJson() => {
        "id_marca_camion": idMarcaCamion,
        "id_tipo_camion": idTipoCamion,
        "anno": anno,
        "patente": patente,
      };
}

class Persona {
  String cuitCuil;
  String nombre;
  String apellidos;
  String razonSocial;
  int idLocalidad;
  String domicilio;

  Persona({
    this.cuitCuil,
    this.nombre,
    this.apellidos,
    this.razonSocial,
    this.idLocalidad,
    this.domicilio,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        cuitCuil: json["cuit_cuil"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        razonSocial: json["razon_social"],
        idLocalidad: json["id_localidad"],
        domicilio: json["domicilio"],
      );

  Map<String, dynamic> toJson() => {
        "cuit_cuil": cuitCuil,
        "nombre": nombre,
        "apellidos": apellidos,
        "razon_social": razonSocial,
        "id_localidad": idLocalidad,
        "domicilio": domicilio,
      };
}
