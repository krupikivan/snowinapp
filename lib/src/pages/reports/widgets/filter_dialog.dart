import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_sort.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';

class FilterDialog extends StatelessWidget {
  TextEditingController controllerTitle = TextEditingController(text: '');
  TextEditingController controllerComment = TextEditingController(text: '');
  final Size size;

  FilterDialog({Key key, this.size}) : super(key: key);
  // @override
  // void initState() {
  //   super.initState();
  //   controllerTitle = TextEditingController(text: '');
  //   controllerComment = TextEditingController(text: '');
  // }

  // @override
  // void dispose() {
  //   controllerTitle.dispose();
  //   controllerComment.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: size.width * 0.9,
        height: size.height * 0.6,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 55),
              child: Container(
                height: size.height * 0.65,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Text('Titulo'),
                        subtitle: CustomTextField(
                            width: size.width * 0.9,
                            controller: controllerTitle,
                            onChanged: (value) {
                              report.title =
                                  value.trim().isNotEmpty ? value.trim() : '';
                            })),
                    ListTile(
                        title: Text('Comentario'),
                        subtitle: CustomTextField(
                            width: size.width * 0.9,
                            controller: controllerComment,
                            onChanged: (value) {
                              report.comment =
                                  value.trim().isNotEmpty ? value.trim() : '';
                            })),
                    ListTile(
                        title: Text('Calidad nieve'),
                        subtitle: CustomDropdownd(
                            width: size.width * 0.9,
                            height: 50,
                            items: report.calidadNieveItems,
                            value: report.calidadNieve,
                            onChanged: (value) {
                              print(value);
                              report.calidadNieve = value;
                            })),
                    ListTile(
                        title: Text('Clima'),
                        subtitle: CustomDropdownd(
                            width: size.width * 0.9,
                            height: 50,
                            items: report.climaItems,
                            value: report.clima,
                            onChanged: (value) {
                              print(value);
                              report.clima = value;
                            })),
                    ListTile(
                        title: Text('Viento'),
                        subtitle: CustomDropdownd(
                            width: size.width * 0.9,
                            height: 50,
                            items: report.vientoItems,
                            value: report.viento,
                            onChanged: (value) {
                              print(value);
                              report.viento = value;
                            })),
                    ListTile(
                        title: Text('Espera en medios'),
                        subtitle: CustomDropdownd(
                            width: size.width * 0.9,
                            height: 50,
                            items: report.esperaMediosItems,
                            value: report.esperaMedios,
                            onChanged: (value) {
                              print(value);
                              report.esperaMedios = value;
                            })),
                    ListTile(
                        title: Text('Ordenar'),
                        subtitle: CustomSort(
                            width: size.width * 0.9,
                            height: 50,
                            text: 'Id de reporte',
                            value: report.sortIdReporte,
                            onChanged: (value) {
                              print(value);
                              report.sortIdReporte = value;
                            })),
                    ListTile(
                        subtitle: CustomSort(
                            width: size.width * 0.9,
                            height: 50,
                            text: 'Fecha',
                            value: report.sortFecha,
                            onChanged: (value) {
                              print(value);
                              report.sortFecha = value;
                            })),
                    ListTile(
                        subtitle: CustomSort(
                            width: size.width * 0.9,
                            height: 50,
                            text: 'Calificación',
                            value: report.sortCalificacion,
                            onChanged: (value) {
                              print(value);
                              report.sortCalificacion = value;
                            })),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: ListTile(
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
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.55),
                child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //cancelar
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'CANCELAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black87,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      //reset filtros
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'LIMPIAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          report.clearFilters();
                          controllerTitle.clear();
                          controllerComment.clear();
                          // Navigator.of(context).pop(false);
                          // showFiltersDialog(context, report);
                        },
                      ),
                      //aplicar filtros
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'APLICAR',
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
            )
          ],
        ),
      ),
    );
  }
}
