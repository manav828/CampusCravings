import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../orders/OrderStatus/orderModel.dart';

import 'historyModel.dart';

class HistoryProvaider with ChangeNotifier {
  List<ConformedOrder> shopOrderHistoryList = [];

  // Function to fetch confirmed order history for a specific shop
  Future<void> fatchShopOrderHistory(String shopId) async {
    shopOrderHistoryList.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History')
          .get();

      for (var doc in querySnapshot.docs) {
        String orderId = doc.id;
        String userId = doc.get('userId');
        String orderStatus = doc.get('orderStatus');
        String orderDate = doc.get('orderDate');
        String orderTime = doc.get('orderTime');
        double totalAmount = doc.get('totalAmount');
        String userName = doc.get('userName');

        ConformedOrder confirmedOrder = ConformedOrder(
          orderId: orderId,
          userId: userId,
          shopId: shopId,
          orderStatus: orderStatus,
          orderDate: orderDate,
          orderTime: orderTime,
          totalAmount: totalAmount,
          userName: userName,
          orderItemsList: [], // Initialize an empty list of order items for now
        );

        // Fetch order items for this order from the subcollection
        List<OrderHistoryItem> orderItemsList =
            await fetchOrderItemsForShopOrder(shopId, orderId);
        confirmedOrder.orderItemsList = orderItemsList;

        shopOrderHistoryList.add(confirmedOrder);
      }
    } catch (e) {
      print('Error fetching shop order history: $e');
    }

    notifyListeners();
  }

  List<ConformedOrder> get getAllHistory {
    return shopOrderHistoryList;
  }

  // Function to fetch order items for a specific shop order
  Future<List<OrderHistoryItem>> fetchOrderItemsForShopOrder(
      String shopId, String orderId) async {
    List<OrderHistoryItem> orderItemsList = [];
    // List<OrderItem> orderItemsList = [];

    try {
      CollectionReference orderItemsRef = FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History')
          .doc(orderId)
          .collection('OrderItems');

      QuerySnapshot querySnapshot = await orderItemsRef.get();

      orderItemsList = querySnapshot.docs.map((doc) {
        return OrderHistoryItem(
          itemName: doc.get('itemName'),
          itemPrice: doc.get('itemPrice'),
          itemId: doc.get('itemId'),
          itemQuantity: doc.get('itemQuantity'),
        );
      }).toList();
    } catch (e) {
      print('Error fetching order items for shop order: $e');
    }

    return orderItemsList;
  }

  Future<List<ConformedOrder>> fetchOrdersByDate(
      String shopId, String selectedDate) async {
    List<ConformedOrder> filteredOrders = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History')
          .where('orderDate', isEqualTo: selectedDate)
          .get();

      for (var doc in querySnapshot.docs) {
        String orderId = doc.id;
        String userId = doc.get('userId');
        String orderStatus = doc.get('orderStatus');
        String orderDate = doc.get('orderDate');
        String orderTime = doc.get('orderTime');
        double totalAmount = doc.get('totalAmount');
        String userName = doc.get('userName');

        ConformedOrder confirmedOrder = ConformedOrder(
          orderId: orderId,
          userId: userId,
          shopId: shopId,
          orderStatus: orderStatus,
          orderDate: orderDate,
          orderTime: orderTime,
          totalAmount: totalAmount,
          userName: userName,
          orderItemsList: [], // Initialize an empty list of order items for now
        );

        // Fetch order items for this order from the subcollection
        List<OrderHistoryItem> orderItemsList =
            await fetchOrderItemsForShopOrder(shopId, orderId);
        confirmedOrder.orderItemsList = orderItemsList;

        filteredOrders.add(confirmedOrder);
      }

      return filteredOrders;
    } catch (e) {
      print('Error fetching orders by date: $e');
      return [];
    }
  }

  Future<List<ConformedOrder>> fetchOrdersByDateRange(
      String shopId, String startDate, String endDate) async {
    List<ConformedOrder> filteredOrders = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History')
          .where('orderDate', isGreaterThanOrEqualTo: startDate)
          .where('orderDate', isLessThanOrEqualTo: endDate)
          .get();

      for (var doc in querySnapshot.docs) {
        String orderId = doc.id;
        String userId = doc.get('userId');
        String orderStatus = doc.get('orderStatus');
        String orderDate = doc.get('orderDate');
        String orderTime = doc.get('orderTime');
        double totalAmount = doc.get('totalAmount');
        String userName = doc.get('userName');

        ConformedOrder confirmedOrder = ConformedOrder(
          orderId: orderId,
          userId: userId,
          shopId: shopId,
          orderStatus: orderStatus,
          orderDate: orderDate,
          orderTime: orderTime,
          totalAmount: totalAmount,
          userName: userName,
          orderItemsList: [], // Initialize an empty list of order items for now
        );

        // Fetch order items for this order from the subcollection
        List<OrderHistoryItem> orderItemsList =
            await fetchOrderItemsForShopOrder(shopId, orderId);
        confirmedOrder.orderItemsList = orderItemsList;

        filteredOrders.add(confirmedOrder);
      }

      return filteredOrders;
    } catch (e) {
      print('Error fetching orders by date range: $e');
      return [];
    }
  }
}
