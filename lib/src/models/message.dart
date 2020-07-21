import 'package:snowin/src/models/user.dart';

List<Message> messageFromJson(var list) {
  return list.map<Message>((item) => Message.fromJson(item)).toList();
}

class Message {
  var id;
  var mensaje;

  User user;

  Message({this.id, this.mensaje, this.user});

  Message.map(dynamic data) {
    this.id = data.containsKey('id') ? data['id'] : 0;
    this.mensaje = data.containsKey('mensaje') ? data['mensaje'] : '';
    this.user = data.containsKey('user') ? User.map(data['user']) : null;
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] as int,
        mensaje: json["mensaje"],
        user: User.fromJson(json),
      );
}
