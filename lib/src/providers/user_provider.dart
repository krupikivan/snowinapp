import 'package:flutter/cupertino.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class UserProvider with ChangeNotifier {
//Manage User Data------------------------------
  User _user;
  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  UserProvider.init() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await SnowinRepository().getUserLoginData().then((response) {
      print('User data response');
      print(response);
      if (response['ok']) {
        var data = response['data'];
        _user = User.map(data);
        notifyListeners();
      } else {
        throw Exception('Error');
      }
    });
  }
}
