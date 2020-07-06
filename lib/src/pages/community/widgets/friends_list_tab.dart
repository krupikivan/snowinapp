import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:snowin/src/utils/session.dart';

import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/models/item_kv.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/pages/community/widgets/friend_tile_list.dart';
import 'package:snowin/src/pages/community/widgets/friend_tile_profile.dart';
import 'package:snowin/src/pages/community/widgets/friend_tile_map.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import 'package:snowin/src/widgets/custom_sort.dart';

enum FriendVisualization { list, profile, map }

class FriendsListTap extends StatefulWidget {
  FriendsListTap({Key key}) : super(key: key);

  @override
  FriendsListTapState createState() => new FriendsListTapState();
}

class FriendsListTapState extends State<FriendsListTap> {
  Session _session = new Session();

  double deviceHeight = 0;
  int page = 0, qtty = 10;
  bool _isLoading = false, _showTopButon = false;
  ScrollController _scrollController;
  List<User> _allFriend = new List<User>();
  int _friendQtty = 0, _userQtty = 0;
  FriendVisualization _visualization = FriendVisualization.list;

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

  bool _sortIdFriend = false;
  bool _sortLocation = false;
  bool _sortUsername = false;

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
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerComment.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: new Stack(children: <Widget>[
        _topFriendBarr(),
        Padding(
          padding: EdgeInsets.only(top: 125.0),
          child: new RefreshIndicator(
            child: new Scrollbar(
              child: new Stack(
                children: <Widget>[
                  buildFriendTiles(),
                  buildflotingActionButtons(),
                ],
              ),
            ),
            onRefresh: refreshing,
          ),
        )
      ]),
    );
  }

//////////////////////////////////////////////////////////////////////////// Widget
  Widget _topFriendBarr() {
    return Container(
      height: 130.0,
      child: Column(
        children: <Widget>[
          Container(
              height: 45.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Color.fromRGBO(74, 74, 73, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(_friendQtty.toString() + ' Amigos y ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                  AutoSizeText(_userQtty.toString() + ' usuarios ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  AutoSizeText(' en ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.reorder),
                      onPressed: () {
                        if (_visualization != FriendVisualization.list) {
                          setState(() {
                            _visualization = FriendVisualization.list;
                          });
                        }
                      }),
                  Text('Lista'),
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.view_column),
                      onPressed: () {
                        if (_visualization != FriendVisualization.profile) {
                          setState(() {
                            _visualization = FriendVisualization.profile;
                          });
                        }
                      }),
                  Text('Perfil'),
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () {
                        if (_visualization != FriendVisualization.map) {
                          setState(() {
                            _visualization = FriendVisualization.map;
                          });
                        }
                      }),
                  Text('Mapa'),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget buildFriendTiles() {
    return _allFriend.length > 0
        ? new ListView.builder(
            padding: const EdgeInsets.all(5.0),
            controller: _scrollController,
            itemCount: _allFriend.length + 1,
            itemBuilder: (context, i) {
              if (i < _allFriend.length) {
                Widget widget = Container();

                switch (_visualization) {
                  case FriendVisualization.profile:
                    widget = FriendTileProfile(friend: _allFriend[i]);
                    break;
                  case FriendVisualization.map:
                    widget = FriendTileMap(friend: _allFriend[i]);
                    break;
                  default:
                    widget = FriendTileList(friend: _allFriend[i]);
                    break;
                }

                return widget;
              } else
                return SizedBox(height: 70.0);
            })
        : _isLoading
            ? new ListTile(
                title: new Text('Buscando ...'),
              )
            : new ListTile(
                title: new Text('No hay registros'),
              );
  }

  Widget buildflotingActionButtons() {
    return Align(
      child: Container(
        margin: EdgeInsets.only(bottom: 40.0),
        child: _isLoading
            ? Container(
                width: 50.0,
                height: 50.0,
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ))),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomFabIcon(
                    heroTag: "btn1",
                    isPrimary: false,
                    icon: Icons.filter_list,
                    action: showFiltersDialog,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomFabIcon(
                      heroTag: "btn2",
                      isPrimary: false,
                      icon: Icons.search,
                      action: () {}),
                  SizedBox(
                    width: 10,
                  ),
                  _showTopButon
                      ? CustomFabIcon(
                          heroTag: "btn3",
                          isPrimary: true,
                          icon: Icons.expand_less,
                          action: () {
                            _scrollController.animateTo(0.0,
                                duration:
                                    Duration(seconds: (page < 3 ? page : 3)),
                                curve: Curves.ease);
                          },
                        )
                      : SizedBox(width: 0.0, height: 0.0)
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
                    border: Border.all(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: ListTile(
                  title: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Filtros',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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
                              controller: _controllerTitle,
                              onChanged: (value) {
                                _title =
                                    value.trim().isNotEmpty ? value.trim() : '';
                              })),
                      ListTile(
                          title: Text('Comentario'),
                          subtitle: CustomTextField(
                              width: size.width * 0.9,
                              controller: _controllerComment,
                              onChanged: (value) {
                                _comment =
                                    value.trim().isNotEmpty ? value.trim() : '';
                              })),
                      ListTile(
                          title: Text('Calidad nieve'),
                          subtitle: CustomDropdownd(
                              width: size.width * 0.9,
                              height: 50,
                              items: _calidadNieveItems,
                              value: _calidadNieve,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _calidadNieve = value;
                                });
                              })),
                      ListTile(
                          title: Text('Clima'),
                          subtitle: CustomDropdownd(
                              width: size.width * 0.9,
                              height: 50,
                              items: _climaItems,
                              value: _clima,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _clima = value;
                                });
                              })),
                      ListTile(
                          title: Text('Viento'),
                          subtitle: CustomDropdownd(
                              width: size.width * 0.9,
                              height: 50,
                              items: _vientoItems,
                              value: _viento,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _viento = value;
                                });
                              })),
                      ListTile(
                          title: Text('Espera en medios'),
                          subtitle: CustomDropdownd(
                              width: size.width * 0.9,
                              height: 50,
                              items: _esperaMediosItems,
                              value: _esperaMedios,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _esperaMedios = value;
                                });
                              })),
                      ListTile(
                          title: Text('Ordenar'),
                          subtitle: CustomSort(
                              width: size.width * 0.9,
                              height: 50,
                              text: 'Id de reporte',
                              value: _sortIdFriend,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _sortIdFriend = value;
                                });
                              })),
                      ListTile(
                          subtitle: CustomSort(
                              width: size.width * 0.9,
                              height: 50,
                              text: 'Fecha',
                              value: _sortLocation,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _sortLocation = value;
                                });
                              })),
                      ListTile(
                          subtitle: CustomSort(
                              width: size.width * 0.9,
                              height: 50,
                              text: 'Calificación',
                              value: _sortUsername,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _sortUsername = value;
                                });
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
                        //aplicar filtros
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: const Text(
                            'PALICAR FILTROS',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            refreshing();
                          },
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }

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
      setState(() {
        _isLoading = !_isLoading;
        fetchData();
      });
  }

  fetchData() async {
    loadFriend(qtty, (page * qtty)).then((elements) {
      if (mounted)
        setState(() {
          if (page == 0) {
            _allFriend.clear();
          }

          setState(() {
            _allFriend.addAll(elements);
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
    _friendQtty = 0;
    _userQtty = 0;
    _allFriend.clear();
    setState(() {});
    startLoader();
  }

  String prepareFilters() {
    List<String> filters = List<String>();
    // if(_title.isNotEmpty) filters.add('filtros[titulo]='+_title);
    // if(_comment.isNotEmpty) filters.add('filtros[comentario]='+_comment);
    // if(_calidadNieve.isNotEmpty) filters.add('filtros[calidad_nieve]='+_calidadNieve);
    // if(_clima.isNotEmpty) filters.add('filtros[clima]='+_clima);
    // if(_viento.isNotEmpty) filters.add('filtros[viento]='+_viento);
    // if(_esperaMedios.isNotEmpty) filters.add('filtros[espera_medios]='+_esperaMedios);

    filters.add(_sortIdFriend ? 'ordenes[id]=ASC' : 'ordenes[id]=DESC');
    filters.add(
        _sortLocation ? 'ordenes[localidad]=ASC' : 'ordenes[localidad]=DESC');
    filters.add(
        _sortUsername ? 'ordenes[username]=ASC' : 'ordenes[username]=DESC');

    return filters.join('&');
  }

  Future<List<User>> loadFriend(int limit, int offset) async {
    List<User> elements = new List<User>();

    await SnowinProvider()
        .nearestUsers(limit.toString(), offset.toString(), prepareFilters())
        .then((response) {
      print('notificaciones/listar response: ');
      print(response);
      if (response['ok']) {
        var data = response['data'];
        _friendQtty += int.parse(data['cantidadAmigos'].toString());
        _userQtty += int.parse(data['cantidadUsuarios'].toString());

        final _castDataType = data['dat'].cast<Map<String, dynamic>>();
        elements = _castDataType.map<User>((json) => User.map(json)).toList();
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });

    return elements;
  }

  Future<void> loadTraks() async {
    setState(() {});

    _trackItems = new List<ItemKV>();
    _trackItems.add(ItemKV('', ''));

    if (_session.center != null) {
      _session.center.pistas.forEach((pista) {
        _trackItems.add(new ItemKV(pista.id, pista.descripcion));
        if (_trackItems.length == 1) _track = pista.id.toString();
      });
    }
  }

  Future<void> loadEmuns() async {
    setState(() {});

    await SnowinProvider().loadEmuns().then((response) {
      print('enums response: ');
      print(response);
      if (response['ok']) {
        var data = response['data'];

        //cargar combo calidad_nieve
        if (data.containsKey('calidad_nieve')) {
          _calidadNieveItems = new List<ItemKV>();
          _calidadNieveItems.add(ItemKV('', ''));
          data['calidad_nieve'].forEach((k, v) {
            _calidadNieveItems.add(new ItemKV(k, v));
            if (_calidadNieveItems.length == 1) _calidadNieve = k.toString();
          });
        }

        //cargar combo clima
        if (data.containsKey('clima')) {
          _climaItems = new List<ItemKV>();
          _climaItems.add(ItemKV('', ''));
          data['clima'].forEach((k, v) {
            _climaItems.add(new ItemKV(k, v));
            if (_climaItems.length == 1) _clima = k.toString();
          });
        }

        //cargar combo viento
        if (data.containsKey('viento')) {
          _vientoItems = new List<ItemKV>();
          _vientoItems.add(ItemKV('', ''));
          data['viento'].forEach((k, v) {
            _vientoItems.add(new ItemKV(k, v));
            if (_vientoItems.length == 1) _viento = k.toString();
          });
        }

        //cargar combo sensacion_general
        if (data.containsKey('sensacion_general')) {
          _sensacionGeneralItems = new List<ItemKV>();
          _sensacionGeneralItems.add(ItemKV('', ''));
          data['sensacion_general'].forEach((k, v) {
            _sensacionGeneralItems.add(new ItemKV(k, v));
            if (_sensacionGeneralItems.length == 1)
              _sensacionGeneral = k.toString();
          });
        }

        //cargar combo espera_medios
        if (data.containsKey('espera_medios')) {
          _esperaMediosItems = new List<ItemKV>();
          _esperaMediosItems.add(ItemKV('', ''));
          data['espera_medios'].forEach((k, v) {
            _esperaMediosItems.add(new ItemKV(k, v));
            if (_esperaMediosItems.length == 1) _esperaMedios = k.toString();
          });
        }
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
