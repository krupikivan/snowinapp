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
  var fechaCambioRanking;
  var facebookUserId;
  var instagramUserId;
  var localidad;
  var copos;
  var coposUsuarios;
  var edad;
  var fullname;
  var image;

  User(this.id, this.username, this.email, this.status, this.createdAt, this.updatedAt, this.token, this.nombre,
         this.apellidos, this.longitud, this.latitud, this.altura, this.telefono, this.nivel, this.actividad,
         this.visible, this.ranking, this.fechaCambioRanking, this.facebookUserId, this.instagramUserId,
         this.localidad, this.copos, this.coposUsuarios, this.edad, this.fullname, this.image);

  User.map(dynamic data) {
    this.id = data.containsKey('id')? data['id'] : 0;
    this.username = data.containsKey('username')? data['username'].toString() : "";
    this.email = data.containsKey('email')? data['email'].toString() : "";
    this.status = data.containsKey('status')? data['status'].toString() : "";
    this.createdAt = data.containsKey('createdAt')? data['createdAt'].toString() : "";
    this.updatedAt = data.containsKey('updatedAt')? data['updatedAt'].toString() : "";
    this.token = data.containsKey('token')? data['token'].toString() : "";
    this.nombre = data.containsKey('nombre')? data['nombre'].toString() : "";

    this.apellidos = data.containsKey('apellidos')? data['apellidos'].toString() : 0;
    this.longitud = data.containsKey('longitud')? data['longitud'] != null? data['longitud'].toString() : 0 : 0;
    this.latitud = data.containsKey('latitud')? data['latitud'] != null? data['latitud'].toString() : 0 : 0;
    this.altura = data.containsKey('altura')? data['altura'] != null? data['altura'].toString() : 0 : 0;
    this.telefono = data.containsKey('telefono')? data['telefono'].toString() : "";
    this.nivel = data.containsKey('nivel')? data['nivel'] != null? data['nivel'].toString() : "" : "";
    this.actividad = data.containsKey('actividad')? data['actividad'].toString() : "";

    this.visible = data.containsKey('visible')? data['visible'].toString() : "";
    this.ranking = data.containsKey('ranking')? data['ranking'] != null? data['ranking'].toString() : 0 : 0;
    this.fechaCambioRanking = data.containsKey('fecha_cambio_ranking')? data['fecha_cambio_ranking'].toString() : "";
    this.facebookUserId = data.containsKey('facebook_user_id')? data['facebook_user_id'].toString() : "";
    this.instagramUserId = data.containsKey('instagram_user_id')? data['instagram_user_id'].toString() : "";
    this.copos = data.containsKey('copos')? data['copos'] != null? data['copos'].toString() : 0 : 0;
    this.coposUsuarios = data.containsKey('copos_usuarios')? data['copos_usuarios'] != null? data['copos_usuarios'].toString() : 0 : 0;
    this.edad = data.containsKey('edad')? data['edad'] != null? data['edad'].toString() : 0 : 0;

    this.localidad = data.containsKey('localidad')? data['localidad'].toString() : "";
    this.fullname = data.containsKey('fullname')? data['fullname'].toString() : "";
    this.image = data.containsKey('image')? data['image'].toString() : "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg";
  }
}