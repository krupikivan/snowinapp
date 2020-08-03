import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/repository/snowin_repository.dart';
import 'package:snowin/src/share/preference.dart';

class PushNotificationsProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  StreamController<Map<String, dynamic>> _mensajesStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get mensajes => _mensajesStreamController.stream;
  final Completer<Map<String, dynamic>> completer =
      Completer<Map<String, dynamic>>();
  final _prefs = new Preferences();
  SnowinRepository snowinprovider = SnowinRepository();

  static final PushNotificationsProvider _instancia =
      new PushNotificationsProvider._internal();

  factory PushNotificationsProvider() {
    return _instancia;
  }

  PushNotificationsProvider._internal();

  initNotifications() async {
    _firebaseMessaging.requestNotificationPermissions();
    //f65vApD6r-g:APA91bHlBifup5z78Al-VHXErS51DaSAs3neSGY_MR3yUa8TH9bL5cr3fvC3nk7asZImYZljNTFU9pBKvMtqf8uokCDEhhIe9B8OUu1hrY5OzmsepjjOSZhMl-Oc9fRNfzyUFbkeVR8S
    //muvinapp einaXf0OMyY:APA91bEC5V3cbMEuPAbHudttzlvn7CFnZFH19HBffGqksc99WDtebfTIr2d0nGXNj1eUA5IMtVNupckFv40Sjt4_U1NuvP1iXFnTGT6-PnqWAnOCK_Drvu5J-IF8wHAYAtGKdvWOqWnC
    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
      _prefs.tokenNotificacion = token;
    });

    _firebaseMessaging.configure(onMessage: (info) {
      print('======= On Message ========');
      print(info);
      String cadena = json.encode(info);
      Map<String, dynamic> argumento = json.decode(cadena);
      _mensajesStreamController.sink.add(argumento['data']);
    }, onLaunch: (info) {
      print('======= On Launch ========');
      print(info);
      String cadena = json.encode(info);
      Map<String, dynamic> argumento = json.decode(cadena);
      _mensajesStreamController.sink.add(argumento['data']);
    }, onResume: (info) {
      print('======= On Resume ========');
      print(info);
      String cadena = json.encode(info);
      Map<String, dynamic> argumento = json.decode(cadena);
      _mensajesStreamController.sink.add(argumento['data']);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    final resp = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Config.serverToken}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'comida': 'Comida desde flutter',
          },
          'to': _prefs.tokenNotificacion,
        },
      ),
    );

    /* _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    ); */

    return completer.future;
  }
}
