import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cartModel.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<CartModel> cartItemsList = [];
  CartModel? cartListModel;
  List<CartModel> get cartItems => cartItemsList;
  StreamSubscription<QuerySnapshot>? _subscription;

  void addToCart(
      {String? itemName,
      double? itemPrice,
      String? shopId,
      String? itemId}) async {
    cartListModel = CartModel(
        itemName: itemName, price: itemPrice, shopId: shopId, itemId: itemId);
    cartItemsList.add(cartListModel!);

    for (var e in cartItemsList) {
      print(e.shopId);
      print(e.price);
      print(e.itemName);
    }
    print(cartItemsList.length);
    final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser)
        .collection('Cart')
        .doc('$itemId')
        .set({
      'itemName': itemName,
      'itemPrice': itemPrice,
      'shopId': shopId,
      'itemId': itemId,
      'itemQuantity': 1,
      'itemTotalPrice': itemPrice,
    });

    notifyListeners();
  }

  fatchCartData() async {
    final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;

    _subscription = await FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser)
        .collection('Cart')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<CartModel> newList = [];
      for (var e in snapshot.docs) {
        cartListModel = CartModel(
            itemId: e.get('itemId'),
            itemName: e.get('itemName'),
            shopId: e.get('shopId'),
            price: e.get('itemPrice'),
            itemQuantity: e.get('itemQuantity'),
            itemTotalPrice: e.get('itemTotalPrice'));
        newList.add(cartListModel!);
      }

      cartItemsList = newList;
      notifyListeners();
    });
  }

  List<CartModel> get getCartItemList {
    return cartItemsList;
  }

  void updateCart(
      {String? itemId, int? itemQuantity, double? itemTotalPrice}) async {
    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser)
        .collection('Cart')
        .doc('$itemId')
        .update({
      'itemTotalPrice': itemTotalPrice,
      'itemQuantity': itemQuantity,
    });
  }

  //cart total

  double getCartTotal() {
    double total = 0.0;
    cartItemsList.forEach((e) {
      total += e.itemTotalPrice!;
    });
    // notifyListeners();
    return total;
  }

  void removeToCart(String? itemId) async {
    cartItemsList.removeWhere((e) => e.itemId == itemId);
    // for (var e in cartItemsList) {
    //   print(e.shopId);
    //   print(e.price);
    //   print(e.itemName);
    // }
    // print(cartItemsList.length);

    final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;

    FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser)
        .collection('Cart')
        .doc('$itemId')
        .delete();

    // print(_cartItems);
    notifyListeners();
  }

  //sending user order to pending order collection
  // void sendDataToShop() async {
  //   WriteBatch batch = firestore.batch();
  //
  //   // Get the current timestamp in DateTime format
  //   DateTime currentDateTime = DateTime.now();
  //
  //   // Format the date and time as strings in the desired format
  //   String formattedDate = DateFormat("dd/MM/yyyy").format(currentDateTime);
  //   String formattedTime = DateFormat("HH:mm:ss").format(currentDateTime);
  //
  //   final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;
  //
  //   String? shopId = cartItemsList[0].shopId;
  //   //data added to shop
  //
  //   String? userName;
  //   String? phoneNumber;
  //   String? imageLink;
  //
  //   print(firebaseUser);
  //
  //   if (firebaseUser != null) {
  //     await FirebaseFirestore.instance
  //         .collection('User Data')
  //         .doc(firebaseUser)
  //         .get()
  //         .then((ds) {
  //       userName = ds.get('UserName');
  //       imageLink = ds.get('ImageUrl');
  //       phoneNumber = ds.get('PhoneNumber');
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   }
  //
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('ShopData')
  //         .doc(shopId)
  //         .collection('User Order')
  //         .doc(firebaseUser)
  //         .set({
  //       'UserName': userName,
  //       'PhoneNumber': phoneNumber,
  //       'ImageUrl': imageLink,
  //     });
  //     print('data uploded ==========================fefbjhfhekf');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   //save date and time in order feild
  //   // Map<String, dynamic> orderData = {
  //   //   "date": DateFormat("dd/MM/yyyy")
  //   //       .format(DateTime.now()), // Format date as "dd/MM/yyyy"
  //   //   "time": DateFormat("HH:mm:ss")
  //   //       .format(DateTime.now()), // Format time as "HH:mm:ss"
  //   // };
  //
  //   DocumentReference OrderRef = firestore
  //       .collection('ShopData')
  //       .doc(shopId)
  //       .collection('User Order')
  //       .doc(firebaseUser)
  //       .collection('Order')
  //       .doc();
  //
  //   batch.set(OrderRef, {
  //     'date': formattedDate,
  //     'time': formattedTime,
  //     // Add other order-related fields here if needed
  //   });
  //
  //   CollectionReference orderDetailsRef = OrderRef.collection('Order Details');
  //
  //   cartItemsList.forEach((e) {
  //     batch.set(orderDetailsRef.doc(), {
  //       'itemName': e.itemName,
  //       'itemPrice': e.price,
  //       'itemId': e.itemId,
  //       'itemQuantity': e.itemQuantity,
  //     });
  //   });
  //
  //   // Commit the batch operation
  //   await batch.commit();
  //
  //   deleteCartCollection();
  // }

  void addOrderToPendingOrders() async {
    // Get the current timestamp in DateTime format
    DateTime currentDateTime = DateTime.now();

    // Format the date and time as strings in the desired format
    String formattedDate = DateFormat("dd/MM/yyyy").format(currentDateTime);
    String formattedTime = DateFormat("HH:mm:ss").format(currentDateTime);

    // Create a new document in the PendingOrders collection with an auto-generated ID
    DocumentReference orderDocRef =
        FirebaseFirestore.instance.collection('PendingOrders').doc();

    final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;
    String? shopId = cartItemsList[0].shopId;
    double totalAmount = getCartTotal();
    // Add the order data to the document
    await orderDocRef.set({
      'shopId': shopId,
      'userId': firebaseUser,
      'orderStatus': 'pending',
      'orderDate': formattedDate,
      'orderTime': formattedTime,
      'totalAmount': totalAmount,
    });

    // Add the order items to the sub-collection OrderItems
    CollectionReference orderItemsRef = orderDocRef.collection('OrderItems');
    cartItemsList.forEach((cartItem) {
      orderItemsRef.add({
        'itemName': cartItem.itemName,
        'itemPrice': cartItem.price,
        'itemId': cartItem.itemId,
        'itemQuantity': cartItem.itemQuantity,
      });
    });
    deleteCartCollection();
  }

  //delete cart and add to pendding orders
  void deleteCartCollection() async {
    final firebaseUser = await (FirebaseAuth.instance.currentUser!).uid;
    cartItemsList.clear();
    final collectionRef = FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser)
        .collection('Cart');

    final QuerySnapshot querySnapshot = await collectionRef.get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot doc in documents) {
      await doc.reference.delete();
    }

    print('Cart collection has been deleted successfully.');
  }

  void decrementItem(String itemId) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final cartItem = cartItemsList.firstWhere((item) => item.itemId == itemId);

    if (cartItem.itemQuantity > 1) {
      cartItem.itemQuantity -= 1;
      cartItem.itemTotalPrice = cartItem.price! * cartItem.itemQuantity!;
      notifyListeners();

      await FirebaseFirestore.instance
          .collection('User Data')
          .doc(firebaseUser!.uid)
          .collection('Cart')
          .doc(itemId)
          .update({
        'itemQuantity': cartItem.itemQuantity,
        'itemTotalPrice': cartItem.itemTotalPrice,
      });
    }
  }

  void incrementItem(String itemId) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final cartItem = cartItemsList.firstWhere((item) => item.itemId == itemId);

    cartItem.itemQuantity += 1;
    cartItem.itemTotalPrice = (cartItem.price! * cartItem.itemQuantity!);
    notifyListeners();

    await FirebaseFirestore.instance
        .collection('User Data')
        .doc(firebaseUser!.uid)
        .collection('Cart')
        .doc(itemId)
        .update({
      'itemQuantity': cartItem.itemQuantity,
      'itemTotalPrice': cartItem.itemTotalPrice,
    });
  }

  void clearCart() {
    cartItemsList.clear();
    notifyListeners();
  }
}
