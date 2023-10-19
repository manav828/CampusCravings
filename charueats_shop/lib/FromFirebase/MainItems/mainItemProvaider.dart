import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'mainItemsModel.dart';

class MainItemProvaider with ChangeNotifier {
  List<ShopMainItemsModel> mainItems = [];
  late ShopMainItemsModel shopMainItemsModel;

  Future<bool> sendItemData(String ItemName, String imageUrl) async {
    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;
    try {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser)
          .collection('Shop Items')
          .doc()
          .set({
        'ItemName': ItemName,
        'ImageUrl': imageUrl,
      });
      notifyListeners();

      print('data uploded ==========================fefbjhfhekf');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //fatching data from firebase
  fatchMainItems() async {
    List<ShopMainItemsModel> newMainItems = [];

    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    final QuerySnapshot Items = await FirebaseFirestore.instance
        .collection('ShopData')
        .doc(firebaseUser)
        .collection('Shop Items')
        .get();

    for (var e in Items.docs) {
      shopMainItemsModel = ShopMainItemsModel(
        itemName: e.get('ItemName'),
        imageUrl: e.get('ImageUrl'),
        itemId: e.id,
      );
      newMainItems.add(shopMainItemsModel);
    }
    mainItems = newMainItems;
    notifyListeners();
  }

  List<ShopMainItemsModel> get getMainItemsList {
    return mainItems;
  }

  //delete data on firebase
  Future<void> deleteMainItem(String itemId) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser.uid)
          .collection('Shop Items')
          .doc(itemId)
          .delete();
      mainItems.removeWhere((item) => item.itemId == itemId);
      notifyListeners();
    }
  }
}
