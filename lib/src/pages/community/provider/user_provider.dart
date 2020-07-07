import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/providers/snowin_provider.dart';
import 'package:snowin/src/models/users_near.dart';

class UserProvider with ChangeNotifier {
  //Get all users----------------
  List<User> _userList = [];

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  set userList(List<User> userList) {
    _userList = userList;
    notifyListeners();
  }

//Get all users near
  UsersNear _users;
  UsersNear get users => _users;

  set users(UsersNear user) {
    _users = user;
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
    SnowinProvider().getAllUsers().then((response) {
      print(response);
      if (response['ok']) {
        compute(usersFromJson, response['data']['usuarios']).then((value) {
          _users = UsersNear.fromJson(response['data'], value);
          notifyListeners();
        });
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  //Get all users----------------
  User _userTapped;

  User get userTapped => _userTapped;

  set userTapped(User userTapped) {
    _userTapped = userTapped;
    notifyListeners();
  }
}
