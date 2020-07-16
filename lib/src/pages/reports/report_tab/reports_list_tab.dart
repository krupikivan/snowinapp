import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/pages/reports/widgets/fab_widget.dart';
import 'package:snowin/src/pages/reports/report_tab/report_tiles.dart';
import 'package:snowin/src/repository/report_repository.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/models/report.dart';
import 'package:snowin/src/models/item_kv.dart';
import 'package:snowin/src/repository/snowin_repository.dart';
import 'package:snowin/src/pages/reports/widgets/report_card.dart';
import 'package:snowin/src/pages/reports/new_report.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import 'package:snowin/src/widgets/custom_sort.dart';

class ReportsListTab extends StatefulWidget {
  ReportsListTab({Key key}) : super(key: key);

  @override
  ReportsListTabState createState() => new ReportsListTabState();
}

class ReportsListTabState extends State<ReportsListTab> {
  // UserProvider _session = new UserProvider();

  double deviceHeight = 0;
  // int page = 0;
  bool _showTopButon = false;
  ScrollController _scrollController;

  // TextEditingController _controllerTitle;
  // String _title = '';
  // TextEditingController _controllerComment;
  // String _comment = '';
  // List<ItemKV> _trackItems;
  // String _track = '';
  // List<ItemKV> _calidadNieveItems;
  // String _calidadNieve = '';
  // List<ItemKV> _climaItems;
  // String _clima = '';
  // List<ItemKV> _vientoItems;
  // String _viento = '';
  // List<ItemKV> _sensacionGeneralItems;
  // String _sensacionGeneral = '';
  // List<ItemKV> _esperaMediosItems;
  // String _esperaMedios = '';

  // bool _sortIdReporte = false;
  // bool _sortFecha = false;
  // bool _sortCalificacion = false;

  @override
  void initState() {
    super.initState();

    // _controllerTitle = TextEditingController();
    // _controllerTitle.text = '';
    // _controllerComment = TextEditingController();
    // _controllerComment.text = '';

    // _calidadNieveItems = [ItemKV('', 'Todos')];
    // _climaItems = [ItemKV('', 'Todos')];
    // _vientoItems = [ItemKV('', 'Todos')];
    // _sensacionGeneralItems = [ItemKV('', 'Todos')];
    // _esperaMediosItems = [ItemKV('', 'Todos')];

    _scrollController = new ScrollController()..addListener(scrollListener);
    Provider.of<ReportProvider>(context, listen: false).startLoader(false);
    // loadTraks().then((value) {
    //   setState(() {});
    // });

    // loadEmuns().then((value) {
    //   setState(() {});
    // });
  }

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    // _controllerTitle.dispose();
    // _controllerComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: RefreshIndicator(
          key: refreshkey,
          child: Stack(
            children: <Widget>[
              ReportTiles(
                controller: _scrollController,
              ),
              FabWidget(
                scrollController: _scrollController,
              ),
            ],
          ),
          onRefresh: () async {
            refreshkey.currentState.show(atTop: true);
            report.refreshing(false);
          }),
    );
  }

//////////////////////////////////////////////////////////////////////////// Widget

//////////////////////////////////////////////////////////////////////////// Functions
  void scrollListener() {
    if (_scrollController.position.pixels > deviceHeight) {
      if (!_showTopButon) {
        setState(() {
          _showTopButon = true;
        });
      }
    } else {
      if (_showTopButon) {
        setState(() {
          _showTopButon = false;
        });
      }
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    if (mounted)
      Provider.of<ReportProvider>(context, listen: false).changeLoading();
    fetchData();
  }

  void fetchData() async {
    final report = Provider.of<ReportProvider>(context, listen: false);
    await report.fetchAllReports(); //.then((elements) {
    if (mounted) {
      if (report.page == 0) {
        // report.clearReports();
      }
      report.changeLoading();
      report.pageSum();
    }
    // }).whenComplete(() {
    //   print('done');
    // });
  }

  // fetchData(ReportProvider report) async {
  //    int qtty = 10;
  //   report.loadReports(qtty, (page * qtty)).then((elements) {
  //     if (mounted)

  //       setState(() {
  //         if (page == 0) {
  //           _allReports.clear();
  //         }

  //         setState(() {
  //           _allReports.addAll(elements);
  //           _isLoading = !_isLoading;
  //           page++;
  //         });
  //       });

  //   }).whenComplete(() {
  //     print('done');
  //   });
  // }

  // Future<void> loadTraks() async {
  //   setState(() {});

  //   _trackItems = new List<ItemKV>();
  //   _trackItems.add(ItemKV('', 'Todos'));

  //   if (_session.center != null) {
  //     _session.center.pistas.forEach((pista) {
  //       _trackItems.add(new ItemKV(pista.id, pista.descripcion));
  //       if (_trackItems.length == 1) _track = pista.id.toString();
  //     });
  //   }
  // }

  // Future<void> loadEmuns() async {
  //   setState(() {});

  //   await SnowinRepository().loadEmuns().then((response) {
  //     print('enums response: ');
  //     print(response);
  //     if (response['ok']) {
  //       var data = response['data'];

  //       //cargar combo calidad_nieve
  //       if (data.containsKey('calidad_nieve')) {
  //         _calidadNieveItems = new List<ItemKV>();
  //         _session.calidadNieveItems = new List<ItemKV>();
  //         _calidadNieveItems.add(ItemKV('', 'Todos'));
  //         data['calidad_nieve'].forEach((k, v) {
  //           _calidadNieveItems.add(new ItemKV(k, v));
  //           _session.calidadNieveItems.add(new ItemKV(k, v));
  //           if (_calidadNieveItems.length == 1) _calidadNieve = k.toString();
  //         });
  //       }

  //       //cargar combo clima
  //       if (data.containsKey('clima')) {
  //         _climaItems = new List<ItemKV>();
  //         _session.climaItems = new List<ItemKV>();
  //         _climaItems.add(ItemKV('', 'Todos'));
  //         data['clima'].forEach((k, v) {
  //           _climaItems.add(new ItemKV(k, v));
  //           _session.climaItems.add(new ItemKV(k, v));
  //           if (_climaItems.length == 1) _clima = k.toString();
  //         });
  //       }

  //       //cargar combo viento
  //       if (data.containsKey('viento')) {
  //         _vientoItems = new List<ItemKV>();
  //         _session.vientoItems = new List<ItemKV>();
  //         _vientoItems.add(ItemKV('', 'Todos'));
  //         data['viento'].forEach((k, v) {
  //           _vientoItems.add(new ItemKV(k, v));
  //           _session.vientoItems.add(new ItemKV(k, v));
  //           if (_vientoItems.length == 1) _viento = k.toString();
  //         });
  //       }

  //       //cargar combo sensacion_general
  //       if (data.containsKey('sensacion_general')) {
  //         _sensacionGeneralItems = new List<ItemKV>();
  //         _session.sensacionGeneralItems = new List<ItemKV>();
  //         _sensacionGeneralItems.add(ItemKV('', 'Todos'));
  //         data['sensacion_general'].forEach((k, v) {
  //           _sensacionGeneralItems.add(new ItemKV(k, v));
  //           _session.sensacionGeneralItems.add(new ItemKV(k, v));
  //           if (_sensacionGeneralItems.length == 1)
  //             _sensacionGeneral = k.toString();
  //         });
  //       }

  //       //cargar combo espera_medios
  //       if (data.containsKey('espera_medios')) {
  //         _esperaMediosItems = new List<ItemKV>();
  //         _session.esperaMediosItems = new List<ItemKV>();
  //         _esperaMediosItems.add(ItemKV('', 'Todos'));
  //         data['espera_medios'].forEach((k, v) {
  //           _esperaMediosItems.add(new ItemKV(k, v));
  //           _session.esperaMediosItems.add(new ItemKV(k, v));
  //           if (_esperaMediosItems.length == 1) _esperaMedios = k.toString();
  //         });
  //       }
  //     } else {
  //       throw new Exception('Error');
  //     }
  //   }).catchError((error) {
  //     print(error.toString());
  //   });
  // }

  void showWarningsDialog(String message) {
    print('show warnings dialog');
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 224, 0, 1),
                        border: Border.all(style: BorderStyle.none),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: ListTile(
                      title: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0)),
                          ListTile(
                            title: Text(
                              message,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              softWrap: true,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
