// import 'package:campus_craving_admin/bottomNavigation/Sales/povaiders/salesModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class ShopOrderProvider extends ChangeNotifier {
//   List<ShopSalesDataModel> shopDataList = [];
//   Map<String, double> totalAmounts = {};
//
//   Future<void> fetchData() async {
//     await fetchShopData();
//     await fetchTotalAmountForAllShops();
//   }
//
//   Future<void> fetchShopData() async {
//     try {
//       final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await FirebaseFirestore.instance.collection('ShopData').get();
//
//       shopDataList = querySnapshot.docs.map((doc) {
//         return ShopSalesDataModel(
//           shopId: doc.id,
//           shopName: doc.get('ShopName'),
//           phoneNumber: doc.get('PhoneNumber'),
//           ownerName: doc.get('OwnerName'),
//         );
//       }).toList();
//
//       notifyListeners();
//     } catch (error) {
//       print('Error fetching shop data: $error');
//     }
//   }
//
//   Future<void> fetchTotalAmountForAllShops() async {
//     final List<String> shopIds =
//         shopDataList.map((shop) => shop.shopId!).toList();
//
//     for (final shopId in shopIds) {
//       double totalAmount = await calculateTotalAmountForShop(shopId);
//       totalAmounts[shopId] = totalAmount; // Update totalAmounts
//     }
//
//     notifyListeners(); // Notify listeners when data changes
//   }
//
//   Future<double> calculateTotalAmountForShop(String shopId) async {
//     double totalAmount = 0;
//
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('ShopData')
//           .doc(shopId)
//           .collection('Conform History')
//           .get();
//
//       for (var doc in querySnapshot.docs) {
//         double orderTotalAmount = doc.get('totalAmount');
//         totalAmount += orderTotalAmount;
//       }
//     } catch (e) {
//       print('Error calculating total amount for Shop ID $shopId: $e');
//     }
//
//     return totalAmount;
//   }
// }

import 'package:campus_craving_admin/bottomNavigation/Sales/povaiders/salesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class ShopOrderProvider extends ChangeNotifier {
  List<ShopSalesDataModel> shopDataList = [];
  Map<String, double> totalAmounts = {};
  DateTime selectedDate = DateTime.now(); // Add selectedDate property

  Future<void> fetchData() async {
    await fetchShopData();
    await fetchTotalAmountForAllShops();
  }

  Future<void> fetchShopData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('ShopData').get();

      shopDataList = querySnapshot.docs.map((doc) {
        return ShopSalesDataModel(
          shopId: doc.id,
          shopName: doc.get('ShopName'),
          phoneNumber: doc.get('PhoneNumber'),
          ownerName: doc.get('OwnerName'),
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching shop data: $error');
    }
  }

  Future<void> fetchTotalAmountForAllShops() async {
    final List<String?> shopIds =
        shopDataList.map((shop) => shop.shopId).toList();

    // Clear existing data when fetching new data
    totalAmounts.clear();

    for (final shopId in shopIds) {
      double totalAmount = await calculateTotalAmountForShop(shopId!);
      totalAmounts[shopId] = totalAmount; // Update totalAmounts
    }

    notifyListeners(); // Notify listeners when data changes
  }

  Future<double> calculateTotalAmountForShop(String shopId) async {
    double totalAmount = 0;

    try {
      final formattedDate = DateFormat('dd/MM/yyyy')
          .format(selectedDate); // Format the selected date
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(shopId)
          .collection('Conform History')
          .where('orderDate',
              isEqualTo: formattedDate) // Use the formatted date
          .get();
      print(formattedDate);
      for (var doc in querySnapshot.docs) {
        double orderTotalAmount = doc.get('totalAmount');
        totalAmount += orderTotalAmount;
      }
    } catch (e) {
      print('Error calculating total amount for Shop ID $shopId: $e');
    }

    return totalAmount;
  }

  // Function to update selected date and fetch data for the new date
  Future<void> fetchDataForDate(DateTime newDate) async {
    selectedDate = newDate;
    print(selectedDate);
    await fetchTotalAmountForAllShops();
  }
}
