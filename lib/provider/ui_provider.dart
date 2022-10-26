import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  var _pageIndex = 0;

  set pageIndex(int index) {
    _pageIndex = index;

    notifyListeners();
  }

  int get pageIndex => _pageIndex;
}
