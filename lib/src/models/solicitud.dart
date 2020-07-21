class Solicitud {
  var id;
  var destinoId;

  Solicitud(this.id, this.destinoId);

  Solicitud.fromJson(Map data) {
    id = data['id'];
    destinoId = data['destino_user_id'];
  }
}
