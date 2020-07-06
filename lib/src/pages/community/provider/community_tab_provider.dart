import 'package:flutter/cupertino.dart';

class CommunityTabsProvider with ChangeNotifier {
  //Manage tabs from Search friends page
  int _currentIndex;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  //Manage tabs from communitye
  bool _inSecondTab;
  bool get inSecondTab => _inSecondTab;
  set inSecondTab(bool tab) {
    _inSecondTab = tab;
  }

  // void setIndex() {
  //   _currentIndex = 0;
  // }
  CommunityTabsProvider();

  CommunityTabsProvider.init() {
    _currentIndex = 0;
    _inSecondTab = false;
  }
}
