import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/message.dart';
import 'package:snowin/src/repository/chat_repository.dart';

class ChatProvider with ChangeNotifier {
  //Get all users----------------
  List<Message> _messageList = [];

  UnmodifiableListView<Message> get messageList =>
      UnmodifiableListView(_messageList);

  set messageList(List<Message> list) {
    _messageList = list;
    notifyListeners();
  }

  ChatProvider.init() {
    getMessages();
  }

  void getMessages() {
    ChatRepository().getAllMessages('10', '0').then((response) {
      print(response);
      if (response['ok']) {
        compute(messageFromJson, response['data']['data']).then((value) {
          // _users = UsersNear.fromJson(response['data'], value);
          notifyListeners();
        });
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
