import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new Preferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET
  //register from [1: facebook, 2: instagram]
  get registerFrom {
    return _prefs.getString('register_from') ?? '';
  }

  set registerFrom(String value) {
    _prefs.setString('register_from', value);
  }

  //userId
  get userid {
    return _prefs.getString('userid') ?? '';
  }

  set userid(String value) {
    _prefs.setString('userid', value);
  }

  //status
  get status {
    return _prefs.getString('status') ?? '';
  }

  set status(String value) {
    _prefs.setString('status', value);
  }

  //profile type
  get profileType {
    return _prefs.getString('profile_type') ?? '';
  }

  set profileType(String value) {
    _prefs.setString('profile_type', value);
  }

  //profile level
  get profileLevel {
    return _prefs.getString('profile_level') ?? '';
  }

  set profileLevel(String value) {
    _prefs.setString('profile_level', value);
  }

  //nombre
  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  //apellidos
  get apellidos {
    return _prefs.getString('apellidos') ?? '';
  }

  set apellidos(String value) {
    _prefs.setString('apellidos', value);
  }

  //razon_social
  get razonSocial {
    return _prefs.getString('razon_social') ?? '';
  }

  set razonSocial(String value) {
    _prefs.setString('razon_social', value);
  }

  //cuit_cuil
  get cuitCuil {
    return _prefs.getString('cuit_cuil') ?? '';
  }

  set cuitCuil(String value) {
    _prefs.setString('cuit_cuil', value);
  }

  //dni
  get dni {
    return _prefs.getString('dni') ?? '';
  }

  set dni(String value) {
    _prefs.setString('dni', value);
  }

  //telefono
  get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
  }

  //email
  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  //domicilio
  get domicilio {
    return _prefs.getString('domicilio') ?? '';
  }

  set domicilio(String value) {
    _prefs.setString('domicilio', value);
  }

  //disponible
  get disponible {
    return _prefs.getInt('disponible') ?? 0;
  }

  set disponible(int value) {
    _prefs.setInt('disponible', value);
  }

  //id_chofer
  get idChofer {
    return _prefs.getString('id_chofer') ?? '';
  }

  set idChofer(String value) {
    _prefs.setString('id_chofer', value);
  }

  //patente_camion
  get patenteCamion {
    return _prefs.getString('patente_camion') ?? '';
  }

  set patenteCamion(String value) {
    _prefs.setString('patente_camion', value);
  }

  //id_tipo_camion
  get idTipoCamion {
    return _prefs.getString('id_tipo_camion') ?? '';
  }

  set idTipoCamion(String value) {
    _prefs.setString('id_tipo_camion', value);
  }

  //marca_camion
  get idMarcaCamion {
    return _prefs.getString('id_marca_camion') ?? '';
  }

  set idMarcaCamion(String value) {
    _prefs.setString('id_marca_camion', value);
  }

  //anno_camion
  get annoCamion {
    return _prefs.getString('anno_camion') ?? '';
  }

  set annoCamion(String value) {
    _prefs.setString('anno_camion', value);
  }

  //patente_acoplado
  get patenteAcoplado {
    return _prefs.getString('patente_acoplado') ?? '';
  }

  set patenteAcoplado(String value) {
    _prefs.setString('patente_acoplado', value);
  }

  //id_tipo_acoplado
  get idTipoAcoplado {
    return _prefs.getString('id_tipo_acoplado') ?? '';
  }

  set idTipoAcoplado(String value) {
    _prefs.setString('id_tipo_acoplado', value);
  }

  //marca_acoplado
  get idMarcaAcoplado {
    return _prefs.getString('id_marca_acoplado') ?? '';
  }

  set idMarcaAcoplado(String value) {
    _prefs.setString('id_marca_acoplado', value);
  }

  //anno_acoplado
  get annoAcoplado {
    return _prefs.getString('anno_acoplado') ?? '';
  }

  set annoAcoplado(String value) {
    _prefs.setString('anno_acoplado', value);
  }

  //access_token
  get accessToken {
    return _prefs.getString('access_token') ?? '';
  }

  set accessToken(String value) {
    _prefs.setString('access_token', value);
  }

  //token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  //id_viaje
  get idViaje {
    return _prefs.getString('id_viaje') ?? '';
  }

  set idViaje(String value) {
    _prefs.setString('id_viaje', value);
  }

  //id_destino
  get idDestino {
    return _prefs.getString('id_destino') ?? '';
  }

  set idDestino(String value) {
    _prefs.setString('id_destino', value);
  }

  //cupo
  get cupo {
    return _prefs.getString('cupo') ?? '';
  }

  set cupo(String value) {
    _prefs.setString('cupo', value);
  }

  //id_estado del viaje
  get idEstado {
    return _prefs.getString('id_estado') ?? '';
  }

  set idEstado(String value) {
    _prefs.setString('id_estado', value);
  }

  //id_consulta del chofer
  get idConsulta {
    return _prefs.getString('id_consulta') ?? '';
  }

  set idConsulta(String value) {
    _prefs.setString('id_consulta', value);
  }

  //seguro
  get seguro {
    return _prefs.getString('seguro') ?? '';
  }

  set seguro(String value) {
    _prefs.setString('seguro', value);
  }

  //update_position_interval
  get updatePositionInterval {
    return _prefs.getString('update_position_interval') ?? '';
  }

  set updatePositionInterval(String value) {
    _prefs.setString('update_position_interval', value);
  }

  //latitude
  get latitude {
    return _prefs.getString('latitude') ?? '';
  }

  set latitude(String value) {
    _prefs.setString('latitude', value);
  }

  //longitude
  get longitude {
    return _prefs.getString('longitude') ?? '';
  }

  set longitude(String value) {
    _prefs.setString('longitude', value);
  }

  //altitude
  get altitude {
    return _prefs.getString('altitude') ?? '';
  }

  set altitude(String value) {
    _prefs.setString('altitude', value);
  }

  //speed
  get speed {
    return _prefs.getString('speed') ?? '';
  }

  set speed(String value) {
    _prefs.setString('speed', value);
  }

  //producto
  get producto {
    return _prefs.getString('producto') ?? '';
  }

  set producto(String value) {
    _prefs.setString('producto', value);
  }

  //token notificacion
  get tokenNotificacion {
    return _prefs.getString('token_notificacion') ?? '';
  }

  set tokenNotificacion(String value) {
    _prefs.setString('token_notificacion', value);
  }

  //pais
  get pais {
    return _prefs.getString('pais') ?? '';
  }

  set pais(String value) {
    _prefs.setString('pais', value);
  }

  //provincia
  get provincia {
    return _prefs.getString('provincia') ?? '';
  }

  set provincia(String value) {
    _prefs.setString('provincia', value);
  }

  //localidad
  get localidad {
    return _prefs.getString('localidad') ?? '';
  }

  set localidad(String value) {
    _prefs.setString('localidad', value);
  }

  //nombreDestino
  get nombreDestino {
    return _prefs.getString('nombreDestino') ?? '';
  }

  set nombreDestino(String value) {
    _prefs.setString('nombreDestino', value);
  }

  //turneada
  get turneada {
    return _prefs.getString('turneada') ?? '';
  }

  set turneada(String value) {
    _prefs.setString('turneada', value);
  }
}
