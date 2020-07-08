import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snowin/src/utils/session.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/utils/app_localization.dart';

import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/pist.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/pages/reports/widgets/reports_list_tab.dart';
import 'package:snowin/src/pages/reports/widgets/ranking_list_tab.dart';
import 'package:snowin/src/pages/reports/widgets/my_reports_list_tab.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with TickerProviderStateMixin {
  Session _session = new Session();

  final _preferences = new Preferences();

  Timer _speedTimer;
  String _speed;
  bool _speedOn = false;

  Timer _locationTimer;
  bool _locationOn = true;

  TabController _tabControllerReports;

  bool _dialogTopVisible = false, _dialogBottomVisible = false;

  @override
  void initState() {
    super.initState();

    _tabControllerReports = TabController(vsync: this, length: 3);
    _speed = '0.00';

    // _locationTimer =
    //     Timer.periodic(Duration(seconds: 30), (Timer t) => updateLocation());

    //set location state
    //_session.preferences.token = '';
    setLocationState();
  }

  @override
  void dispose() {
    _tabControllerReports.dispose();
    _speedTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: CustomBottomMenu(
          item: 1,
        ),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            height: size.height,
            child: Stack(
              children: [
                CustomAppbar(
                  context: context,
                  image:
                      "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
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
                            unselectedLabelColor:
                                Color.fromRGBO(159, 159, 159, 1.0),
                            indicatorColor: Color.fromRGBO(29, 29, 27, 1.0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('REPORTES',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('RANKING',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText('MIS REPORTES',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 17)),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        height: size.height -
                            (70 +
                                48 +
                                75 +
                                70), //El alto de la pantalla menos el AppBar, topInfo, Tabs y MainMenu
                        child: TabBarView(
                            controller: _tabControllerReports,
                            children: <Widget>[
                              ReportsListTab(),
                              RankingListTab(),
                              MyReportsListTab(),
                            ]),
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
  Widget _topInfo() {
    return Container(
      height: 60,
      color: Color.fromRGBO(74, 74, 73, 1),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.terrain,
                size: 22,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                      _session.center != null
                          ? _session.center.name.toString()
                          : '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  Row(
                    children: [
                      AutoSizeText('Pista: ',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      AutoSizeText(
                          _session.pist != null
                              ? _session.pist.descripcion.toString()
                              : '',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(255, 224, 0, 1))),
                      Icon(
                        Icons.info,
                        size: 15,
                        color: Color.fromRGBO(255, 224, 0, 1),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            width: 2,
          ),
          GestureDetector(
            onTap: goToMapPage,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 224, 0, 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Icon(Icons.map,
                  size: 23, color: Color.fromRGBO(74, 74, 73, 1)),
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
                icon: Icon(
                  Icons.av_timer,
                  size: 28,
                  color:
                      _speedOn ? Color.fromRGBO(255, 224, 0, 1) : Colors.white,
                ),
                // onPressed: speedOnOff,
                onPressed: null,
              ),
              SizedBox(
                width: 3,
              ),
              AutoSizeText(_speed + ' km/h',
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ],
          ),
          Container(
            height: 26,
            width: 1,
            color: Colors.white,
          ),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 31,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: AutoSizeText(_session.closestFriends.length.toString(),
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showWarningsDialog() {
    print('show warnings dialog');
    final size = MediaQuery.of(context).size;
    _session.showReportWarnning = false;

    showDialog(
      context: context,
      child: Container(
        padding: EdgeInsets.only(top: 15),
        color: Colors.transparent,
        child: Column(
          children: [
            _session.recomendedTraks.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 216, 52, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: _dialogTopContent(),
                  )
                : Container(),
            _session.closestFriends.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: _dialogBottomContent(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _dialogTopContent() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 216, 52, 1),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  child: ClipPolygon(
                    sides: 8,
                    borderRadius: 5.0,
                    rotate: 113.0,
                    child: Container(
                      color: Color.fromRGBO(29, 29, 27, 1),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.exclamation,
                          size: 20,
                          color: Color.fromRGBO(255, 216, 52, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(_t(context, "warning").toUpperCase() + "!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                      Container(
                          width: size.width * 0.6,
                          child: AutoSizeText(_t(context, "recomendedPistes"),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  decoration: TextDecoration.none))),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _hideDialog(1);
                  },
                  child: Container(
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: buildRecomendedTraks(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: RaisedButton(
                    color: Color.fromRGBO(80, 79, 79, 1),
                    onPressed: goToMapPage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.map,
                          color: Color.fromRGBO(255, 216, 52, 1),
                          size: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        AutoSizeText(
                          _t(context, "pistesMap").toUpperCase(),
                          style: TextStyle(
                              color: Color.fromRGBO(255, 216, 52, 1),
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    color: Color.fromRGBO(29, 29, 27, 1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          _t(context, "understood").toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecomendedTraks() {
    final size = MediaQuery.of(context).size;
    List<Widget> elements = new List<Widget>();

    elements.add(SizedBox(
      height: 15.0,
    ));
    _session.recomendedTraks.forEach((element) {
      elements.add(Container(
          width: size.width * 0.55,
          child: AutoSizeText(
            element.descripcion.toString().trim(),
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.none),
            maxLines: 2,
          )));
      elements.add(SizedBox(
        height: 10.0,
      ));
    });

    return elements;
  }

  Widget _dialogBottomContent() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.01),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _hideDialog(2);
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.cancel),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.group,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    Column(
                      children: buildFriends(),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        _t(context, "toContact").toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildFriends() {
    List<Widget> elements = new List<Widget>();

    String friends = '', predicade = '';

    if (_session.closestFriends.length == 1) {
      friends = _session.closestFriends.first.username.toString();
      predicade = 'También está en ' + _session.center.name.toString() + '!';
    } else {
      if (_session.closestFriends.length == 2) {
        friends = _session.closestFriends.first.username.toString() +
            ' y ' +
            _session.closestFriends[1].username.toString();
      } else {
        friends = _session.closestFriends.first.username.toString() +
            ', ' +
            _session.closestFriends[1].username.toString() +
            ' y ' +
            (_session.closestFriends.length - 2).toString() +
            ' amigos más';
      }
      predicade = 'También están en ' + _session.center.name.toString() + '!';
    }

    elements.add(
      AutoSizeText(
        friends,
        style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none),
      ),
    );
    elements.add(
      AutoSizeText(
        predicade,
        style: TextStyle(
            fontSize: 15, color: Colors.black, decoration: TextDecoration.none),
      ),
    );

    return elements;
  }

  void _hideDialog(int identifier) {
    setState(() {
      (identifier == 1)
          ? _dialogTopVisible = false
          : _dialogBottomVisible = false;
    });
    Navigator.pop(context);
    showWarningsDialog();
    if (!_dialogTopVisible && !_dialogBottomVisible) {
      Navigator.pop(context);
    }
  }

//////////////////////////////////////////////////////////////Functions
  void setLocationState() {
    centroSki().then((value) {
      if (mounted) setState(() {});

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

  Future<void> centroSki() async {
    SnowinProvider().centroSki().then((response) {
      print('centro-ski response: ');
      print(response);
      if (response['ok']) {
        var data = response['data'];

        setState(() {
          _session.center = data['centroSki'] != null
              ? SkiCenter.map(data['centroSki'])
              : SkiCenter(0, 'No hay centro', 0.0, 0.0, []);
          _session.pist = data['pista'] != null
              ? Pist.map(data['pista'])
              : Pist(0, 'No hay pista', 0, 0, '', '', '', 0.0, 0.0);
          if (data['amigos'] != null) {
            final _castDataType = data['amigos'].cast<Map<String, dynamic>>();
            _session.closestFriends =
                _castDataType.map<User>((json) => User.map(json)).toList();
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
    await SnowinProvider().recomendedTraks().then((response) {
      print('advertencias response: ');
      print(response);
      if (response['ok']) {
        var data = response['data'];

        if (data != false) {
          if (data is String) {
            if (_session.showLocationWarnning) {
              DialogHelper.showSimpleDialog(context, data.toString());
              _session.showLocationWarnning = false;
              _dialogTopVisible =
                  _session.recomendedTraks.length > 0 ? true : false;
            }
          } else {
            final _castDataType = data.cast<Map<String, dynamic>>();
            _session.recomendedTraks =
                _castDataType.map<Pist>((json) => Pist.map(json)).toList();
            _dialogTopVisible =
                _session.recomendedTraks.length > 0 ? true : false;
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
    await SnowinProvider().closestFriends().then((response) {
      print('coordenadas-amigos response: ');
      print(response);
      if (response['ok']) {
        var data = response['data'];

        final _castDataType = data['amigos_serca'].cast<Map<String, dynamic>>();
        _session.closestFriends =
            _castDataType.map<User>((json) => User.map(json)).toList();
        _dialogBottomVisible =
            _session.closestFriends.length > 0 ? true : false;

        if (_session.showReportWarnning &&
            (_dialogTopVisible || _dialogBottomVisible)) {
          showWarningsDialog();
        }
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  // void updateGeoPosition() {
  //   final userSnowin = Provider.of<SnowinProvider>(context, listen: false);
  //get device position
  //   Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((position) {
  //     print('latitud: ' + position.latitude.toString());
  //     print('longitud: ' + position.longitude.toString());
  //     print('altitud: ' + position.altitude.toString());
  //     print('speed: ' + position.speed.toString());

  //     _preferences.latitude = position.latitude.toString();
  //     _preferences.longitude = position.longitude.toString();
  //     _preferences.altitude = position.altitude.toString();
  //     _preferences.speed = position.speed.toString();

  //     if (position.speed > 0) {
  //       List<String> speedArr = (position.speed * 3.6).toString().split('.');
  //       _speed = speedArr.first + '.' + speedArr.elementAt(1).substring(0, 2);
  //     }

  // SnowinProvider().posicion(position.latitude.toString(),
  //                           position.longitude.toString(),
  //                           position.altitude.toString()
  // SnowinProvider()
  //     .posicion(position)
  //     .then((response) {
  //   print(response);
  //   if (response['ok']) {
  //     setState(() {});
  //   } else {
  //     throw new Exception('Error');
  //   }
  // }).catchError((error) {
  //   print(error.toString());
  // });
  //   });
  // }

  // void updateLocation() {
  //get device position
  //   final userSnowin = Provider.of<SnowinProvider>(context, listen: false);
  //   Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((position) {
  //     print('update device location');
  //     print('latitud: ' + position.latitude.toString());
  //     print('longitud: ' + position.longitude.toString());
  //     print('altitud: ' + position.altitude.toString());
  //     print('speed: ' + position.speed.toString());

  //     _preferences.latitude = position.latitude.toString();
  //     _preferences.longitude = position.longitude.toString();
  //     _preferences.altitude = position.altitude.toString();
  //     _preferences.speed = position.speed.toString();
  //     userSnowin.userPosition = position;
  // SnowinProvider()
  //     .posicion(position)
  //     .then((response) {
  //   print(response);
  //   if (response['ok']) {
  //set location state
  //     setLocationState();
  //   } else {
  //     throw new Exception('Error');
  //   }
  // }).catchError((error) {
  //   print(error.toString());
  // });
  //   });
  // }

  // void speedOnOff() {
  //   print('on off speed');
  //   Geolocator().isLocationServiceEnabled().then((enabled) {
  //     if (enabled) {
  //       if (_speedOn) {
  //         if (_speedTimer.isActive) _speedTimer.cancel();
  //         setState(() {
  //           _speed = '0.00';
  //         });
  //       } else {
  //         var interval =
  //             _preferences.updatePositionInterval.toString().isNotEmpty
  //                 ? _preferences.updatePositionInterval
  //                 : '5';
  //         _speedTimer = Timer.periodic(
  //             Duration(seconds: int.parse(interval.toString())),
  //             (Timer t) => updateGeoPosition());
  //       }
  //       _speedOn = !_speedOn;
  //     } else {
  //       DialogHelper.showErrorDialog(context, 'Dispositivo GPS desactivado');
  //     }
  //   });
  // }

  void goToMapPage() {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));

    if (_session.center.id != 0) {
      Navigator.pushNamed(context, '/pistes-map');
    } else {
      DialogHelper.showSimpleDialog(
          context, 'No está cerca de ningún centro de ski.');
    }
  }

  Future<bool> goBack() async {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));
    return false;
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }
}
