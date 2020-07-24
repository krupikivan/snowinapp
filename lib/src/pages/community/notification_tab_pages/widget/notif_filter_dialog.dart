import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_sort.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';

//Todo: No se entiende este filtro, esta copiado al de reportes
class NotifFilterDialog extends StatelessWidget {
  TextEditingController controllerTitle = TextEditingController(text: '');
  TextEditingController controllerComment = TextEditingController(text: '');
  final Size size;

  NotifFilterDialog({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notif = Provider.of<NotificationProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: ListTile(
            title: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Filtros',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                ),
                ListTile(
                    title: Text('Titulo'),
                    subtitle: CustomTextField(
                        width: size.width * 0.9,
                        controller: controllerTitle,
                        onChanged: (value) {
                          notif.title =
                              value.trim().isNotEmpty ? value.trim() : '';
                        })),
                ListTile(
                    title: Text('Comentario'),
                    subtitle: CustomTextField(
                        width: size.width * 0.9,
                        controller: controllerComment,
                        onChanged: (value) {
                          notif.comment =
                              value.trim().isNotEmpty ? value.trim() : '';
                        })),
                ListTile(
                    title: Text('Calidad nieve'),
                    subtitle: CustomDropdownd(
                        width: size.width * 0.9,
                        height: 50,
                        items: notif.calidadNieveItems,
                        value: notif.calidadNieve,
                        onChanged: (value) {
                          print(value);
                          // setState(() {
                          notif.calidadNieve = value;
                          // });
                        })),
                ListTile(
                    title: Text('Clima'),
                    subtitle: CustomDropdownd(
                        width: size.width * 0.9,
                        height: 50,
                        items: notif.climaItems,
                        value: notif.clima,
                        onChanged: (value) {
                          print(value);
                          // setState(() {
                          notif.clima = value;
                          // });
                        })),
                ListTile(
                    title: Text('Viento'),
                    subtitle: CustomDropdownd(
                        width: size.width * 0.9,
                        height: 50,
                        items: notif.vientoItems,
                        value: notif.viento,
                        onChanged: (value) {
                          print(value);
                          // setState(() {
                          notif.viento = value;
                          // });
                        })),
                ListTile(
                    title: Text('Espera en medios'),
                    subtitle: CustomDropdownd(
                        width: size.width * 0.9,
                        height: 50,
                        items: notif.esperaMediosItems,
                        value: notif.esperaMedios,
                        onChanged: (value) {
                          print(value);
                          // setState(() {
                          notif.esperaMedios = value;
                          // });
                        })),
                ListTile(
                    title: Text('Ordenar'),
                    subtitle: CustomSort(
                        width: size.width * 0.9,
                        height: 50,
                        text: 'Id de reporte',
                        value: notif.sortIdNotifications,
                        onChanged: (value) {
                          print(value);
                          // setState(() {
                          notif.sortIdNotifications = value;
                          // });
                        })),
                ListTile(
                    subtitle: CustomSort(
                        width: size.width * 0.9,
                        height: 50,
                        text: 'Fecha',
                        value: notif.sortSeed,
                        onChanged: (value) {
                          print(value);
                          notif.sortSeed = value;
                        })),
                ListTile(
                    subtitle: CustomSort(
                        width: size.width * 0.9,
                        height: 50,
                        text: 'Calificación',
                        value: notif.sortCalificacion,
                        onChanged: (value) {
                          print(value);
                          notif.sortCalificacion = value;
                        })),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
            subtitle: ButtonBar(
                alignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //cancelar
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: const Text(
                      'CANCELAR',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black87,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  //aplicar filtros
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: const Text(
                      'PALICAR FILTROS',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      // refreshing();
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
