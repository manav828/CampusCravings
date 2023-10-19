// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import 'OrderStatus/orderModel.dart';
// // import 'OrderStatus/orderProvaider.dart';
// //
// // class OrderDeatils extends StatefulWidget {
// //   const OrderDeatils({Key? key}) : super(key: key);
// //
// //   @override
// //   State<OrderDeatils> createState() => _OrderDeatilsState();
// // }
// //
// // class _OrderDeatilsState extends State<OrderDeatils> {
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance?.addPostFrameCallback((_) {
// //       OrderProvaider orderProvaider =
// //           Provider.of<OrderProvaider>(context, listen: false);
// //
// //       // Fetch pending orders data
// //       orderProvaider.fatchPanddingOrderData();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: Text('OrderDeatils'),
// //         backgroundColor: Colors.red,
// //       ),
// //       body: Consumer<OrderProvaider>(
// //         builder: (context, orderProvaider, _) {
// //           // print('2222cjghfvedwdjhx/////////////////////////');
// //
// //           List<PendingOrder> pendingOrders =
// //               orderProvaider.getpendingOrdersList;
// //           List<PendingOrder> activePendingOrders = pendingOrders
// //               .where((order) => order.orderStatus != 'Cancelled')
// //               .toList();
// //
// //           activePendingOrders
// //               .sort((a, b) => a.orderTime.compareTo(b.orderTime));
// //
// //           print('Number of pending orders: ${pendingOrders.length}');
// //
// //           return ListView.builder(
// //             itemCount: activePendingOrders.length,
// //             // itemCount: pendingOrders.length,
// //             itemBuilder: (context, index) {
// //               PendingOrder pendingOrder = activePendingOrders[index];
// //
// //               return Container(
// //                 height: 200,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(18.0),
// //                   child: Card(
// //                     elevation: 4,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       side: BorderSide(
// //                         color: Colors.grey,
// //                         width: 1,
// //                       ),
// //                     ),
// //                     child: Column(
// //                       // mainAxisSize: MainAxisSize.min,
// //                       // mainAxisAlignment: MainAxisAlignment,
// //
// //                       children: <Widget>[
// //                         Expanded(
// //                           child: Row(
// //                             children: <Widget>[
// //                               Expanded(
// //                                 child: ListTile(
// //                                   title: Text(pendingOrder.userName),
// //                                   subtitle: Text(
// //                                       'Total : ${pendingOrder.totalAmount}'),
// //                                 ),
// //                               ),
// //                               // ButtonBar(
// //                               //   children: <Widget>[
// //                               //
// //                               //     TextButton(
// //                               //       child: Text('Accept'),
// //                               //       onPressed: () {
// //                               //         orderProvaider.sendOrderStatus(
// //                               //             pendingOrder.orderId, 'Accepted');
// //                               //       },
// //                               //     ),
// //                               //     TextButton(
// //                               //       child: Text('Cancel'),
// //                               //       onPressed: () {
// //                               //         orderProvaider.sendOrderStatus(
// //                               //             pendingOrder.orderId, 'Cancled');
// //                               //       },
// //                               //     ),
// //                               //   ],
// //                               // ),
// //                               ButtonBar(
// //                                 children: <Widget>[
// //                                   if (pendingOrder.orderStatus == 'Accepted')
// //                                     TextButton(
// //                                       child: Text('Accepted'),
// //                                       onPressed: () {
// //                                         // Add your onPressed logic for Accepted here
// //                                       },
// //                                     ),
// //                                   if (pendingOrder.orderStatus == 'Cancelled')
// //                                     TextButton(
// //                                       child: Text('Cancelled'),
// //                                       onPressed: () {
// //                                         // Add your onPressed logic for Cancelled here
// //                                       },
// //                                     ),
// //                                   if (pendingOrder.orderStatus == 'pending')
// //                                     // Show the Accept button when the order status is Pending or Accepted
// //                                     TextButton(
// //                                       child: Text('Accept'),
// //                                       onPressed: () {
// //                                         orderProvaider.sendOrderStatus(
// //                                             pendingOrder.orderId, 'Accepted');
// //
// //                                         // Create a list to store orderItemsList for each pending order
// //                                         List<List<OrderItem>> orderItemsLists =
// //                                             [];
// //                                         // for (var pendingorder in orderProvaider
// //                                         //     .getpendingOrdersList) {
// //                                         //   List<OrderItem> orderItems =
// //                                         //       orderProvaider
// //                                         //           .getorderItemMainList
// //                                         //           .where((orderItem) =>
// //                                         //               pendingOrder.orderId ==
// //                                         //               pendingorder.orderId)
// //                                         //           .toList();
// //                                         //   orderItemsLists
// //                                         //       .add(orderItems.toList());
// //                                         // }
// //
// //                                         orderProvaider.sendToConformHistory(
// //                                             pendingOrder.shopId,
// //                                             pendingOrder.userId,
// //                                             activePendingOrders,
// //                                             orderItemsLists,
// //                                             pendingOrder.orderId,
// //                                             index);
// //                                       },
// //                                     ),
// //                                   if (pendingOrder.orderStatus == 'pending')
// //                                     TextButton(
// //                                       child: Text('Cancel'),
// //                                       onPressed: () {
// //                                         showDialog(
// //                                           context: context,
// //                                           builder: (BuildContext context) {
// //                                             return AlertDialog(
// //                                               title: Text('Confirm Cancel'),
// //                                               content: Text(
// //                                                   'Are you sure you want to cancel this order?'),
// //                                               actions: <Widget>[
// //                                                 TextButton(
// //                                                   child: Text('Cancel'),
// //                                                   onPressed: () {
// //                                                     Navigator.of(context).pop();
// //                                                   },
// //                                                 ),
// //                                                 TextButton(
// //                                                   child: Text('Yes'),
// //                                                   onPressed: () {
// //                                                     orderProvaider
// //                                                         .sendOrderStatus(
// //                                                             pendingOrder
// //                                                                 .orderId,
// //                                                             'Cancelled');
// //                                                     Navigator.of(context).pop();
// //                                                   },
// //                                                 ),
// //                                               ],
// //                                             );
// //                                             orderProvaider.sendOrderStatus(
// //                                                 pendingOrder.orderId,
// //                                                 'Cancelled');
// //                                           },
// //                                         );
// //                                       },
// //                                     ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         Padding(
// //                           padding: EdgeInsets.all(16.0),
// //                           child: FutureBuilder<List<OrderItem>>(
// //                             future:
// //                                 orderProvaider.fetchOrderItemsForPendingOrder(
// //                                     pendingOrder.orderId),
// //                             builder: (context, snapshot) {
// //                               if (snapshot.connectionState ==
// //                                   ConnectionState.waiting) {
// //                                 return CircularProgressIndicator(); // Show a loading indicator while fetching data
// //                               } else if (snapshot.hasError) {
// //                                 return Text('Error: ${snapshot.error}');
// //                               } else {
// //                                 List<OrderItem> orderItems =
// //                                     snapshot.data ?? [];
// //
// //                                 return DropdownButton<String>(
// //                                   isExpanded: true,
// //                                   hint: Text('Select Order Details'),
// //                                   value: orderItems.isNotEmpty
// //                                       ? orderItems[0].itemId
// //                                       : null,
// //                                   items: orderItems.map((orderItem) {
// //                                     return DropdownMenuItem<String>(
// //                                       value: orderItem.itemId,
// //                                       child: Container(
// //                                         child: Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           crossAxisAlignment:
// //                                               CrossAxisAlignment.center,
// //                                           children: [
// //                                             Container(
// //                                               width: MediaQuery.sizeOf(context)
// //                                                       .width *
// //                                                   0.28,
// //                                               child: Text(orderItem.itemName!),
// //                                             ),
// //                                             Text(orderItem.itemQuantity
// //                                                 .toString()),
// //                                             Text(
// //                                                 orderItem.itemPrice.toString()),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     );
// //                                   }).toList(),
// //                                   onChanged: (String? newValue) {
// //                                     // TODO: Implement dropdown logic
// //                                     // fatchCartData
// //                                   },
// //                                 );
// //                               }
// //                             },
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'OrderStatus/orderModel.dart';
// import 'OrderStatus/orderProvaider.dart';
// import 'package:http/http.dart' as http;
//
// DateTime currentDate = DateTime.now();
// String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
//
// class OrderDeatils extends StatefulWidget {
//   const OrderDeatils({Key? key}) : super(key: key);
//
//   @override
//   State<OrderDeatils> createState() => _OrderDeatilsState();
// }
//
// class _OrderDeatilsState extends State<OrderDeatils> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       OrderProvaider orderProvaider =
//           Provider.of<OrderProvaider>(context, listen: false);
//
//       // Fetch pending orders data
//       orderProvaider.fatchPanddingOrderData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Order Details New Design'),
//         backgroundColor: Colors.red,
//       ),
//       body: Consumer<OrderProvaider>(
//         builder: (context, orderProvaider, _) {
//           List<PendingOrder> pendingOrders =
//               orderProvaider.getpendingOrdersList;
//           List<PendingOrder> activePendingOrders = pendingOrders
//               .where((order) =>
//                   order.orderStatus != 'Cancelled' &&
//                   order.orderDate == formattedDate)
//               .toList();
//
//           activePendingOrders
//               .sort((a, b) => a.orderTime.compareTo(b.orderTime));
//
//           return ListView.builder(
//             itemCount: activePendingOrders.length,
//             itemBuilder: (context, index) {
//               PendingOrder pendingOrder = activePendingOrders[index];
//
//               return Container(
//                 margin: EdgeInsets.all(20),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: BorderSide(
//                       color: Colors.grey,
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Name: ${pendingOrder.userName}"),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Text("Time: ${pendingOrder.orderTime}"),
//                                 SizedBox(
//                                   height: 8,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         Divider(color: Colors.black),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: Text("Item",
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                             Spacer(),
//                             Flexible(
//                               child: Text("Quantity",
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                             Spacer(),
//                             Flexible(
//                               child: Text("Price",
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         Divider(color: Colors.black),
//                         FutureBuilder<List<OrderItem>>(
//                           future: orderProvaider.fetchOrderItemsForPendingOrder(
//                               pendingOrder.orderId),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return CircularProgressIndicator();
//                             } else if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               List<OrderItem> orderItems = snapshot.data ?? [];
//
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: orderItems.map((orderItem) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Flexible(
//                                           child: Text(orderItem.itemName!),
//                                         ),
//                                         Spacer(),
//                                         Text(orderItem.itemQuantity.toString()),
//                                         Spacer(),
//                                         Text(orderItem.itemPrice.toString()),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                               );
//                             }
//                           },
//                         ),
//                         Divider(color: Colors.black),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Total : "),
//                             Text(pendingOrder.totalAmount.toString()),
//                           ],
//                         ),
//                         Divider(color: Colors.black),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   if (pendingOrder.orderStatus != 'Cancelled')
//                                     TextButton(
//                                       child: Text(
//                                         'Accepted',
//                                         style: TextStyle(
//                                             color: Color(0xFF32A43A),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       onPressed: () async {
//                                         final fcmToken = await FirebaseMessaging
//                                             .instance
//                                             .getToken();
//                                         print(fcmToken);
//                                         // var data = {
//                                         //   'to': '',
//                                         //   'priority': 'high',
//                                         //   'notification': {
//                                         //     'title': 'Order Details',
//                                         //     'body':
//                                         //         'Your order has been accepeted',
//                                         //   }
//                                         //   // 'data': {
//                                         //   //   'title': 'Order Details',
//                                         //   //   'body':
//                                         //   //       'Your order has been accepted',
//                                         //   // }
//                                         // };
//                                         // await http.post(
//                                         //     Uri.parse(
//                                         //         'https://fcm.googleapis.com/fcm/send'),
//                                         //     body: jsonEncode(data),
//                                         //     headers: {
//                                         //       'Content-Type':
//                                         //           'application/json; charset=UTF-8',
//                                         //       'Authorization':
//                                         //           'key=AAAAPtjH76g:APA91bFONvZNrIILVgj0eblOTjSyNVEi8e2lW1Goz6MeygAOLkJfIZZHoXm3Bq9DPKfZIUC-QcqKSMPUWD5LRJxrBbwjZvbwcxfh6mxHsrd5h06ZaS8ANJZC9vfyURsZSVkZafPV4ecr'
//                                         //     });
//                                         print("************************");
//
//                                         // String dataNotifications =
//                                         //     '{ "to" : "e5TOnLFWQ9Wzf6sK5UQxmu:APA91bEdkiIMMV8qlfowZ00jxM_cTkWbyAxDeRTrkyFAKmoP3SKX_6BC4Juc0F0gWz4wa_om_EQ05rQvIYpx2WLTutxJAfK4zWsVBJPG1ooN1V-WIWChjgq22pA9BWNTX2O8QOkjMUY-",'
//                                         //     ' "notification" : {'
//                                         //     ' "title":"Firebase Message",'
//                                         //     '"body":"your order status "'
//                                         //     ' }'
//                                         //     ' }';
//                                         //
//                                         // await http.post(
//                                         //   Uri.parse(
//                                         //       'https://fcm.googleapis.com/fcm/send'),
//                                         //   headers: <String, String>{
//                                         //     'Content-Type': 'application/json',
//                                         //     'Authorization':
//                                         //         'key=AAAAPtjH76g:APA91bFONvZNrIILVgj0eblOTjSyNVEi8e2lW1Goz6MeygAOLkJfIZZHoXm3Bq9DPKfZIUC-QcqKSMPUWD5LRJxrBbwjZvbwcxfh6mxHsrd5h06ZaS8ANJZC9vfyURsZSVkZafPV4ecr',
//                                         //   },
//                                         //   body: dataNotifications,
//                                         // );
//
//                                         // Add your onPressed logic for Accepted here
//                                       },
//                                     ),
//                                   if (pendingOrder.orderStatus == 'Cancelled')
//                                     TextButton(
//                                       child: Text('Cancelled'),
//                                       onPressed: () {
//                                         // Add your onPressed logic for Cancelled here
//                                       },
//                                     ),
//                                   if (pendingOrder.orderStatus == 'pending')
//                                     TextButton(
//                                       child: Text('Accept'),
//                                       onPressed: () async {
//                                         var data = {
//                                           'to':
//                                               'dbZXQtlTRfKbzGkLP8Oh40:APA91bHkNeDZS8s9ZXoRFlO9WE7SwQeAWNXkB2EUDhAtgICWtZMBAeq2My4MldnchNBCf7HWuFwjn1EqaQR_8EHM8M5LSXYpDPcMClVjQIkG64BBZ6UW_fnVafzrHq9LpD5_2AMnsElx',
//                                           'priority': 'high',
//                                           'notification': {
//                                             'title': 'Order Details',
//                                             'body':
//                                                 'Your order has been accepeted',
//                                           }
//                                         };
//                                         await http.post(
//                                             Uri.parse(
//                                                 'https://fcm.googleapis.com/fcm/send'),
//                                             body: jsonEncode(data),
//                                             headers: {
//                                               'Content-Type':
//                                                   'application/json; charset=UTF-8',
//                                               'Authorization':
//                                                   'key=AAAAPtjH76g:APA91bFONvZNrIILVgj0eblOTjSyNVEi8e2lW1Goz6MeygAOLkJfIZZHoXm3Bq9DPKfZIUC-QcqKSMPUWD5LRJxrBbwjZvbwcxfh6mxHsrd5h06ZaS8ANJZC9vfyURsZSVkZafPV4ecr'
//                                             });
//                                         print("************************");
//
//                                         orderProvaider.sendOrderStatus(
//                                             pendingOrder.orderId, 'Preparing');
//                                         List<List<OrderItem>> orderItemsLists =
//                                             [];
//                                         orderProvaider.sendToConformHistory(
//                                             pendingOrder.shopId,
//                                             pendingOrder.userId,
//                                             activePendingOrders,
//                                             orderItemsLists,
//                                             pendingOrder.orderId,
//                                             index);
//                                       },
//                                     ),
//                                   if (pendingOrder.orderStatus == 'pending')
//                                     TextButton(
//                                       child: Text('Cancel'),
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return AlertDialog(
//                                               title: Text('Confirm Cancel'),
//                                               content: Text(
//                                                   'Are you sure you want to cancel this order?'),
//                                               actions: [
//                                                 TextButton(
//                                                   child: Text('Cancel'),
//                                                   onPressed: () {
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                 ),
//                                                 TextButton(
//                                                   child: Text('Yes'),
//                                                   onPressed: () {
//                                                     orderProvaider
//                                                         .sendOrderStatus(
//                                                             pendingOrder
//                                                                 .orderId,
//                                                             'Cancelled');
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       },
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
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

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'OrderStatus/orderModel.dart';
import 'OrderStatus/orderProvaider.dart';
import 'package:http/http.dart' as http;

DateTime currentDate = DateTime.now();
String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

enum OrderStatusFilter {
  New,
  Preparing,
  Ready,
  Delivered,
}

class OrderDeatils extends StatefulWidget {
  const OrderDeatils({Key? key}) : super(key: key);

  @override
  State<OrderDeatils> createState() => _OrderDeatilsState();
}

class _OrderDeatilsState extends State<OrderDeatils> {
  OrderStatusFilter currentFilter = OrderStatusFilter.New;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      OrderProvaider orderProvaider =
          Provider.of<OrderProvaider>(context, listen: false);

      // Fetch pending orders data
      orderProvaider.fatchPanddingOrderData();
    });
  }

  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> _updateOrderStatus(String orderId, String newStatus) async {
    OrderProvaider orderProvaider =
        Provider.of<OrderProvaider>(context, listen: false);

    // Update the order status in Firebase
    await orderProvaider.sendOrderStatus(orderId, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Order Details New Design'),
      //   backgroundColor: Colors.red,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Consumer<OrderProvaider>(
          builder: (context, orderProvaider, _) {
            List<PendingOrder> pendingOrders =
                orderProvaider.getpendingOrdersList;
            List<PendingOrder> filteredOrders = pendingOrders
                .where((order) =>
                    (currentFilter == OrderStatusFilter.New &&
                        order.orderStatus == 'pending') ||
                    (currentFilter == OrderStatusFilter.Preparing &&
                        order.orderStatus == 'Preparing') ||
                    (currentFilter == OrderStatusFilter.Ready &&
                        order.orderStatus == 'Ready') ||
                    (currentFilter == OrderStatusFilter.Delivered &&
                        order.orderStatus == 'Delivered'))
                .toList();

            filteredOrders.sort((a, b) => a.orderTime.compareTo(b.orderTime));

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal, // Make it scroll horizontally
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = OrderStatusFilter.New;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: currentFilter == OrderStatusFilter.New
                                ? Colors.green
                                : Colors.grey,
                          ),
                          child: Text('New Orders'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = OrderStatusFilter.Preparing;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                currentFilter == OrderStatusFilter.Preparing
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                          child: Text('Preparing'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = OrderStatusFilter.Ready;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: currentFilter == OrderStatusFilter.Ready
                                ? Colors.green
                                : Colors.grey,
                          ),
                          child: Text('Ready'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = OrderStatusFilter.Delivered;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                currentFilter == OrderStatusFilter.Delivered
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                          child: Text('Delivered'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      PendingOrder pendingOrder = filteredOrders[index];

                      return Container(
                        margin: EdgeInsets.all(20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Name: ${pendingOrder.userName}"),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Time: ${pendingOrder.orderTime}"),
                                        SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.black),
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
                                FutureBuilder<List<OrderItem>>(
                                  future: orderProvaider
                                      .fetchOrderItemsForPendingOrder(
                                          pendingOrder.orderId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      List<OrderItem> orderItems =
                                          snapshot.data ?? [];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: orderItems.map((orderItem) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child:
                                                      Text(orderItem.itemName!),
                                                ),
                                                Spacer(),
                                                Text(orderItem.itemQuantity
                                                    .toString()),
                                                Spacer(),
                                                Text(orderItem.itemPrice
                                                    .toString()),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  },
                                ),
                                Divider(color: Colors.black),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total : "),
                                    Text(pendingOrder.totalAmount.toString()),
                                  ],
                                ),
                                Divider(color: Colors.black),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (currentFilter ==
                                                  OrderStatusFilter.New &&
                                              pendingOrder.orderStatus ==
                                                  'pending')
                                            TextButton(
                                              child: Text('Accept'),
                                              onPressed: () async {
                                                // Update order status to "Accepted"

                                                try {
                                                  await _updateOrderStatus(
                                                      pendingOrder.orderId,
                                                      'Preparing');
                                                  // pendingOrder.orderStatus =
                                                  //     'Preparing';
                                                  // print(".////////////////");

                                                  // print(
                                                  //     pendingOrder.orderStatus);

                                                  // Call sendToConformHistory and pass the necessary parameters

                                                  await orderProvaider
                                                      .sendToConformHistory(
                                                    firebaseUser!
                                                        .uid, // Shop ID
                                                    pendingOrder
                                                        .userId, // User ID
                                                    orderProvaider
                                                        .getpendingOrdersList, // List of pending orders
                                                    orderProvaider
                                                        .getorderItemMainList,
                                                    // List of order items
                                                    "Prepering",

                                                    pendingOrder
                                                        .orderId, // Order ID
                                                    index, // Index of the accepted order
                                                  );

                                                  // Send a notification to the user
                                                  // final fcmToken =
                                                  //     await FirebaseMessaging
                                                  //         .instance
                                                  //         .getToken();
                                                  // var data = {
                                                  //   'to': fcmToken,
                                                  //   'priority': 'high',
                                                  //   'notification': {
                                                  //     'title': 'Order Details',
                                                  //     'body':
                                                  //         'Your order has been accepted',
                                                  //   }
                                                  // };
                                                  // await http.post(
                                                  //   Uri.parse(
                                                  //       'https://fcm.googleapis.com/fcm/send'),
                                                  //   body: jsonEncode(data),
                                                  //   headers: {
                                                  //     'Content-Type':
                                                  //         'application/json; charset=UTF-8',
                                                  //     'Authorization':
                                                  //         'key=YOUR_FCM_SERVER_KEY',
                                                  //   },
                                                  // );
                                                } catch (e) {
                                                  print('Error: $e');
                                                }
                                              },
                                            ),
                                          if (currentFilter ==
                                                  OrderStatusFilter.Preparing &&
                                              pendingOrder.orderStatus ==
                                                  'Preparing')
                                            TextButton(
                                              child: Text('Ready'),
                                              onPressed: () async {
                                                // Update order status to "Ready"
                                                await _updateOrderStatus(
                                                    pendingOrder.orderId,
                                                    'Ready');
                                                // await _updateOrderStatus(
                                                //     pendingOrder.orderId,
                                                //     'Accepted');

                                                await orderProvaider
                                                    .updateOrderStatus(
                                                        firebaseUser!.uid,
                                                        pendingOrder.userId,
                                                        "Ready",
                                                        pendingOrder.orderId);
                                              },
                                            ),
                                          if (currentFilter ==
                                                  OrderStatusFilter.Ready &&
                                              pendingOrder.orderStatus ==
                                                  'Ready')
                                            TextButton(
                                              child: Text('Delivered'),
                                              onPressed: () async {
                                                // Update order status to "Delivered"
                                                await _updateOrderStatus(
                                                    pendingOrder.orderId,
                                                    'Delivered');

                                                await orderProvaider
                                                    .updateOrderStatus(
                                                        firebaseUser!.uid,
                                                        pendingOrder.userId,
                                                        "Delivered",
                                                        pendingOrder.orderId);
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
