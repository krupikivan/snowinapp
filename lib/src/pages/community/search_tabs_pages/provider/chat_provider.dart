import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/message.dart';
import 'package:snowin/src/repository/chat_repository.dart';

class ChatProvider with ChangeNotifier {
  //Get all users----------------
  List<Message> _messageList = [];

  List<Message> get messageList => _messageList;

  set messageList(List<Message> list) {
    _messageList = list;
    notifyListeners();
  }

  int _total;
  ChatProvider.init() {
    _loading = false;
    _total = 0;
  }

  var _conversacion;
  get conversacion => _conversacion;
  set conversacion(var id) {
    _conversacion = id;
    notifyListeners();
  }

  bool _loading;
  get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _userId;
  int get userId => _userId;
  set userId(int id) {
    _userId = id;
    notifyListeners();
  }

  Future getConversacion(int id) async {
    try {
      _total = 0;
      _messageList.clear();
      _loading = true;
      notifyListeners();
      _conversacion = null;
      var response = await ChatRepository().getConversacion(id);
      if (response['ok']) {
        _conversacion = response['data']['data'][0]['id'];
      } else {
        throw new Exception('Error trayendo la conversacion');
      }
    } catch (e) {}
  }

  Future getMensajes() async {
    try {
      List list = [];
      //Obtuve el id de la conversacion ahora busco los mensajes
      var mensajes = await ChatRepository().getAllMessages(_conversacion);
      if (mensajes['ok']) {
        list = mensajes['data']['data'];
        if (_total == 0 || _total != mensajes['data']['total']) {
          _total = mensajes['data']['total'];
          compute(messageFromJson, list).then((value) {
            _messageList = value;
            messageList
                .sort((a, b) => DateTime.parse(b.fecha).millisecondsSinceEpoch);
            _loading = false;
            notifyListeners();
          });
        }
      } else {
        _loading = false;
        notifyListeners();
        throw new Exception('Error trayendo los mensajes');
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> sendMessage(String text, int id) async {
    try {
      var response = await ChatRepository().sendMessage(text, id);
      if (response['ok']) {
        await getMensajes();
        return true;
      } else {
        throw new Exception('No hay conexion');
      }
    } catch (e) {
      throw 'Error';
    }
  }

  Future<bool> delete(int id) async {
    try {
      var response = await ChatRepository().delete(id);
      if (response['ok']) {
        await getMensajes();
        return true;
      } else {
        throw new Exception('Error eliminando mensaje');
      }
    } catch (e) {
      throw 'Error';
    }
  }
}
