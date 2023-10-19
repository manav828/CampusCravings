import 'dart:io';

import 'package:flutter/cupertino.dart';

class FavoriteProvaider with ChangeNotifier {
  bool _fillColour = false;

  bool get getColour => _fillColour;
  void putData(bool colour) {
    _fillColour = colour;
    notifyListeners();
  }
}
