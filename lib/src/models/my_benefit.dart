import 'package:snowin/src/models/benefit.dart';

List<MyBenefit> misBeneficiosFromJson(var list) {
  return list.map<MyBenefit>((item) => MyBenefit.fromJson(item)).toList();
}

class MyBenefit {
  int id;
  int userId;
  int beneficioId;
  String reclamo;
  String fechaUtilizado;
  Benefit beneficio;

  MyBenefit({
    this.id,
    this.userId,
    this.beneficioId,
    this.reclamo,
    this.fechaUtilizado,
    this.beneficio,
  });

  factory MyBenefit.fromJson(Map<String, dynamic> json) => MyBenefit(
        id: json["id"] as int,
        userId: json["user_id"] as int,
        beneficioId: json["beneficio_id"] as int,
        reclamo: json["reclamo"],
        fechaUtilizado: json["fecha_utilizado"],
        beneficio: Benefit.fromJson(json["beneficio"]),
      );
}
