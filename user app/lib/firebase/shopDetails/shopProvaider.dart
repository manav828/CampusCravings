// import 'package:charueats_delivery/firebase/shopDetails/shopModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// class ShopProvaider with ChangeNotifier {
//   List<ShopModel> shopList = [];
//   late ShopModel shopModel;
//
//   fatchShopDeatils() async {
//     print('Fatching Start');
//     List<ShopModel> newList = [];
//
//     final QuerySnapshot Items =
//         await FirebaseFirestore.instance.collection('ShopData').get();
//     print(Items.docs);
//
//     for (var e in Items.docs) {
//       shopModel = ShopModel(
//           itemId: e.id,
//           imageUrl: e.get('ImageUrl'),
//           shopName: e.get('ShopName'));
//       newList.add(shopModel);
//     }
//     shopList = newList;
//     // return shopList;
//     notifyListeners();
//   }
//
//   List<ShopModel> get getShopDetails {
//     print(shopList);
//     print('nekwjfbewkjfbewkjdbn d  nd ======= === == = == = == = = =');
//     return shopList;
//   }
// }

import 'dart:async';

import 'package:charueats_delivery/firebase/shopDetails/shopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ShopProvaider with ChangeNotifier {
  List<ShopModel> shopList = [];
  late ShopModel shopModel;

  StreamSubscription<QuerySnapshot>? _subscription;

  void fatchShopDeatils() async {
    print('Fetching Start');
    List<ShopModel> newList = [];

    final QuerySnapshot Items =
        await FirebaseFirestore.instance.collection('ShopData').get();
    print(Items.docs);

    for (var e in Items.docs) {
      shopModel = ShopModel(
          itemId: e.id,
          imageUrl: e.get('ImageUrl'),
          shopName: e.get('ShopName'));
      newList.add(shopModel);
    }
    shopList = newList;
    notifyListeners();
  }

  List<ShopModel> get getShopDetails {
    print(shopList);
    return shopList;
  }

  void listenToShopDetails() async {
    _subscription = FirebaseFirestore.instance
        .collection('ShopData')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<ShopModel> newList = [];

      for (var e in snapshot.docs) {
        shopModel = ShopModel(
          itemId: e.id,
          imageUrl: e.get('ImageUrl'),
          shopName: e.get('ShopName'),
        );
        newList.add(shopModel);
      }
      shopList = newList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
