import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:muvin_app_choferes/theme/style.dart';
import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:sweetalert/sweetalert.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

String ajusteTexto(String cad, int cant) =>
    cad.length > cant ? cad.substring(0, cant - 4) + '...' : cad;

Widget otrosDatos(Widget icon, String texto, TextStyle styleT) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 30),
      icon,
      SizedBox(width: 5.0),
      Text(
        texto,
        style: styleT,
      )
    ],
  );
}

Widget otrosDatosCentrado(Widget icon, String texto, TextStyle styleT) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 30),
      icon,
      SizedBox(width: 5.0),
      Text(
        texto,
        style: styleT,
      )
    ],
  );
}

Widget otrosDatosMismoEstilo(String texto) {
  return otrosDatos(SizedBox(width: 30), texto,
      TextStyle(color: Color.fromRGBO(107, 107, 109, 1), fontSize: 22));
}

Widget detalleCarga(String texto) {
  return estiloDetallecarga(SizedBox(width: 2), texto,
      TextStyle(color: Color.fromRGBO(107, 107, 109, 1), fontSize: 20));
}

Widget estiloDetallecarga(Widget icon, String texto, TextStyle styleT) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 9),
      icon,
      SizedBox(width: 5.0),
      Text(
        texto,
        style: styleT,
      )
    ],
  );
}

Widget detalleCentrado(String texto) {
  return estiloDetalleCentrado(SizedBox(width: 2), texto,
      TextStyle(color: Color.fromRGBO(107, 107, 109, 1), fontSize: 20));
}

Widget estiloDetalleCentrado(Widget icon, String texto, TextStyle styleT) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 9),
      icon,
      SizedBox(width: 5.0),
      Text(
        texto,
        style: styleT,
      )
    ],
  );
}

Widget estiloDetalleMultiLinea(String texto, TextStyle styleT) {
  return Html(
    padding: EdgeInsets.only(left: 14.0, right: 14.0),
    data: texto,
    defaultTextStyle: styleT,
  );
}

String formatFecha(String fecha) {
  final fech = fecha.substring(5).split('-');
  return fech[1] + '/' + fech[0];
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información'),
          content: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: Text(mensaje)),
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Color.fromRGBO(0, 177, 230, 1),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

void mostrarAlerta2(BuildContext context, String titulo, String mensaje,
    SweetAlertStyle estilo) {
  SweetAlert.show(context, title: titulo, subtitle: mensaje, style: estilo);
}

getSnackBar(String mensaje) {
  return SnackBar(
    content: Text(mensaje),
    duration: Duration(microseconds: 10000),
  );
}

String formatearFecha(String fecha, String formato) {
  DateTime fechatemp = DateTime.parse(fecha);
  return DateFormat(formato, 'es_ES').format(fechatemp).toString();
}

// abrirMapaExternoEnCoordenadas(double latitude, double longitude) async {
//   String url =
//       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     //throw 'Could not launch $url';
//   }
// }

// abrirMapaExternoEnRuta(double latitudeOrigen, double longitudeOrigen,
//     double latitudeDestino, double longitudeDestino) async {
//   String url =
//       'https://www.google.com/maps/dir/?api=1&origin=$latitudeOrigen,$longitudeOrigen&destination=$latitudeDestino,$longitudeDestino&travelmode=driving';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     //throw 'Could not launch $url';
//   }
// }

/* class MensajeDialog extends StatelessWidget {
  String mensaje;
  MensajeDialog({String msg}) {
    mensaje = msg;
  }
  @override
  Widget build(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Información'),
            content: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
                child: Text(mensaje)),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                elevation: 0.0,
                color: Color.fromRGBO(0, 177, 230, 1),
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
} */
