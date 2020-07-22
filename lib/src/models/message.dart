List<Message> messageFromJson(var list) {
  return list.map<Message>((item) => Message.fromJson(item)).toList();
}

class Message {
  var id;
  var mensaje;
  var fecha;

  Message({this.id, this.mensaje, this.fecha});

  Message.map(dynamic data) {
    this.id = data.containsKey('id') ? data['id'] : 0;
    this.mensaje = data.containsKey('mensaje') ? data['mensaje'] : '';
    this.fecha =
        data.containsKey('fecha_creacion') ? data['fecha_creacion'] : '';
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] as int,
        mensaje: json["mensaje"],
        fecha: json["fecha_creacion"],
      );
}
