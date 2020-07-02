import 'package:flutter/material.dart';

import 'package:snowin/src/utils/session.dart';

import 'package:snowin/src/models/report.dart';
import 'package:snowin/src/models/item_kv.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/pages/reports/widgets/reports_tile.dart';
import 'package:snowin/src/pages/reports/new_report.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import 'package:snowin/src/widgets/custom_sort.dart';



class MyReportsListTab extends StatefulWidget {

  MyReportsListTab({ Key key}) : super(key: key);

  @override
  MyReportsListTabState createState() => new MyReportsListTabState();
}

class MyReportsListTabState extends State<MyReportsListTab> {
  Session _session = new Session();

  double deviceHeight = 0;
  int page = 0, qtty = 10;
  bool _isLoading = false, _showTopButon = false;
  ScrollController _scrollController;
  List<Report> _allMyReports = new List<Report>();

  TextEditingController _controllerTitle;
  String _title = '';
  TextEditingController _controllerComment;
  String _comment = '';
  List<ItemKV> _trackItems;
  String _track = '';
  List<ItemKV> _calidadNieveItems;
  String _calidadNieve = '';
  List<ItemKV> _climaItems;
  String _clima = '';
  List<ItemKV> _vientoItems;
  String _viento = '';
  List<ItemKV> _sensacionGeneralItems;
  String _sensacionGeneral = '';
  List<ItemKV> _esperaMediosItems;
  String _esperaMedios = '';

  bool _sortIdReporte = false;
  bool _sortFecha = false;
  bool _sortCalificacion = false;



  @override
  void initState() {
    super.initState();

    _controllerTitle = TextEditingController();
    _controllerTitle.text = '';
    _controllerComment = TextEditingController();
    _controllerComment.text = '';

    _calidadNieveItems = [ItemKV('', '')];
    _climaItems = [ItemKV('', '')];
    _vientoItems = [ItemKV('', '')];
    _sensacionGeneralItems = [ItemKV('', '')];
    _esperaMediosItems = [ItemKV('', '')];

    _scrollController = new ScrollController()..addListener(scrollListener);
    startLoader();

    loadTraks().then((value) {
        setState(() {});
    });

    loadEmuns().then((value) {
        setState(() {});
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical:15),
      child: new RefreshIndicator(
                  child: new Scrollbar(
                    child: new Stack(
                          children: <Widget>[
                              buildMyReportsTiles(),
                              buildflotingActionButtons(),
                          ],
                      ),
                  ),
                  onRefresh: refreshing,
                ),
    );
  }



//////////////////////////////////////////////////////////////////////////// Widget
  Widget buildMyReportsTiles() {
    return _allMyReports.length > 0?
            new ListView.builder(
                padding: const EdgeInsets.all(5.0),
                controller: _scrollController,
                itemCount: _allMyReports.length + 1,
                itemBuilder: (context, i) {
                  if(i < _allMyReports.length)
                      return ReportsTile(report: _allMyReports[i], afterValorate: (value, message) {
                          if(value != 0) {
                              _allMyReports.firstWhere((element) => element.id.toString() == _allMyReports[i].id.toString()).copos = value;
                              setState(() {});
                          } else {
                              showWarningsDialog(message);
                          }
                      },);
                  else
                      return SizedBox(height: 70.0);
                })
                :
                _isLoading?
                      new ListTile(
                        title: new Text('Buscando ...'),
                      )
                      :
                      new ListTile(
                        title: new Text('No hay registros'),
                      );
  }

  Widget buildflotingActionButtons() {
    return new Align(
            child: Container(
              margin: EdgeInsets.only(left: 32, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading?
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(child: new CircularProgressIndicator(
                                                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                                      ))),
                        ) : new SizedBox(width: 0.0, height: 0.0),
                  SizedBox(width: 10,),
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Color.fromRGBO(29, 29, 27, 1.0),
                    child: Icon(Icons.filter_list),
                    onPressed: showFiltersDialog,
                  ),
                  SizedBox(width: 10,),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.add),
                    onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => NewReport(
                                              youAre: _session.center.name.toString(),
                                              trackItems: _trackItems,
                                              calidadNieveItems: _calidadNieveItems,
                                              climaItems: _climaItems,
                                              vientoItems: _vientoItems,
                                              sensacionGeneralItems: _sensacionGeneralItems,
                                              esperaMediosItems: _esperaMediosItems,
                                              onSend: () {
                                                  refreshing();
                                              },
                                          ),
                              )
                          );
                      }
                  ),
                  SizedBox(width: 10,),
                  _showTopButon?
                        FloatingActionButton(
                          heroTag: "btn3",
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.expand_less),
                          onPressed: () {
                              _scrollController.animateTo(0.0, duration: new Duration(seconds: (page < 3? page : 3)), curve: Curves.ease);
                          },
                        ) : new SizedBox(width: 0.0, height: 0.0)
                ],
              ),
            ),
            alignment: FractionalOffset.bottomCenter,
          );
  }

  void showFiltersDialog() {
    final size = MediaQuery.of(context).size;
    print('show filters dialog');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(style:BorderStyle.none),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: ListTile(
                                  title: Column(
                                    children: <Widget>[
                                        ListTile(
                                            title: Text('Filtros', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                            trailing: IconButton(icon: Icon(Icons.cancel),
                                                          onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                          }
                                                      ),
                                        ),
                                        ListTile(
                                            title: Text('Titulo'),
                                            subtitle: CustomTextField(width: size.width*0.9, controller: _controllerTitle, onChanged: (value) {
                                            _title = value.trim().isNotEmpty? value.trim() : '';
                                        })),
                                        ListTile(
                                            title: Text('Comentario'),
                                            subtitle: CustomTextField(width: size.width*0.9, controller: _controllerComment, onChanged: (value) {
                                            _comment = value.trim().isNotEmpty? value.trim() : '';
                                        })),
                                        ListTile(
                                            title: Text('Calidad nieve'),
                                            subtitle: CustomDropdownd(width: size.width*0.9, height: 50, items: _calidadNieveItems, value: _calidadNieve, onChanged: (value) {
                                                print(value);
                                                setState(() { _calidadNieve = value; });
                                        })),
                                        ListTile(
                                            title: Text('Clima'),
                                            subtitle: CustomDropdownd(width: size.width*0.9, height: 50, items: _climaItems, value: _clima, onChanged: (value) {
                                                print(value);
                                                setState(() { _clima = value; });
                                        })),
                                        ListTile(
                                            title: Text('Viento'),
                                            subtitle: CustomDropdownd(width: size.width*0.9, height: 50, items: _vientoItems, value: _viento, onChanged: (value) {
                                                print(value);
                                                setState(() { _viento = value; });
                                        })),
                                        ListTile(
                                            title: Text('Espera en medios'),
                                            subtitle: CustomDropdownd(width: size.width*0.9, height: 50, items: _esperaMediosItems, value: _esperaMedios, onChanged: (value) {
                                                print(value);
                                                setState(() { _esperaMedios = value; });
                                        })),
                                        ListTile(
                                            title: Text('Ordenar'),
                                            subtitle: CustomSort(width: size.width*0.9, height: 50, text: 'Id de reporte', value: _sortIdReporte, onChanged: (value) {
                                                print(value);
                                                setState(() { _sortIdReporte = value; });
                                        })),
                                        ListTile(
                                            subtitle: CustomSort(width: size.width*0.9, height: 50, text: 'Fecha', value: _sortFecha, onChanged: (value) {
                                                print(value);
                                                setState(() { _sortFecha = value; });
                                        })),
                                        ListTile(
                                            subtitle: CustomSort(width: size.width*0.9, height: 50, text: 'Calificación', value: _sortCalificacion, onChanged: (value) {
                                                print(value);
                                                setState(() { _sortCalificacion = value; });
                                        })),
                                        SizedBox(height: size.height*0.03,),
                                    ],
                                  ),
                                  subtitle: ButtonBar(
                                                alignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget> [
                                                    //cancelar
                                                    RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                        ),
                                                        child: const Text('CANCELAR', style: TextStyle(color: Colors.white),),
                                                        color: Colors.black87,
                                                        onPressed: (){
                                                            Navigator.of(context).pop(false);
                                                        },
                                                    ),
                                                    //aplicar filtros
                                                    RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                        ),
                                                        child: const Text('PALICAR FILTROS', style: TextStyle(color: Colors.white),),
                                                        color: Theme.of(context).primaryColor,
                                                        onPressed: (){
                                                            Navigator.of(context).pop(false);
                                                            refreshing();
                                                        },
                                                    ),
                                                ]
                                            ),
                              ),
                        ),
            ),
          );
    });
  }






//////////////////////////////////////////////////////////////////////////// Functions
  void scrollListener() {
    if (_scrollController.position.pixels > deviceHeight) {
       if(!_showTopButon) {
          setState(() {
              _showTopButon = true;
          });
       }
    } else {
      if(_showTopButon) {
        setState(() {
              _showTopButon = false;
          });
      }
    }

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        startLoader();
    }
  }

  void startLoader() {
    if(mounted) setState(() {
      _isLoading = !_isLoading;
      fetchData();
    });
  }

  fetchData() async {
    loadMyReports(qtty, (page * qtty)).then((elements) {
        if(mounted) setState(() {
            if(page == 0) {
              _allMyReports.clear();
            }

            setState(() {
                _allMyReports.addAll(elements);
                _isLoading = !_isLoading;
                page++;
            });
        });
    }).whenComplete(() {
        print('done');
    });
  }

  Future<Null> refreshing() async {
    print(" refreshing ... ");
    page = 0;
    _allMyReports.clear();
    setState(() { });
    startLoader();
  }

  String prepareFilters() {
      List<String> filters = List<String>();
      filters.add('filtros[propios]=1');
      if(_title.isNotEmpty) filters.add('filtros[titulo]='+_title);
      if(_comment.isNotEmpty) filters.add('filtros[comentario]='+_comment);
      if(_calidadNieve.isNotEmpty) filters.add('filtros[calidad_nieve]='+_calidadNieve);
      if(_clima.isNotEmpty) filters.add('filtros[clima]='+_clima);
      if(_viento.isNotEmpty) filters.add('filtros[viento]='+_viento);
      if(_esperaMedios.isNotEmpty) filters.add('filtros[espera_medios]='+_esperaMedios);

      filters.add(_sortIdReporte? 'ordenes[idreporte]=ASC' : 'ordenes[idreporte]=DESC');
      filters.add(_sortFecha? 'ordenes[fecha]=ASC' : 'ordenes[fecha]=DESC');
      filters.add(_sortCalificacion? 'ordenes[calificacion]=ASC' : 'ordenes[calificacion]=DESC');

      return filters.join('&');

  }

  Future<List<Report>> loadMyReports(int limit, int offset) async {
      List<Report> elements = new List<Report>();

      await SnowinProvider().reportes(limit.toString(), offset.toString(), prepareFilters()).then((response) { print(response);
          if(response['ok']) {
              //var data = response['data'];

              final _castDataType = response['data'].cast<Map<String, dynamic>>();
              elements = _castDataType.map<Report>((json) => Report.map(json)).toList();

          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });

      return elements;
  }

  Future<void> loadTraks() async {
      setState(() { });

      _trackItems = new List<ItemKV>();
      _trackItems.add(ItemKV('', ''));
      _session.center.pistas.forEach((pista) {
          _trackItems.add(new ItemKV(pista.id, pista.descripcion));
          if(_trackItems.length == 1) _track = pista.id.toString();
      });
  }

  Future<void> loadEmuns() async {
      setState(() { });

      await SnowinProvider().loadEmuns().then((response) { print(response);
          if(response['ok']) {
              var data = response['data'];

              //cargar combo calidad_nieve
              if(data.containsKey('calidad_nieve')){
                  _calidadNieveItems = new List<ItemKV>();
                  _calidadNieveItems.add(ItemKV('', ''));
                  data['calidad_nieve'].forEach((k,v) {
                      _calidadNieveItems.add(new ItemKV(k, v));
                      if(_calidadNieveItems.length == 1) _calidadNieve = k.toString();
                  });
              }

              //cargar combo clima
              if(data.containsKey('clima')){
                  _climaItems = new List<ItemKV>();
                  _climaItems.add(ItemKV('', ''));
                  data['clima'].forEach((k,v) {
                      _climaItems.add(new ItemKV(k, v));
                      if(_climaItems.length == 1) _clima = k.toString();
                  });
              }

              //cargar combo viento
              if(data.containsKey('viento')){
                  _vientoItems = new List<ItemKV>();
                  _vientoItems.add(ItemKV('', ''));
                  data['viento'].forEach((k,v) {
                      _vientoItems.add(new ItemKV(k, v));
                      if(_vientoItems.length == 1) _viento = k.toString();
                  });
              }

              //cargar combo sensacion_general
              if(data.containsKey('sensacion_general')){
                  _sensacionGeneralItems = new List<ItemKV>();
                  _sensacionGeneralItems.add(ItemKV('', ''));
                  data['sensacion_general'].forEach((k,v) {
                      _sensacionGeneralItems.add(new ItemKV(k, v));
                      if(_sensacionGeneralItems.length == 1) _sensacionGeneral = k.toString();
                  });
              }

              //cargar combo espera_medios
              if(data.containsKey('espera_medios')){
                  _esperaMediosItems = new List<ItemKV>();
                  _esperaMediosItems.add(ItemKV('', ''));
                  data['espera_medios'].forEach((k,v) {
                      _esperaMediosItems.add(new ItemKV(k, v));
                      if(_esperaMediosItems.length == 1) _esperaMedios = k.toString();
                  });
              }

          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });
  }

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
                                  border: Border.all(style:BorderStyle.none),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: ListTile(
                                  title: Column(
                                    children: <Widget>[
                                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0)),
                                        ListTile(
                                            title: Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), softWrap: true,),
                                        ),
                                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0)),
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