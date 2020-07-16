import 'package:flutter/material.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:snowin/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snowin/src/repository/snowin_repository.dart';
import 'package:snowin/src/utils/utils.dart' as utils;
import 'package:sweetalert/sweetalert.dart';

class MenuItems {
  String name;
  IconData icon;
  MenuItems({this.icon, this.name});
}

class Menu extends StatefulWidget {
  final String activeMenuItems;

  Menu({this.activeMenuItems});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _prefs = Preferences();
  bool _estadoDisponible = (Preferences().disponible == 1 ? true : false);
  SnowinRepository muvinProvider = SnowinRepository();
  navigatorRemoveUntil(BuildContext context, String router) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/$router', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20.0, top: 30.0, right: 20.0, bottom: 0.0),
            color: Color.fromRGBO(0, 76, 153, 1),
            height: 180.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        navigatorRemoveUntil(context, 'actualizarusuario');
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, top: 60),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Hola ${_prefs.nombre}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 177, 230, 1)),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Mi cuenta',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: new Expanded(
              child: new ListView(
                //padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _menuOpcion(
                              context, 'home', Icons.home, 'Inicio', true),
                          _menuOpcion(context, 'consultas', Icons.mail,
                              'Consultas', true),
                          _menuOpcion(context, 'compartir', Icons.share,
                              'Compartir', true),
                          //_menuOpcion(context,'consultas',Icons.lock_open,'Disponible'),
                          SwitchListTile(
                            contentPadding: EdgeInsets.only(left: 25.0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  _estadoDisponible
                                      ? Icons.lock_open
                                      : Icons.lock,
                                  color: blackColor,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  'Disponible',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            value: _estadoDisponible,
                            onChanged: (valor) {
                              setState(() {
                                _estadoDisponible = valor;
                                _accionCambiarDisponibilidad(valor);
                              });
                            },
                          ),
                          _menuOpcion(context, 'novedades', Icons.notifications,
                              'Novedades', true),
                          _menuOpcion(context, 'seguros', Icons.assignment,
                              'Seguros', (_prefs.seguro == '1') ? true : false),
                          _menuOpcion(context, 'beneficios', Icons.local_offer,
                              'Beneficios', true),
                          _menuOpcion(context, 'logout',
                              FontAwesomeIcons.signOutAlt, 'Salir', true),
                        ],
                      ),
                      // The drawer's "details" view.
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuOpcion(BuildContext context, String opcion, IconData icon,
      String label, bool habilitar) {
    return GestureDetector(
      onTap: habilitar
          ? () {
              Navigator.pop(context);
              if (opcion == 'logout') {
                _prefs.annoAcoplado = '';
                _prefs.annoCamion = '';
                _prefs.apellidos = '';
                _prefs.cuitCuil = '';
                _prefs.cupo = '';
                _prefs.disponible = 0;
                _prefs.dni = '';
                _prefs.domicilio = '';
                _prefs.email = '';
                _prefs.idChofer = '';
                _prefs.idConsulta = '';
                _prefs.idDestino = '';
                _prefs.idEstado = '';
                _prefs.idMarcaAcoplado = '';
                _prefs.idMarcaCamion = '';
                _prefs.idTipoAcoplado = '';
                _prefs.idTipoCamion = '';
                _prefs.idViaje = '';
                _prefs.latitude = '';
                _prefs.longitude = '';
                _prefs.nombre = '';
                _prefs.patenteAcoplado = '';
                _prefs.patenteCamion = '';
                _prefs.producto = '';
                _prefs.razonSocial = '';
                _prefs.seguro = '';
                _prefs.telefono = '';
              }
              navigatorRemoveUntil(context, opcion);
            }
          : null,
      child: new Container(
        height: 60.0,
        color: this.widget.activeMenuItems.compareTo(opcion.toUpperCase()) == 0
            ? greyColor
            : whiteColor,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: Icon(
                icon,
                color:
                    habilitar ? blackColor : Color.fromRGBO(154, 156, 157, 1),
              ),
            ),
            new Expanded(
              flex: 3,
              child: new Text(
                label,
                style: TextStyle(
                    fontSize: 20,
                    color: habilitar
                        ? blackColor
                        : Color.fromRGBO(154, 156, 157, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _accionCambiarDisponibilidad(bool valor) async {
    Map info;
    if (valor) {
      _prefs.disponible = 1;
      //info = await muvinProvider.activarChofer();
    } else {
      _prefs.disponible = 0;
      //info = await muvinProvider.desactivarChofer();
    }
    if (info['ok']) {
      /* Future.delayed(Duration(microseconds: 750), () {
        utils.mostrarAlerta(context, 'Se le envió un sms a su amigo.');
      }); */
    } else {
      //errores
      //info["errores"]
      info['errores'].forEach((m) {
        //utils.mostrarAlerta(context, m['message']);
        utils.mostrarAlerta2(
            context, "Algo salió mal", m['message'], SweetAlertStyle.error);
      });
    }
  }
}
