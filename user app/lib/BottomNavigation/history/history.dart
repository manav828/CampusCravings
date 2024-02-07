// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class History extends StatelessWidget {
//   const History({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('History'),
//       ),
//     );
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'getHistory/historyModel.dart';
// import 'getHistory/historyProvaider.dart';
// import 'package:intl/intl.dart';
// // import 'path_to_history_provaider/history_provaider.dart';
// // import 'path_to_history_provaider/conformed_order_model.dart';
//
// class ShopOrderHistoryScreen extends StatefulWidget {
//   @override
//   _ShopOrderHistoryScreenState createState() => _ShopOrderHistoryScreenState();
// }
//
// class _ShopOrderHistoryScreenState extends State<ShopOrderHistoryScreen> {
//   DateTime _selectedDate = DateTime.now(); // Initialize with the current date
//   List<ConformedOrder> _filteredOrders = [];
//   String? user = (FirebaseAuth.instance.currentUser)?.uid;
//   String? date;
//   void initState() {
//     super.initState();
//
//     // Fetch shop order history when the screen is initialized
//
//     _fetchShopOrderHistory(user);
//   }
//
//   // Function to fetch shop order history
//   void _fetchShopOrderHistory(String? user) async {
//     HistoryProvaider historyProvider =
//         Provider.of<HistoryProvaider>(context, listen: false);
//
//     String? shopId = user; // Replace with the actual shop ID
//     await historyProvider.fatchShopOrderHistory(shopId!);
//     List<ConformedOrder> orders = historyProvider.shopOrderHistoryList;
//
//     setState(() {
//       _filteredOrders = orders;
//     });
//
//     // Fetch order items for each order in the filtered list
//     for (var order in _filteredOrders) {
//       List<OrderHistoryItem> orderItems = await historyProvider
//           .fetchOrderItemsForShopOrder(shopId, order.orderId);
//       order.orderItemsList = orderItems;
//     }
//   }
//
//   DateFormat dateFormat = DateFormat('dd/MM/yyyy'); // Define the date format
//
//   String formatDate(DateTime date) {
//     return dateFormat.format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     HistoryProvaider historyProvider = Provider.of<HistoryProvaider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shop Order History'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: _selectedDate,
//                 firstDate: DateTime(DateTime.now().year - 5),
//                 lastDate: DateTime(DateTime.now().year + 5),
//               );
//               if (pickedDate != null && pickedDate != _selectedDate) {
//                 setState(() {
//                   _selectedDate = pickedDate;
//                   date = formatDate(_selectedDate);
//                 });
//                 _fetchOrdersBySelectedDate(historyProvider);
//               }
//             },
//             child: date == null ? Text('Select Date') : Text("$date "),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: historyProvider.shopOrderHistoryList.length,
//               itemBuilder: (context, index) {
//                 ConformedOrder confirmedOrder =
//                     historyProvider.shopOrderHistoryList[index];
//
//                 return Container(
//                   padding: EdgeInsets.all(10), // Add padding
//                   margin: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black), // Add border
//                     borderRadius:
//                         BorderRadius.circular(10), // Add border radius
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Name: ${confirmedOrder.userName}"),
//                           Text("Time: ${confirmedOrder.orderTime}"),
//                           Text("Id: ${confirmedOrder.orderId}"),
//                         ],
//                       ),
//                       Divider(color: Colors.black), // Add divider
//
//                       // Order Details
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Order Details",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           SizedBox(height: 10), // Add spacing
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Flexible(
//                                 child: Text("Item",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                               ),
//                               Spacer(), // Add spacing between columns
//                               Flexible(
//                                 child: Text("Quantity",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                               ),
//                               Spacer(), // Add spacing between columns
//                               Flexible(
//                                 child: Text("Price",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                               ),
//                             ],
//                           ),
//                           Divider(color: Colors.black),
//                           Column(
//                             children: confirmedOrder.orderItemsList.map((item) {
//                               return Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Text(item.itemName ?? ""),
//                                   ),
//                                   Spacer(), // Add spacing between columns
//                                   Text(item.itemQuantity.toString()),
//                                   Spacer(), // Add spacing between columns
//                                   Text("${item.itemPrice}\$"),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//
//                       // Total Items and Total Price
//                       SizedBox(height: 10), // Add spacing
//                       Text(
//                           "Total Items : ${confirmedOrder.orderItemsList.length}"),
//                       Text(
//                           "Total Price : ${confirmedOrder.totalAmount.toStringAsFixed(2)}\$"),
//
//                       // Add more widgets as needed
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Text('Total Amount for Selected Orders: ${_calculateTotalAmount()}'),
//         ],
//       ),
//     );
//   }
//
//   void _fetchOrdersBySelectedDate(HistoryProvaider historyProvider) async {
//     String? shopId = user; // Replace with the actual shop ID
//     String date = formatDate(_selectedDate);
//
//     List<ConformedOrder> orders =
//         await historyProvider.fetchOrdersByDate(shopId!, date);
//     setState(() {
//       _filteredOrders = orders;
//     });
//   }
//
//   double _calculateTotalAmount() {
//     double totalAmount = 0.0;
//     for (var order in _filteredOrders) {
//       totalAmount += order.totalAmount;
//     }
//     return totalAmount;
//   }
// }
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'getHistory/historyModel.dart';
import 'getHistory/historyProvaider.dart';
import 'package:intl/intl.dart';

class UserOrderHistory extends StatefulWidget {
  @override
  _UserOrderHistoryState createState() => _UserOrderHistoryState();
}

class _UserOrderHistoryState extends State<UserOrderHistory> {
  DateTime _selectedDate = DateTime.now(); // Initialize with the current date
  List<ConformedOrder> _filteredOrders = [];
  String? user = (FirebaseAuth.instance.currentUser)?.uid;
  String? date;

  @override
  void initState() {
    super.initState();
    _fetchShopOrderHistory(user);
  }

  void _fetchShopOrderHistory(String? user) async {
    HistoryProvaider historyProvider =
        Provider.of<HistoryProvaider>(context, listen: false);

    // String? shopId = user; // Replace with the actual shop ID
    await historyProvider.fatchUserOrderHistory(user!);
    List<ConformedOrder> orders = historyProvider.shopOrderHistoryList;

    setState(() {
      _filteredOrders = orders;
    });

    // Fetch order items for each order in the filtered list
    for (var order in _filteredOrders) {
      List<OrderHistoryItem> orderItems = await historyProvider
          .fetchOrderItemsForShopOrder(user, order.orderId);
      order.orderItemsList = orderItems;
    }
  }

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  String formatDate(DateTime date) {
    return dateFormat.format(date);
  }

  void _fetchOrdersBySelectedDate(HistoryProvaider historyProvider) async {
    String? userId = user;
    String date = formatDate(_selectedDate);

    List<ConformedOrder> orders =
        await historyProvider.fetchOrdersByDate(userId!, date);
    setState(() {
      _filteredOrders = orders;
    });
  }

  double _calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var order in _filteredOrders) {
      totalAmount += order.totalAmount;
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    HistoryProvaider historyProvider = Provider.of<HistoryProvaider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Shop Order History'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                        date = formatDate(_selectedDate);
                      });
                      _fetchOrdersBySelectedDate(historyProvider);
                    }
                  },
                  child: date == null ? Text('Select Date') : Text("$date "),
                ),
                ElevatedButton(
                    child: Text('Over All Data'),
                    onPressed: () async {
                      _fetchShopOrderHistory(user);
                    }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                ConformedOrder confirmedOrder = _filteredOrders[index];

                return Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.red),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${confirmedOrder.shopName}"),
                              SizedBox(height: 4),
                              Text("Time: ${confirmedOrder.orderTime}"),
                              SizedBox(height: 4),
                              Text("Id: ${confirmedOrder.orderId}"),
                              SizedBox(height: 4),
                            ],
                          ),
                          Divider(color: Colors.black),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Order Details :",
                              //     style: TextStyle(fontWeight: FontWeight.bold)),
                              // SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text("Item",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text("Quantity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text("Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.black),
                              Column(
                                children:
                                    confirmedOrder.orderItemsList.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(item.itemName ?? ""),
                                        ),
                                        Spacer(),
                                        Text(item.itemQuantity.toString()),
                                        Spacer(),
                                        Text("${item.itemPrice}\$"),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.black),
                          Text(
                              "Total Items : ${confirmedOrder.orderItemsList.length}"),
                          Text(
                              "Total Price : ${confirmedOrder.totalAmount.toStringAsFixed(2)}\$"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text('Total Amount for Selected Orders: ${_calculateTotalAmount()}'),
        ],
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'getHistory/historyModel.dart';
// import 'getHistory/historyProvaider.dart';
// import 'package:intl/intl.dart';
//
// enum OrderFilter {
//   SelectedDate,
//   Weekly,
//   LastMonth,
//   All,
// }
//
// class ShopOrderHistoryScreen extends StatefulWidget {
//   @override
//   _ShopOrderHistoryScreenState createState() => _ShopOrderHistoryScreenState();
// }
//
// class _ShopOrderHistoryScreenState extends State<ShopOrderHistoryScreen> {
//   DateTime _selectedDate = DateTime.now();
//   List<ConformedOrder> _filteredOrders = [];
//   OrderFilter _currentFilter = OrderFilter.SelectedDate;
//   String? user = (FirebaseAuth.instance.currentUser)?.uid;
//   late HistoryProvaider historyProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     historyProvider = Provider.of<HistoryProvaider>(context, listen: false);
//     _fetchShopOrderHistory(user);
//   }
//
//   void _fetchShopOrderHistory(String? user) async {
//     historyProvider.fatchShopOrderHistory(user!);
//     List<ConformedOrder> orders = historyProvider.shopOrderHistoryList;
//
//     setState(() {
//       _filteredOrders = orders;
//     });
//
//     for (var order in _filteredOrders) {
//       List<OrderHistoryItem> orderItems = await historyProvider
//           .fetchOrderItemsForShopOrder(user, order.orderId);
//       order.orderItemsList = orderItems;
//     }
//   }
//
//   void _fetchOrdersBySelectedDate() async {
//     String? shopId = user;
//     String date = DateFormat('dd/MM/yyyy').format(_selectedDate);
//
//     List<ConformedOrder> orders =
//         await historyProvider.fetchOrdersByDate(shopId!, date);
//     setState(() {
//       _filteredOrders = orders;
//     });
//   }
//
//   void _fetchWeeklyOrders() async {
//     // Calculate the start and end date of the current week
//     DateTime now = DateTime.now();
//     DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
//     DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
//
//     String? shopId = user;
//     String startDate = DateFormat('dd/MM/yyyy').format(startOfWeek);
//     String endDate = DateFormat('dd/MM/yyyy').format(endOfWeek);
//
//     List<ConformedOrder> orders = await historyProvider.fetchOrdersByDateRange(
//         shopId!, startDate, endDate);
//     setState(() {
//       _filteredOrders = orders;
//     });
//   }
//
//   void _fetchLastMonthOrders() async {
//     // Calculate the start and end date of the last month
//     DateTime now = DateTime.now();
//     DateTime lastMonthStart = DateTime(now.year, now.month - 1, 1);
//     DateTime lastMonthEnd =
//         DateTime(now.year, now.month, 0).add(Duration(days: 1));
//
//     String? shopId = user;
//     String startDate = DateFormat('dd/MM/yyyy').format(lastMonthStart);
//     String endDate = DateFormat('dd/MM/yyyy').format(lastMonthEnd);
//
//     List<ConformedOrder> orders = await historyProvider.fetchOrdersByDateRange(
//         shopId!, startDate, endDate);
//     setState(() {
//       _filteredOrders = orders;
//     });
//   }
//
//   void _fetchAllOrders() {
//     String? shopId = user;
//     _fetchShopOrderHistory(shopId);
//   }
//
//   double _calculateTotalAmount() {
//     double totalAmount = 0.0;
//     for (var order in _filteredOrders) {
//       totalAmount += order.totalAmount;
//     }
//     return totalAmount;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shop Order History'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: _selectedDate,
//                 firstDate: DateTime(DateTime.now().year - 5),
//                 lastDate: DateTime(DateTime.now().year + 5),
//               );
//               if (pickedDate != null && pickedDate != _selectedDate) {
//                 setState(() {
//                   _selectedDate = pickedDate;
//                   _currentFilter = OrderFilter.SelectedDate;
//                 });
//                 _fetchOrdersBySelectedDate();
//               }
//             },
//             child: Text('Select Date'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _currentFilter = OrderFilter.Weekly;
//               });
//               _fetchWeeklyOrders();
//             },
//             child: Text('Weekly Orders'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _currentFilter = OrderFilter.LastMonth;
//               });
//               _fetchLastMonthOrders();
//             },
//             child: Text('Last Month Orders'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _currentFilter = OrderFilter.All;
//               });
//               _fetchAllOrders();
//             },
//             child: Text('All Orders'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredOrders.length,
//               itemBuilder: (context, index) {
//                 ConformedOrder confirmedOrder = _filteredOrders[index];
//
//                 return Container(
//                   margin: EdgeInsets.all(20),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(
//                         color: Colors.grey,
//                         width: 1,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Name: ${confirmedOrder.userName}"),
//                               SizedBox(height: 4),
//                               Text("Time: ${confirmedOrder.orderTime}"),
//                               SizedBox(height: 4),
//                               Text("Id: ${confirmedOrder.orderId}"),
//                               SizedBox(height: 4),
//                             ],
//                           ),
//                           Divider(color: Colors.black),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Text("Item",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   Spacer(),
//                                   Flexible(
//                                     child: Text("Quantity",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   Spacer(),
//                                   Flexible(
//                                     child: Text("Price",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ],
//                               ),
//                               Divider(color: Colors.black),
//                               Column(
//                                 children:
//                                     confirmedOrder.orderItemsList.map((item) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Flexible(
//                                           child: Text(item.itemName ?? ""),
//                                         ),
//                                         Spacer(),
//                                         Text(item.itemQuantity.toString()),
//                                         Spacer(),
//                                         Text("${item.itemPrice}\$"),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Divider(color: Colors.black),
//                           Text(
//                               "Total Items : ${confirmedOrder.orderItemsList.length}"),
//                           Text(
//                               "Total Price : ${confirmedOrder.totalAmount.toStringAsFixed(2)}\$"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Text('Total Amount for Selected Orders: ${_calculateTotalAmount()}'),
//         ],
//       ),
//     );
//   }
// }
