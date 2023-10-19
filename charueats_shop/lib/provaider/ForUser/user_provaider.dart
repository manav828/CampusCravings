import 'dart:io';

import 'package:flutter/cupertino.dart';

class UserProvaider with ChangeNotifier {
  String? _ShopName;
  String? _OwnerName;
  String? _Phone;
  String? _ShopImg;
  String? _ShopImgUrl;

  String? get getShopName => _ShopName;
  String? get getOwnerName => _OwnerName;
  String? get getPhone => _Phone;
  String? get getImage => _ShopImg;
  String? get getImageUrl => _ShopImgUrl;
  void putData(String ShopName, String OwnerName, var Phone, String ShopImg) {
    _OwnerName = OwnerName;
    _ShopName = ShopName;
    _Phone = Phone;
    _ShopImg = ShopImg;
    notifyListeners();
  }

  void imageUrl(String imageUrl) {
    _ShopImgUrl = imageUrl;
    notifyListeners();
  }
}
