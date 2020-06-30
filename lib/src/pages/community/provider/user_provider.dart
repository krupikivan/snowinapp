import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/user.dart';

class UserProvider with ChangeNotifier {
  //Get all users----------------
  List<User> _userList = [];

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  set userList(List<User> userList) {
    _userList = userList;
    notifyListeners();
  }

  //Get current user----------------
  User _currentUser;

  User get currentUser => _currentUser;

  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

//Initialize user provider-------------------
  UserProvider.init() {
    getUsers();
  }

  void getUsers() {
    final List<User> _list = [];
    final userData = {
      'id': 0,
      'username': "Carlos98",
      "email": "carlitos@gmail.com",
      "status": "Conectado",
      "nombre": "Carlos",
      "profile":
          "https://www.shareicon.net/data/2016/05/24/770114_people_512x512.png",
      "image": "https://www.w3schools.com/w3css/img_avatar2.png",
    };

    User user1 = User.map(userData);

    _list.add(user1);
    _userList = _list;
    _currentUser = user1;
    notifyListeners();
  }

  //Get all users----------------
  User _userTapped;

  User get userTapped => _userTapped;

  set userTapped(User userTapped) {
    _userTapped = userTapped;
    notifyListeners();
  }
}
