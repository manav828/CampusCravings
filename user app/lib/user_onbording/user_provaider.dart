import 'dart:io';

import 'package:flutter/cupertino.dart';

class UserProvaider with ChangeNotifier {
  String? _UserName;
  String? _Phone;
  String? _UserImg;
  String? _UserImgUrl;

  String? get getUserName => _UserName;
  String? get getPhone => _Phone;
  String? get getImage => _UserImg;

  String? get getUserImage => _UserImgUrl;

  void putData(String UserName, var Phone, String UserImg) {
    _UserName = UserName;
    _Phone = Phone;
    _UserImg = UserImg;
    notifyListeners();
  }

  void imageUrl(String imageUrl) {
    _UserImgUrl = imageUrl;
    notifyListeners();
  }
}
