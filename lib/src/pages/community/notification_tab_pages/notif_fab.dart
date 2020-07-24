import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/widget/notif_filter_dialog.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';

class NotificationFab extends StatelessWidget {
  final ScrollController controller;

  const NotificationFab({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notif = Provider.of<NotificationProvider>(context);
    return Align(
      child: Container(
        margin: EdgeInsets.only(bottom: 40.0),
        child: notif.loading
            ? Container(
                width: 50.0,
                height: 50.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Center(
                        child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ))),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFabIcon(
                    heroTag: "btnNotifFilter",
                    isPrimary: false,
                    icon: Icons.filter_list,
                    action: () =>
                        null, /*showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => NotifFilterDialog(
                        size: size,
                      ),
                    ),*/
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomFabIcon(
                    heroTag: "btnNotifSearch",
                    icon: Icons.search,
                    isPrimary: false,
                    action: () => null,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  notif.showTopButon
                      ? CustomFabIcon(
                          heroTag: "btnNotifUp",
                          isPrimary: true, //True - azul, false - grey
                          icon: Icons.expand_less,
                          action: () {
                            controller.animateTo(0.0,
                                duration: new Duration(
                                    seconds: (notif.page < 3 ? notif.page : 3)),
                                curve: Curves.ease);
                          },
                        )
                      : new SizedBox(width: 0.0, height: 0.0)
                ],
              ),
      ),
      alignment: FractionalOffset.bottomCenter,
    );
  }

  // void showFiltersDialog() {
  //   final size = MediaQuery.of(context).size;
  //   print('show filters dialog');
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return new AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           content: SingleChildScrollView(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width * 0.9,
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   border: Border.all(style: BorderStyle.none),
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //               child: ListTile(
  //                 title: Column(
  //                   children: <Widget>[
  //                     ListTile(
  //                       title: Text(
  //                         'Filtros',
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18),
  //                       ),
  //                       trailing: IconButton(
  //                           icon: Icon(Icons.cancel),
  //                           onPressed: () {
  //                             Navigator.of(context).pop(false);
  //                           }),
  //                     ),
  //                     ListTile(
  //                         title: Text('Titulo'),
  //                         subtitle: CustomTextField(
  //                             width: size.width * 0.9,
  //                             controller: _controllerTitle,
  //                             onChanged: (value) {
  //                               _title =
  //                                   value.trim().isNotEmpty ? value.trim() : '';
  //                             })),
  //                     ListTile(
  //                         title: Text('Comentario'),
  //                         subtitle: CustomTextField(
  //                             width: size.width * 0.9,
  //                             controller: _controllerComment,
  //                             onChanged: (value) {
  //                               _comment =
  //                                   value.trim().isNotEmpty ? value.trim() : '';
  //                             })),
  //                     ListTile(
  //                         title: Text('Calidad nieve'),
  //                         subtitle: CustomDropdownd(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             items: _calidadNieveItems,
  //                             value: _calidadNieve,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _calidadNieve = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         title: Text('Clima'),
  //                         subtitle: CustomDropdownd(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             items: _climaItems,
  //                             value: _clima,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _clima = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         title: Text('Viento'),
  //                         subtitle: CustomDropdownd(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             items: _vientoItems,
  //                             value: _viento,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _viento = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         title: Text('Espera en medios'),
  //                         subtitle: CustomDropdownd(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             items: _esperaMediosItems,
  //                             value: _esperaMedios,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _esperaMedios = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         title: Text('Ordenar'),
  //                         subtitle: CustomSort(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             text: 'Id de reporte',
  //                             value: _sortIdNotifications,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _sortIdNotifications = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         subtitle: CustomSort(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             text: 'Fecha',
  //                             value: _sortSeed,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _sortSeed = value;
  //                               });
  //                             })),
  //                     ListTile(
  //                         subtitle: CustomSort(
  //                             width: size.width * 0.9,
  //                             height: 50,
  //                             text: 'Calificación',
  //                             value: _sortCalificacion,
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 _sortCalificacion = value;
  //                               });
  //                             })),
  //                     SizedBox(
  //                       height: size.height * 0.03,
  //                     ),
  //                   ],
  //                 ),
  //                 subtitle: ButtonBar(
  //                     alignment: MainAxisAlignment.center,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       //cancelar
  //                       RaisedButton(
  //                         shape: RoundedRectangleBorder(
  //                             side: BorderSide.none,
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(20.0))),
  //                         child: const Text(
  //                           'CANCELAR',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         color: Colors.black87,
  //                         onPressed: () {
  //                           Navigator.of(context).pop(false);
  //                         },
  //                       ),
  //                       //aplicar filtros
  //                       RaisedButton(
  //                         shape: RoundedRectangleBorder(
  //                             side: BorderSide.none,
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(20.0))),
  //                         child: const Text(
  //                           'PALICAR FILTROS',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         color: Theme.of(context).primaryColor,
  //                         onPressed: () {
  //                           Navigator.of(context).pop(false);
  //                           // refreshing();
  //                         },
  //                       ),
  //                     ]),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
