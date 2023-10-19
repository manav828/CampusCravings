import 'dart:async';
// import 'dart:js';

// import 'package:charueats_delivery/BottomNavigation/Cart/cartList/cartProvaider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../Cart/cartList/cartModel.dart';
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
        .where('shopId', isEqualTo: firebaseUser.uid)
        .snapshots()
        .listen((querySnapshot) async {
      List<PendingOrder> pendingOrdersList = [];

      for (var doc in querySnapshot.docs) {
        // print(doc.get('orderTime'));
        String orderId = doc.id;
        String userId = doc.get('userId');
        String orderStatus = doc.get('orderStatus');
        String orderDate = doc.get('orderDate');
        String orderTime = doc.get('orderTime');
        double totalAmount = doc.get('totalAmount');

        // Fetch user data using the userid
        // DocumentSnapshot shopDoc = await FirebaseFirestore.instance
        //     .collection('User Data')
        //     .doc(userId)
        //     .get();
        // String userName = shopDoc.get('UserName');

        DocumentSnapshot shopDoc = await FirebaseFirestore.instance
            .collection('User Data')
            .doc(userId)
            .get();

        if (shopDoc.exists) {
          String? userName = shopDoc.get('UserName') as String?;
          String userToken = shopDoc.get('token');

          if (userName != null) {
            // Use the userName value here
            PendingOrder pendingOrder = PendingOrder(
              orderId: orderId,
              userId: userId,
              shopId: firebaseUser.uid,
              orderStatus: orderStatus,
              orderDate: orderDate,
              orderTime: orderTime,
              totalAmount: totalAmount,
              userName: userName.toString(),
              userToken: userToken,
            );

            pendingOrdersList.add(pendingOrder);
          } else {
            print('UserName field is null');
          }
        } else {
          print('Document does not exist');
        }
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
    return orderItemMainList;
  }

  List<OrderItem> get getorderItemMainList {
    return orderItemMainList;
  }

  // sendOrderStatus(String orderId, String s) {
  Future<void> sendOrderStatus(String orderId, String newOrderStatus) async {
    print(orderId);
    print(newOrderStatus);
    try {
      await FirebaseFirestore.instance
          .collection('PendingOrders')
          .doc(orderId)
          .update({
        'orderStatus': newOrderStatus,
      });
      notifyListeners();
    } catch (e) {
      print('Error updating orderStatus: $e');
    }
  }

  StreamSubscription<QuerySnapshot>? _subscriptionHistory;

  // Future<void> sendToConformHistory(
  //   String shopId,
  //   String userId,
  //   List<PendingOrder> pendingOrders,
  //   List<List<OrderItem>> orderItemsList,
  //     int index
  // ) async {
  //   try {
  //     CollectionReference userHistoryCollection = FirebaseFirestore.instance
  //         .collection('User Data')
  //         .doc(userId)
  //         .collection('History');
  //
  //     CollectionReference shopHistoryCollection = FirebaseFirestore.instance
  //         .collection('ShopData')
  //         .doc(shopId)
  //         .collection('Conform History');
  //
  //     for (int i = 0; i < pendingOrders.length; i++) {
  //       PendingOrder pendingOrder = pendingOrders[i];
  //       print(pendingOrders);
  //
  //       // Check if the order is accepted before proceeding
  //       if (pendingOrder.orderStatus != 'Accepted') {
  //         continue;
  //       }
  //       print('sending start');
  //
  //       DocumentReference userOrderDocRef =
  //           userHistoryCollection.doc(pendingOrder.orderId);
  //       DocumentReference shopOrderDocRef =
  //           shopHistoryCollection.doc(pendingOrder.orderId);
  //
  //       await userOrderDocRef.set({
  //         'userId': pendingOrder.userId,
  //         'shopId': shopId,
  //         'orderStatus': pendingOrder.orderStatus,
  //         'orderDate': pendingOrder.orderDate,
  //         'orderTime': pendingOrder.orderTime,
  //         'totalAmount': pendingOrder.totalAmount,
  //         'userName': pendingOrder.userName,
  //       });
  //
  //       await shopOrderDocRef.set({
  //         'userId': pendingOrder.userId,
  //         'shopId': shopId,
  //         'orderStatus': pendingOrder.orderStatus,
  //         'orderDate': pendingOrder.orderDate,
  //         'orderTime': pendingOrder.orderTime,
  //         'totalAmount': pendingOrder.totalAmount,
  //         'userName': pendingOrder.userName,
  //       });
  //       print('sended successfully');
  //
  //       List<OrderItem> orderItems = orderItemsList[i];
  //
  //       // Add order items to User Data history
  //       CollectionReference userOrderItemsCollectionRef =
  //           userOrderDocRef.collection('OrderItems');
  //       for (var orderItem in orderItems) {
  //         await userOrderItemsCollectionRef.add({
  //           'itemName': orderItem.itemName,
  //           'itemPrice': orderItem.itemPrice,
  //           'itemId': orderItem.itemId,
  //           'itemQuantity': orderItem.itemQuantity,
  //         });
  //       }
  //
  //       // Add order items to ShopData Conform History
  //       CollectionReference shopOrderItemsCollectionRef =
  //           shopOrderDocRef.collection('OrderItems');
  //       for (var orderItem in orderItems) {
  //         await shopOrderItemsCollectionRef.add({
  //           'itemName': orderItem.itemName,
  //           'itemPrice': orderItem.itemPrice,
  //           'itemId': orderItem.itemId,
  //           'itemQuantity': orderItem.itemQuantity,
  //         });
  //       }
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error updating orderStatus: $e');
  //   }
  // }

  // Future<void> sendToConformHistory(
  //     String shopId,
  //     String userId,
  //     List<PendingOrder> pendingOrders,
  //     List<List<OrderItem>> orderItemsList,
  //     String orderId,
  //     int index) async {
  //   try {
  //     CollectionReference userHistoryCollection = FirebaseFirestore.instance
  //         .collection('User Data')
  //         .doc(userId)
  //         .collection('History');
  //
  //     CollectionReference shopHistoryCollection = FirebaseFirestore.instance
  //         .collection('ShopData')
  //         .doc(shopId)
  //         .collection('Conform History');
  //
  //     PendingOrder pendingOrder = pendingOrders[index];
  //     // print(pendingOrders);
  //
  //     // Check if the order is accepted before proceeding
  //     // if (pendingOrder.orderStatus != 'Accepted') {
  //     //   continue;
  //     // }
  //     print('sending start');
  //
  //     DocumentReference userOrderDocRef =
  //         userHistoryCollection.doc(pendingOrder.orderId);
  //     DocumentReference shopOrderDocRef =
  //         shopHistoryCollection.doc(pendingOrder.orderId);
  //
  //     await userOrderDocRef.set({
  //       'userId': pendingOrder.userId,
  //       'shopId': shopId,
  //       'orderStatus': "Prepering",
  //       'orderDate': pendingOrder.orderDate,
  //       'orderTime': pendingOrder.orderTime,
  //       'totalAmount': pendingOrder.totalAmount,
  //       'userName': pendingOrder.userName,
  //     });
  //
  //     await shopOrderDocRef.set({
  //       'userId': pendingOrder.userId,
  //       'shopId': shopId,
  //       'orderStatus': "Prepering",
  //       'orderDate': pendingOrder.orderDate,
  //       'orderTime': pendingOrder.orderTime,
  //       'totalAmount': pendingOrder.totalAmount,
  //       'userName': pendingOrder.userName,
  //     });
  //     print('sended successfully');
  //
  //     List<OrderItem> orderItems =
  //         await fetchOrderItemsForPendingOrder(orderId);
  //
  //     // Add order items to User Data history
  //     CollectionReference userOrderItemsCollectionRef =
  //         userOrderDocRef.collection('OrderItems');
  //     for (var orderItem in orderItems) {
  //       await userOrderItemsCollectionRef.add({
  //         'itemName': orderItem.itemName,
  //         'itemPrice': orderItem.itemPrice,
  //         'itemId': orderItem.itemId,
  //         'itemQuantity': orderItem.itemQuantity,
  //       });
  //     }
  //
  //     // Add order items to ShopData Conform History
  //     CollectionReference shopOrderItemsCollectionRef =
  //         shopOrderDocRef.collection('OrderItems');
  //     for (var orderItem in orderItems) {
  //       await shopOrderItemsCollectionRef.add({
  //         'itemName': orderItem.itemName,
  //         'itemPrice': orderItem.itemPrice,
  //         'itemId': orderItem.itemId,
  //         'itemQuantity': orderItem.itemQuantity,
  //       });
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error updating orderStatus: $e');
  //   }
  // }

  Future<void> sendToConformHistory(
      String shopId,
      String userId,
      List<PendingOrder> pendingOrders,
      List<OrderItem> orderItemsList, // Change this parameter type
      String Status,
      String orderId,
      int index) async {
    try {
      print(orderId);
      print(orderId);
      print(orderId);
      print(orderId);

      CollectionReference userHistoryCollection = FirebaseFirestore.instance
          .collection('User Data')
          .doc(userId)
          .collection('History');

      CollectionReference shopHistoryCollection = FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History');

      PendingOrder? pendingOrder;

      for (int index = 0; index < pendingOrders.length; index++) {
        if (pendingOrders[index].orderId == orderId) {
          pendingOrder = pendingOrders[index];
          break; // Exit the loop once a match is found
        }
      }

      print(pendingOrder?.totalAmount);
      print('sending start');

      DocumentReference userOrderDocRef =
          userHistoryCollection.doc(pendingOrder?.orderId);
      print(userOrderDocRef);
      DocumentReference shopOrderDocRef =
          shopHistoryCollection.doc(pendingOrder?.orderId);
      print(shopOrderDocRef);

      await userOrderDocRef.set({
        'userId': pendingOrder?.userId,
        'shopId': shopId,
        'orderStatus': Status,
        'orderDate': pendingOrder?.orderDate,
        'orderTime': pendingOrder?.orderTime,
        'totalAmount': pendingOrder?.totalAmount,
        'userName': pendingOrder?.userName,
      });

      await shopOrderDocRef.set({
        'userId': pendingOrder?.userId,
        'shopId': shopId,
        'orderStatus': Status,
        'orderDate': pendingOrder?.orderDate,
        'orderTime': pendingOrder?.orderTime,
        'totalAmount': pendingOrder?.totalAmount,
        'userName': pendingOrder?.userName,
      });

      print('sended successfully');

      // You can now directly use the orderItemsList parameter instead of fetching it again
      // List<OrderItem> orderItems = await fetchOrderItemsForPendingOrder(orderId);

      // Add order items to User Data history
      CollectionReference userOrderItemsCollectionRef =
          userOrderDocRef.collection('OrderItems');
      for (var orderItem in orderItemsList) {
        await userOrderItemsCollectionRef.add({
          'itemName': orderItem.itemName,
          'itemPrice': orderItem.itemPrice,
          'itemId': orderItem.itemId,
          'itemQuantity': orderItem.itemQuantity,
        });
      }

      // Add order items to ShopData Conform History
      CollectionReference shopOrderItemsCollectionRef =
          shopOrderDocRef.collection('OrderItems');
      for (var orderItem in orderItemsList) {
        await shopOrderItemsCollectionRef.add({
          'itemName': orderItem.itemName,
          'itemPrice': orderItem.itemPrice,
          'itemId': orderItem.itemId,
          'itemQuantity': orderItem.itemQuantity,
        });
      }

      print('sended successfully2222');

      notifyListeners();
    } catch (e) {
      print('Error updating orderStatus: $e');
    }
  }

  Future<void> updateOrderStatus(
    String shopId,
    String userId,
    String newStatus,
    String orderId,
  ) async {
    try {
      CollectionReference userHistoryCollection = FirebaseFirestore.instance
          .collection('User Data')
          .doc(userId)
          .collection('History');

      CollectionReference shopHistoryCollection = FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History');

      // PendingOrder pendingOrder = pendingOrders[index];

      print('Updating order status');

      DocumentReference userOrderDocRef = userHistoryCollection.doc(orderId);
      DocumentReference shopOrderDocRef = shopHistoryCollection.doc(orderId);

      await userOrderDocRef.update({'orderStatus': newStatus});
      await shopOrderDocRef.update({'orderStatus': newStatus});

      print('Order status updated successfully');
      notifyListeners();
    } catch (e) {
      print('Error updating order status: $e');
    }
  }
}
