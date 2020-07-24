import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/sos/widget/appbar_sos.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Sos extends StatefulWidget {
  @override
  _SosState createState() => _SosState();
}

class _SosState extends State<Sos> {
  bool clicked;
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    clicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: AppBarSos(
            scaffoldDrawer: scaffoldDrawer,
          ),
          preferredSize: Size(double.infinity, 70)),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      body: clicked ? clickedTrue() : clickedFalse(),
    );
  }

  Widget clickedFalse() {
    // Responsive TEXT
    final double fontSize = MediaQuery.of(context).size.width / 50 * 2.3;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: Colors.grey[800],
                size: 30,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Estas por avisar a la comunidad que estas en problemas o sufriste un accidente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Por favor utiliza el boton "AVISAR A AMIGOS" con responsabilidad. Si lo haces y tu llamado es falso tu cuenta sera desactivada.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Expanded(
              child: Text(
                'Este servicio no garantiza tu asistencia.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text('Es una herramienta comunitaria.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: Text(
                  'LLAMA A EMERGENCIAS CON EL BOTON ROJO PARA UNA RESPUESTA OFICIAL DEL CENTRO DE SKI DONDE TE ENCUENTRAS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).errorColor)),
            ),
            Expanded(
              child: FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    setState(() {
                      clicked = true;
                    });
                  },
                  label: Text(
                    'ENTENDIDO',
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget clickedTrue() {
    final position = Provider.of<Position>(context);
    final conex = Provider.of<ConnectionStatus>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Las coordenadas de tu ubicacion son',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 22),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    border: Border.all(width: 1, color: Colors.grey[400]),
                  ),
                  child: Column(
                    children: <Widget>[
                      _getLatLng('Latitud', position),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      _getLatLng('Longitud', position)
                    ],
                  ),
                ),
              ],
            ),
          ),
          _getButton(
              Icons.people,
              Colors.yellow,
              'AVISAR A AMIGOS',
              () => conex.status == Status.HasConnection
                  ? _showPopup()
                  : DialogHelper.showSimpleDialog(
                      context, 'Revise su conexion a internet'),
              false),
          SizedBox(height: 15),
          _getButton(Icons.call, Theme.of(context).errorColor, 'EMERGENCIAS',
              () => _makeCall(), true),
        ],
      ),
    );
  }

  Widget _getButton(IconData icon, Color color, String txt, VoidCallback action,
      bool isWhite) {
    final Color txtColor = isWhite == true ? Colors.white : Colors.black;
    return Expanded(
      child: InkWell(
        onTap: action,
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            color: color,
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 35, color: txtColor),
              SizedBox(width: 20),
              Text(
                txt,
                style: TextStyle(
                    color: txtColor,
                    fontSize: 25,
                    fontWeight: isWhite ? FontWeight.bold : FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLatLng(String title, Position position) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 25,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600),
          ),
          Text(
            title == 'Latitud'
                ? position.latitude.toString()
                : position.longitude.toString(),
            style: TextStyle(fontSize: 23),
          ),
        ],
      ),
    );
  }

  _showPopup() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          width: MediaQuery.of(context).size.width / 1.3,
          child: ListTile(
            title: Text(
              'Se ha avisado a sus amigos',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            leading: Icon(
              Icons.check,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  _makeCall() async {
    String url = 'tel:${911}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
