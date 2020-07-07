import 'package:snowin/src/models/user.dart';

class UsersNear {
  List<User> usuarios;
  int cantidadAmigos;
  int cantidadUsuarios;

  UsersNear({this.usuarios, this.cantidadAmigos, this.cantidadUsuarios});

  factory UsersNear.fromJson(Map<String, dynamic> json, List<User> list) =>
      UsersNear(
        usuarios: list,
        cantidadAmigos: json["cantidadAmigos"],
        cantidadUsuarios: json["cantidadUsuarios"],
      );
}
