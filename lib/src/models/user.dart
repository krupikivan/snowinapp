class User {
  var id;
  var username;
  var email;
  var status;
  var createdAt;
  var updatedAt;
  var token;
  var nombre;
  var apellidos;
  var latitud;
  var longitud;
  var altura;
  var telefono;
  var nivel;
  var actividad;
  var visible;
  var ranking;
  var facebookUserId;
  var instagramUserId;
  var localidad;
  var fullname;
  var image;
  var profile;

  User(
      this.id,
      this.username,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.nombre,
      this.apellidos,
      this.longitud,
      this.latitud,
      this.altura,
      this.telefono,
      this.nivel,
      this.actividad,
      this.visible,
      this.ranking,
      this.facebookUserId,
      this.instagramUserId,
      this.localidad,
      this.fullname,
      this.image,
      this.profile);

  User.map(dynamic data) {
    this.id = data.containsKey('id') ? data['id'] : 0;
    this.username =
        data.containsKey('username') ? data['username'].toString() : "";
    this.email = data.containsKey('email') ? data['email'].toString() : "";
    this.status = data.containsKey('status') ? data['status'].toString() : "";
    this.createdAt =
        data.containsKey('createdAt') ? data['createdAt'].toString() : "";
    this.updatedAt =
        data.containsKey('updatedAt') ? data['updatedAt'].toString() : "";
    this.token = data.containsKey('token') ? data['token'].toString() : "";
    this.nombre = data.containsKey('nombre') ? data['nombre'].toString() : "";

    this.apellidos =
        data.containsKey('apellidos') ? data['apellidos'].toString() : "";
    this.longitud =
        data.containsKey('longitud') ? data['longitud'].toString() : "";
    this.latitud =
        data.containsKey('latitud') ? data['latitud'].toString() : "";
    this.altura = data.containsKey('altura') ? data['altura'].toString() : "";
    this.telefono =
        data.containsKey('telefono') ? data['telefono'].toString() : "";
    this.nivel = data.containsKey('nivel') ? data['nivel'].toString() : "";
    this.actividad =
        data.containsKey('actividad') ? data['actividad'].toString() : "";

    this.visible =
        data.containsKey('visible') ? data['visible'].toString() : "";
    this.ranking = data.containsKey('ranking')
        ? data['ranking'] != null ? data['ranking'].toString() : 0
        : 0;
    this.facebookUserId = data.containsKey('facebook_user_id')
        ? data['facebook_user_id'].toString()
        : "";
    this.instagramUserId = data.containsKey('instagram_user_id')
        ? data['instagram_user_id'].toString()
        : "";
    this.localidad =
        data.containsKey('localidad') ? data['localidad'].toString() : "";
    this.fullname =
        data.containsKey('fullname') ? data['fullname'].toString() : "";

    this.image = data.containsKey('image') ? data['image'].toString() : "";
    this.profile =
        data.containsKey('profile') ? data['profile'].toString() : "";
  }
}
