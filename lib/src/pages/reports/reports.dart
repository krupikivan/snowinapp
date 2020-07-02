import 'dart:async';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:geolocator/geolocator.dart';

import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/pist.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/utils/session.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/main_menu.dart';
import 'package:snowin/src/pages/reports/widgets/reports_list_tab.dart';
import 'package:snowin/src/pages/reports/widgets/ranking_list_tab.dart';
import 'package:snowin/src/pages/reports/widgets/my_reports_list_tab.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with TickerProviderStateMixin{
  Session _session = new Session();

  Timer _positionTimer;
  final _preferences = new Preferences();

  String _speed;
  bool _speedOn = false;

  TabController _tabControllerReports;



  @override
  void initState() {
    super.initState();
    _tabControllerReports = TabController(vsync: this, length: 3);
    _speed = '0.00';

    //centro-ski
    centroSki().then((value) {
        if(mounted) setState(() {});

        //cargar pistas recomendadas
        recomendedTraks().then((value) {
            print(_session.recomendedTraks.length.toString());

            //cargar amigos serca
            closestFriends().then((value) {
                print(_session.closestFriends.length.toString());

                setState(() {});
            });
        });
    });

  }

  @override
  void dispose() {
    _tabControllerReports.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
          child: Scaffold(
            bottomNavigationBar: MainMenu(item: 1,),
            endDrawer: Container(width: 100.0, height: 200.0, color: Colors.blue,),
            body: SafeArea(
              child: Container(
                height: size.height,
                child: Stack(
                  children: [
                    CustomAppbar(
                      context: context,
                      image: "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      height: 70.0,
                      back: false,
                    ),

                    Positioned(
                      top: 70.0,
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                        children: [
                          _topInfo(),
                          Container(
                            height: 48,
                            child: TabBar(
                              controller: _tabControllerReports,
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Color.fromRGBO(159, 159, 159, 1.0),
                              indicatorColor: Color.fromRGBO(29, 29, 27, 1.0),
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText('REPORTES', maxLines: 1, style: TextStyle(fontSize: 17)),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText('RANKING', maxLines: 1, style: TextStyle(fontSize: 17)),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText('MIS REPORTES', maxLines: 1, style: TextStyle(fontSize: 17)),
                                  ),
                                ),
                              ]
                            ),
                          ),
                          Container(
                            height: size.height-(70+48+75+70), //El alto de la pantalla menos el AppBar, topInfo, Tabs y MainMenu
                            child: TabBarView(
                              controller: _tabControllerReports,
                              children: <Widget>[
                                ReportsListTab(),
                                RankingListTab(),
                                MyReportsListTab(),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onWillPop: goBack,
    );
  }


//////////////////////////////////////////////////////////////Widgets
  Widget _topInfo(){
    return Container(
      height: 60,
      color: Color.fromRGBO(74, 74, 73, 1),
      padding: EdgeInsets.symmetric(horizontal:8, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.terrain, size: 22, color: Colors.white,),
              SizedBox(width: 3,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(_session.center != null? _session.center.name.toString() : '', maxLines: 1, style: TextStyle(fontSize: 14, color: Colors.white)),
                  Row(
                    children: [
                      AutoSizeText('Pista: ', maxLines: 1, style: TextStyle(fontSize: 14, color: Colors.white)),
                      AutoSizeText(_session.pist != null? _session.pist.descripcion.toString() : '', maxLines: 1, style: TextStyle(fontSize: 14, color: Color.fromRGBO(255, 224, 0, 1))),
                      Icon(Icons.info, size: 15, color: Color.fromRGBO(255, 224, 0, 1),),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(width: 2,),
          GestureDetector(
            onTap: goToMapPage,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 224, 0, 1),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Icon(Icons.map, size: 23, color: Color.fromRGBO(74, 74, 73, 1)),
            ),
          ),
          Container(
            height: 26,
            width: 1,
            color: Colors.white,
          ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.av_timer, size: 28, color: _speedOn? Color.fromRGBO(255, 224, 0, 1) : Colors.white,),
                onPressed: speedOnOff,
              ),
              SizedBox(width: 3,),
              AutoSizeText(_speed + ' km/h', maxLines: 1, style: TextStyle(fontSize: 15, color: Colors.white)),
            ],
          ),
          Container(
            height: 26,
            width: 1,
            color: Colors.white,
          ),
          Row(
            children: [
              Icon(Icons.people, size: 31, color: Colors.white,),
              SizedBox(width: 3,),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: AutoSizeText(_session.closestFriends.length.toString(), maxLines: 1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showNoCentersNearWarning(String message) {
    print('show no center near warnings dialog');
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
                                        // Row(children: <Widget>[
                                        //     Expanded(child: Container()),
                                        //     IconButton(icon: Icon(Icons.cancel),
                                        //               onPressed: () {
                                        //                   Navigator.of(context).pop(false);
                                        //               })
                                        // ]),
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

  void showGeolocationDisabledWarning() {
    print('show geolocation disabled warning dialog');
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
                                            title: Text('Dispositivo GPS desactivado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), softWrap: true,),
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

  void showWarningsDialog() {
    print('show warnings dialog');
    _session.showReportWarnning = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                  children: <Widget>[

                    _session.recomendedTraks.length > 0?
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
                                        Row(children: <Widget>[
                                            Expanded(child: Container()),
                                            IconButton(icon: Icon(Icons.cancel),
                                                      onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                      })
                                        ]),
                                        ListTile(
                                            leading: Icon(Icons.warning, size: 30.0, color: Colors.black,),
                                            title: Text('ADVERTENCIA!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), softWrap: true,),
                                            subtitle: Text('Las pistas que recomendamos según su experiencia son:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), softWrap: true,),
                                        ),
                                        ListTile(
                                            title: Column(
                                                children: buildRecomendedTraks(),
                                            ),
                                        ),
                                        ListTile(
                                            title: ButtonBar(
                                                alignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    //mapa
                                                    RaisedButton.icon(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                        ),
                                                        icon: const Icon(Icons.map, color: Color.fromRGBO(255, 224, 0, 1),),
                                                        label: const Text('MAPA DE PISTAS', style: TextStyle(color: Color.fromRGBO(255, 224, 0, 1)),),
                                                        color: Colors.grey,
                                                        onPressed: goToMapPage,
                                                    ),

                                                    //entendido
                                                    RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                        ),
                                                        child: const Text('ENTENDIDO', style: TextStyle(color: Colors.white),),
                                                        color: Colors.black87,
                                                        onPressed: (){
                                                            Navigator.of(context).pop(false);
                                                        },
                                                    ),
                                                ]
                                            ),
                                        ),
                                    ],
                                  ),
                              ),
                        ) : Container(),

                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0)),

                    _session.closestFriends.length > 0?
                        Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(style:BorderStyle.none),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: ListTile(
                                  title: Column(
                                    children: <Widget>[
                                        Row(children: <Widget>[
                                            Expanded(child: Container()),
                                            IconButton(icon: Icon(Icons.cancel),
                                                      onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                      })
                                        ]),

                                        ListTile(
                                            title: ButtonBar(
                                                alignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    //contactar
                                                    RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                        ),
                                                        child: const Text('ENTENDIDO', style: TextStyle(color: Colors.white),),
                                                        color: Colors.black87,
                                                        onPressed: (){
                                                            //contact
                                                        },
                                                    ),
                                                ]
                                            ),
                                        ),

                                    ],
                                  ),
                              ),
                        ) : Container(),

                  ],
              ),
            ),
          );
    });
  }

  List<Widget> buildRecomendedTraks() {
    List<Widget> elements = new List<Widget>();

    _session.recomendedTraks.forEach((element) {
        elements.add(Text(element.descripcion));
    });

    return elements;
  }





//////////////////////////////////////////////////////////////Functions
  Future<void> centroSki() async {
      SnowinProvider().centroSki().then((response) { print('centro-ski response: '); print(response);
          if(response['ok']) {
              var data = response['data'];

              setState(() {
                  _session.center = data['centroSki'] != null? SkiCenter.map(data['centroSki']) : SkiCenter(0, 'No hay centro', 0.0, 0.0, []);
                  _session.pist = data['pista'] != null? Pist.map(data['pista']) : Pist(0, 'No hay pista', 0, 0, '', '', '', 0.0, 0.0);
                  if(data['amigos'] != null) {
                    final _castDataType = data['amigos'].cast<Map<String, dynamic>>();
                    _session.closestFriends = _castDataType.map<User>((json) => User.map(json)).toList();
                  }
              });
          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });
  }

  Future<void> recomendedTraks() async {
      SnowinProvider().recomendedTraks().then((response) { print('advertencias response: '); print(response);
          if(response['ok']) {
              var data = response['data'];

              if(data != false) {
                  if(data is String) {
                      showNoCentersNearWarning(data.toString());
                  } else {
                      final _castDataType = data.cast<Map<String, dynamic>>();
                      _session.recomendedTraks = _castDataType.map<Pist>((json) => Pist.map(json)).toList();
                  }
              }
          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });
  }

  Future<void> closestFriends() async {
      SnowinProvider().closestFriends().then((response) { print('coordenadas-amigos response: '); print(response);
          if(response['ok']) {
              var data = response['data'];

              final _castDataType = data['amigos_serca'].cast<Map<String, dynamic>>();
              _session.closestFriends = _castDataType.map<User>((json) => User.map(json)).toList();

              if(_session.showReportWarnning && (_session.recomendedTraks.isNotEmpty || _session.closestFriends.isNotEmpty)) {
                  showWarningsDialog();
              }
          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });
  }

  void updateGeoPosition() {
      //get device position
      Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
          print('latitud: ' + position.latitude.toString());
          print('longitud: ' + position.longitude.toString());
          print('altitud: ' + position.altitude.toString());
          print('speed: ' + position.speed.toString());

          _preferences.latitude = position.latitude.toString();
          _preferences.longitude = position.longitude.toString();
          _preferences.altitude = position.altitude.toString();
          _preferences.speed = position.speed.toString();

          if(position.speed > 0) {
              List<String> speedArr =  (position.speed * 3.6).toString().split('.');
              _speed = speedArr.first + '.' + speedArr.elementAt(1).substring(0, 2);
          }

          // SnowinProvider().posicion(position.latitude.toString(),
          //                           position.longitude.toString(),
          //                           position.altitude.toString())
          SnowinProvider().posicion('-34.4833333','-58.5166667','1000')
                          .then((response) { print(response);
                              if(response['ok']) {

                                  setState(() {});
                              } else {
                                  throw new Exception('Error');
                              }
                          }).catchError((error) {
                              print(error.toString());
                          });
      });
  }

  void speedOnOff() { print('on off speed');
      Geolocator().isLocationServiceEnabled().then((enabled) {
          if(enabled) {
              if(_speedOn) {
                  if(_positionTimer.isActive) _positionTimer.cancel();
                  setState(() { _speed = '0.00'; });
              } else {
                  var interval = _preferences.updatePositionInterval.toString().isNotEmpty? _preferences.updatePositionInterval : '5';
                  _positionTimer = Timer.periodic(Duration(seconds: int.parse(interval.toString())), (Timer t) => updateGeoPosition());
              }
              _speedOn = !_speedOn;
          } else {
              showGeolocationDisabledWarning();
          }
      });
  }

  void goToMapPage() {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));

    if(_session.center.id != 0) {
      Navigator.pushNamed(context, '/pistes-map');
    } else {
      showNoCentersNearWarning('No está cerca de ningún centro de ski.');
    }
  }

  Future<bool> goBack() async{
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }

}