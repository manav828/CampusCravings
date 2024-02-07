import 'dart:async';

import 'package:charueats_delivery/BottomNavigation/Home/mainItemScreen/getShopItems/shopMainItemsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ShopItemsProvaider with ChangeNotifier {
  late ShopItemsModel shopItemsModel;
  List<ShopItemsModel> shopMainItemList = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  fatchMainItems(String shopId) async {
    List<ShopItemsModel> newList = [];
    final QuerySnapshot Items = await FirebaseFirestore.instance
        .collection('ShopData')
        .doc(shopId)
        .collection('Shop Items')
        .get();
    print(Items.docs);
    for (var e in Items.docs) {
      shopItemsModel = ShopItemsModel(
        mainImageUrl: e.get('ImageUrl'),
        mainItemName: e.get('ItemName'),
        mainItemId: e.id,
      );
      newList.add(shopItemsModel);
    }
    shopMainItemList = newList;
    notifyListeners();
  }

  List<ShopItemsModel> get getShopItemsList {
    print(shopMainItemList);
    return shopMainItemList;
  }

  void listenToShopMainDetails(String shopId) async {
    _subscription = FirebaseFirestore.instance
        .collection('ShopData')
        .doc(shopId)
        .collection('Shop Items')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<ShopItemsModel> newList = [];

      for (var e in snapshot.docs) {
        shopItemsModel = ShopItemsModel(
          mainItemId: e.id,
          mainImageUrl: e.get('ImageUrl'),
          mainItemName: e.get('ItemName'),
        );
        newList.add(shopItemsModel);
      }
      shopMainItemList = newList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
