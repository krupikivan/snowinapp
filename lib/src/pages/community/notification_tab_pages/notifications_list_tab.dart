import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/notif_fab.dart';
import 'package:snowin/src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'list_notification_tiles.dart';

class NotificationsListTab extends StatefulWidget {
  NotificationsListTab({Key key}) : super(key: key);

  @override
  NotificationsListTabState createState() => new NotificationsListTabState();
}

class NotificationsListTabState extends State<NotificationsListTab> {
  double deviceHeight = 0;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(scrollListener);
    Provider.of<NotificationProvider>(context, listen: false).startLoader();
  }

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notif = Provider.of<NotificationProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: new RefreshIndicator(
        key: refreshkey,
        child: new Scrollbar(
          child: new Stack(
            children: <Widget>[
              ListNotificationTiles(
                controller: _scrollController,
              ),
              NotificationFab(controller: _scrollController),
            ],
          ),
        ),
        onRefresh: () async {
          refreshkey.currentState.show(atTop: true);
          notif.refreshing();
        },
      ),
    );
  }

  void scrollListener() {
    // if (_scrollController.position.pixels > deviceHeight) {
    //   if (!_showTopButon) {
    //     setState(() {
    //       _showTopButon = true;
    //     });
    //   }
    // } else {
    //   if (_showTopButon) {
    //     setState(() {
    //       _showTopButon = false;
    //     });
    //   }
    // }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    if (mounted)
      Provider.of<NotificationProvider>(context, listen: false).changeLoading();
    fetchData();
  }

  fetchData() async {
    final notif = Provider.of<NotificationProvider>(context, listen: false);
    await notif.getNotifications();
    if (mounted) {
      if (notif.page == 0) {}
      notif.changeLoading();
      notif.pageSum();
    }
    // loadNotifications(qtty, (page * qtty)).then((elements) {
    //   if (mounted)
    //     setState(() {
    //       if (page == 0) {
    //         _allNotifications.clear();
    //       }

    //       setState(() {
    //         _allNotifications.addAll(elements);
    //         _isLoading = !_isLoading;
    //         page++;
    //       });
    //     });
    // }).whenComplete(() {
    //   print('done');
    // });
  }
  // Future<Null> refreshing() async {
  //   print(" refreshing ... ");
  //   page = 0;
  //   _allNotifications.clear();
  //   setState(() {});
  //   startLoader();
  // }

  // Future<void> loadTraks() async {
  //   setState(() {});

  //   _trackItems = new List<ItemKV>();
  //   _trackItems.add(ItemKV('', ''));

  //   if (user.center != null) {
  //     user.center.pistas.forEach((pista) {
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
  //         _calidadNieveItems.add(ItemKV('', ''));
  //         data['calidad_nieve'].forEach((k, v) {
  //           _calidadNieveItems.add(new ItemKV(k, v));
  //           if (_calidadNieveItems.length == 1) _calidadNieve = k.toString();
  //         });
  //       }

  //       //cargar combo clima
  //       if (data.containsKey('clima')) {
  //         _climaItems = new List<ItemKV>();
  //         _climaItems.add(ItemKV('', ''));
  //         data['clima'].forEach((k, v) {
  //           _climaItems.add(new ItemKV(k, v));
  //           if (_climaItems.length == 1) _clima = k.toString();
  //         });
  //       }

  //       //cargar combo viento
  //       if (data.containsKey('viento')) {
  //         _vientoItems = new List<ItemKV>();
  //         _vientoItems.add(ItemKV('', ''));
  //         data['viento'].forEach((k, v) {
  //           _vientoItems.add(new ItemKV(k, v));
  //           if (_vientoItems.length == 1) _viento = k.toString();
  //         });
  //       }

  //       //cargar combo sensacion_general
  //       if (data.containsKey('sensacion_general')) {
  //         _sensacionGeneralItems = new List<ItemKV>();
  //         _sensacionGeneralItems.add(ItemKV('', ''));
  //         data['sensacion_general'].forEach((k, v) {
  //           _sensacionGeneralItems.add(new ItemKV(k, v));
  //           if (_sensacionGeneralItems.length == 1)
  //             _sensacionGeneral = k.toString();
  //         });
  //       }

  //       //cargar combo espera_medios
  //       if (data.containsKey('espera_medios')) {
  //         _esperaMediosItems = new List<ItemKV>();
  //         _esperaMediosItems.add(ItemKV('', ''));
  //         data['espera_medios'].forEach((k, v) {
  //           _esperaMediosItems.add(new ItemKV(k, v));
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
}
