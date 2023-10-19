import 'dart:async';

import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/mainItemScreen/subItemsScreen/getShopSubItems/shopSubItemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ShopSubItemProvaider with ChangeNotifier {
  ShopSubItemModel? shopSubItemModel;
  List<ShopSubItemModel> subItemList = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  List<ShopSubItemModel> get subShopItemsList {
    return subItemList;
  }

  void listenToShopSubItem(
      {required String shopId, required String mainItemId}) async {
    _subscription = FirebaseFirestore.instance
        .collection('ShopData')
        .doc(shopId)
        .collection('Shop Items')
        .doc(mainItemId)
        .collection('Sub Items')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<ShopSubItemModel> newList = [];

      for (var e in snapshot.docs) {
        shopSubItemModel = ShopSubItemModel(
          shopSubItemId: e.id,
          shopSubItemName: e.get('SubItemName'),
          shopSubItemPrice: e.get('SubItemPrice'),
        );
        newList.add(shopSubItemModel!);
      }
      subItemList = newList;
      notifyListeners();
    });
  }
}
