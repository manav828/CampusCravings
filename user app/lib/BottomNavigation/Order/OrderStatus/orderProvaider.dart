import 'dart:async';
// import 'dart:js';

import 'package:charueats_delivery/BottomNavigation/Cart/cartList/cartProvaider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Cart/cartList/cartModel.dart';
import 'orderModel.dart';

class OrderProvaider with ChangeNotifier {
  // CartProvider? cartProvider;
  // List<CartModel> cartList = cartProvider!.cartItemsList;
  List<OrderItem> orderItemsList = [];
  List<PendingOrder> pendingOrderList = [];
  StreamSubscription<QuerySnapshot>? _pendingOrders;

  fatchPanddingOrderData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    List<PendingOrder> pendingOrdersList = [];

    if (firebaseUser == null) return pendingOrdersList;

    _pendingOrders = await FirebaseFirestore.instance
        .collection('PendingOrders')
        .where('userId', isEqualTo: firebaseUser.uid)
        .snapshots()
        .listen((querySnapshot) async {
      List<PendingOrder> pendingOrdersList = [];

      for (var doc in querySnapshot.docs) {
        print(doc.get('orderTime'));
        String orderId = doc.id;
        String shopId = doc.get('shopId');
        String orderStatus = doc.get('orderStatus');
        String orderDate = doc.get('orderDate');
        String orderTime = doc.get('orderTime');
        double totalAmount = doc.get('totalAmount');

        // Fetch shop data using the shopId
        DocumentSnapshot shopDoc = await FirebaseFirestore.instance
            .collection('ShopData')
            .doc(shopId)
            .get();
        String shopName = shopDoc.get('ShopName');
        String shopOwnerName = shopDoc.get('OwnerName');

        PendingOrder pendingOrder = PendingOrder(
          orderId: orderId,
          userId: firebaseUser.uid,
          shopId: shopId,
          orderStatus: orderStatus,
          orderDate: orderDate,
          orderTime: orderTime,
          totalAmount: totalAmount,
          shopName: shopName,
          shopOwnerName: shopOwnerName,
        );

        pendingOrdersList.add(pendingOrder);
      }

      notifyListeners();
      pendingOrderList = pendingOrdersList;
      // return pendingOrdersList;
    });
  }

  List<PendingOrder> get getpendingOrdersList {
    return pendingOrderList;
  }

  StreamSubscription<QuerySnapshot>? _orderItemsSubscription;

  List<OrderItem> orderItemMainList = [];

  Future<List<OrderItem>> fetchOrderItemsForPendingOrder(String orderId) async {
    CollectionReference orderItemsRef = FirebaseFirestore.instance
        .collection('PendingOrders')
        .doc(orderId)
        .collection('OrderItems');

    QuerySnapshot querySnapshot = await orderItemsRef.get();

    orderItemsList = querySnapshot.docs.map((doc) {
      // print(doc.get('itemName'));

      return OrderItem(
        itemName: doc.get('itemName'),
        itemPrice: doc.get('itemPrice'),
        itemId: doc.get('itemId'),
        itemQuantity: doc.get('itemQuantity'),
      );
    }).toList();

    // notifyListeners(); // Notify listeners about the data change
    orderItemMainList = orderItemsList;
    return orderItemsList;
  }

  List<OrderItem> get getorderItemMainList {
    return orderItemMainList;
  }

  // void dispose() {
  //   // Cancel the stream subscription when the widget is disposed
  //   _orderItemsSubscription?.cancel();
  //   super.dispose();
  // }
}
