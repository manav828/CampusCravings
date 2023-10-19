// import 'package:campus_craving_admin/bottomNavigation/Sales/povaiders/salesProvaider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Sales extends StatefulWidget {
//   const Sales({Key? key}) : super(key: key);
//
//   @override
//   State<Sales> createState() => _SalesState();
// }
//
// class _SalesState extends State<Sales> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch shop data and total order amounts when the widget is initialized
//     final shopOrderProvider =
//         Provider.of<ShopOrderProvider>(context, listen: false);
//     shopOrderProvider.fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sales"),
//       ),
//       body: Consumer<ShopOrderProvider>(
//         builder: (context, shopOrderProvider, child) {
//           final totalAmounts = shopOrderProvider.totalAmounts;
//           final shopDataList = shopOrderProvider.shopDataList;
//
//           if (totalAmounts.isEmpty || shopDataList.isEmpty) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           return ListView.builder(
//             itemCount: shopDataList.length,
//             itemBuilder: (context, index) {
//               final shopData = shopDataList[index];
//               final shopId = shopData.shopId!;
//               final shopName = shopData.shopName;
//               final phoneNumber = shopData.phoneNumber;
//               final ownerName = shopData.ownerName;
//               final totalAmount = totalAmounts[shopId];
//
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Shop Name: $shopName",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text("Shop ID: $shopId"),
//                         SizedBox(height: 8),
//                         Text("Phone Number: $phoneNumber"),
//                         SizedBox(height: 8),
//                         Text("Owner Name: $ownerName"),
//                         SizedBox(height: 8),
//                         Text(
//                           "Total Amount: ${totalAmount?.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:campus_craving_admin/bottomNavigation/Sales/povaiders/salesModel.dart';
import 'package:campus_craving_admin/bottomNavigation/Sales/povaiders/salesProvaider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the date formatting library
import 'package:provider/provider.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  void initState() {
    super.initState();
    // Fetch shop data and total order amounts when the widget is initialized
    final shopOrderProvider =
        Provider.of<ShopOrderProvider>(context, listen: false);
    shopOrderProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final shopOrderProvider = Provider.of<ShopOrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sales"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("Select Date:"),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "Select",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  DateFormat('dd/MM/yyyy').format(shopOrderProvider.selectedDate
                      .toLocal()), // Format the date
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ShopOrderProvider>(
              builder: (context, shopOrderProvider, child) {
                final totalAmounts = shopOrderProvider.totalAmounts;
                final shopDataList = shopOrderProvider.shopDataList;

                if (totalAmounts.isEmpty || shopDataList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                // Filter out shops with total amounts less than or equal to 0
                final filteredShopDataList = shopDataList.where((shopData) {
                  final totalAmount = totalAmounts[shopData.shopId!];
                  return totalAmount != null && totalAmount > 0;
                }).toList();

                if (filteredShopDataList.isEmpty) {
                  // No transactions for the selected date
                  return Center(
                    child: Text(
                      "No transactions today",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredShopDataList.length,
                  itemBuilder: (context, index) {
                    final shopData = filteredShopDataList[index];
                    final shopId = shopData.shopId!;
                    final shopName = shopData.shopName;
                    final phoneNumber = shopData.phoneNumber;
                    final ownerName = shopData.ownerName;
                    final totalAmount = totalAmounts[shopId];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shop Name: $shopName",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text("Shop ID: $shopId"),
                              SizedBox(height: 8),
                              Text("Phone Number: $phoneNumber"),
                              SizedBox(height: 8),
                              Text("Owner Name: $ownerName"),
                              SizedBox(height: 8),
                              Text(
                                "Total Amount: ${totalAmount?.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          Provider.of<ShopOrderProvider>(context, listen: false).selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked !=
            Provider.of<ShopOrderProvider>(context, listen: false).selectedDate)
      setState(() {
        Provider.of<ShopOrderProvider>(context, listen: false).selectedDate =
            picked;
        Provider.of<ShopOrderProvider>(context, listen: false).fetchDataForDate(
            picked); // Call the function with the selected date
      });
  }
}
