import 'package:charueats_shop/FromFirebase/SubItems/subItemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SubItemProvaider with ChangeNotifier {
  List<SubItemsModel> subItem = [];
  late SubItemsModel subItemsModel;
  final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;

  Future<bool> sendSubItem(
      String subItemName, String Id, double subItemPrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser)
          .collection('Shop Items')
          .doc(Id)
          .collection('Sub Items')
          .doc()
          .set({
        'SubItemName': subItemName,
        'SubItemPrice': subItemPrice,
      });
      notifyListeners();
      print('sub item uploaded');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  fatchSubItem(String Id) async {
    List<SubItemsModel> newSubItems = [];

    final QuerySnapshot Items = await FirebaseFirestore.instance
        .collection('ShopData')
        .doc(firebaseUser)
        .collection('Shop Items')
        .doc(Id)
        .collection('Sub Items')
        .get();

    for (var e in Items.docs) {
      subItemsModel = SubItemsModel(
          subItemName: e.get('SubItemName'),
          subItemPrice: e.get('SubItemPrice'),
          subItemId: e.id);
      newSubItems.add(subItemsModel);
    }
    subItem = newSubItems;
    print('all items fatched');

    notifyListeners();
  }

  List<SubItemsModel> get getSubItemsList {
    print('all item sended');
    return subItem;
  }

  Future<void> deleteSubItem(String mainitemId, String subItemId) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser.uid)
          .collection('Shop Items')
          .doc(mainitemId)
          .collection('Sub Items')
          .doc(subItemId)
          .delete();
      subItem.removeWhere((item) => item.subItemId == subItemId);
      notifyListeners();
    }
  }
}
