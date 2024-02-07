import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OrderStatus/orderModel.dart';
import 'OrderStatus/orderProvaider.dart';

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
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       OrderProvaider orderProvaider =
//           Provider.of<OrderProvaider>(context, listen: false);
//
//       // orderProvaider.fatchOrderData();
//
//       print('fatching data /////cart///// item dart');
//     });
//   }
//
//   OrderProvaider? orderProvaider;
//   @override
//   Widget build(BuildContext context) {
//     orderProvaider = Provider.of<OrderProvaider>(context, listen: false);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('OrderDeatils'),
//         backgroundColor: Colors.red,
//       ),
//       body: ListView(children: [
//         Container(
//           height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Card(
//               elevation:
//                   4, // Adjust the elevation for the desired shadow effect
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                     10), // Set the border radius as needed
//                 side: BorderSide(
//                   color: Colors.grey, // Set the color of the border
//                   width: 1, // Set the width of the border
//                 ),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: ListTile(
//                           title: Text('John Doe'),
//                           subtitle: Text('123 Main Street'),
//                         ),
//                       ),
//                       ButtonBar(
//                         children: <Widget>[
//                           TextButton(
//                             child: Text('Accept'),
//                             onPressed: () {
//                               // TODO: Implement accept logic
//                               // orderProvaider?.fatchOrderData();
//                               print('fatch data called');
//                             },
//                           ),
//                           // TextButton(
//                           //   child: Text('Cancel'),
//                           //   onPressed: () {
//                           //     // TODO: Implement cancel logic
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: DropdownButton<String>(
//                       isExpanded: true,
//                       hint: Text('Select Order Details'),
//                       value: 'Item 1',
//                       items: [
//                         DropdownMenuItem<String>(
//                           value: 'Item 1',
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Margerita'),
//                               Text('5'),
//                               Text('199'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem<String>(
//                           value: 'Item 2',
//                           child: Text('Item 2 - \$15.99'),
//                         ),
//                         DropdownMenuItem<String>(
//                           value: 'Item 3',
//                           child: Text('Item 3 - \$12.99'),
//                         ),
//                       ],
//                       onChanged: (String? newValue) {
//                         // TODO: Implement dropdown logic
//                         // fatchCartData
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }

class OrderDeatils extends StatefulWidget {
  const OrderDeatils({Key? key}) : super(key: key);

  @override
  State<OrderDeatils> createState() => _OrderDeatilsState();
}

class _OrderDeatilsState extends State<OrderDeatils> {
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

  // void dispose() {
  //   // Call the dispose method of the provider when the widget is disposed
  //   Provider.of<OrderProvaider>(context, listen: false).dispose();
  //   super.dispose();
  // }
  Map<String, List<OrderItem>> orderItemCache = {};
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.red,
      ),
      body: Consumer<OrderProvaider>(
        builder: (context, orderProvaider, _) {
          // print('2222cjghfvedwdjhx/////////////////////////');

          List<PendingOrder> pendingOrders =
              orderProvaider.getpendingOrdersList;
          pendingOrders = pendingOrders.where((order) {
            final orderDateParts = order.orderDate.split('/');
            final orderDay = int.tryParse(orderDateParts[0]);
            final orderMonth = int.tryParse(orderDateParts[1]);
            final orderYear = int.tryParse(orderDateParts[2]);

            return orderDay == now.day &&
                orderMonth == now.month &&
                orderYear == now.year;
          }).toList();
          print('Number of pending orders: ${pendingOrders.length}');
          pendingOrders.sort((a, b) => a.orderTime.compareTo(b.orderTime));
          return ListView.builder(
            itemCount: pendingOrders.length,
            itemBuilder: (context, index) {
              PendingOrder pendingOrder = pendingOrders[index];

              return Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment,

                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text(pendingOrder.shopName),
                                  subtitle: Text(pendingOrder.shopOwnerName),
                                ),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  TextButton(
                                    child: Text(pendingOrder.orderStatus),
                                    onPressed: () {
                                      // TODO: Implement accept logic
                                      // orderProvaider?.fatchOrderData();
                                      // print('fatch data called');
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text('Total'),
                                  subtitle:
                                      Text(pendingOrder.totalAmount.toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: FutureBuilder<List<OrderItem>>(
                            future:
                                orderProvaider.fetchOrderItemsForPendingOrder(
                                    pendingOrder.orderId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Show a loading indicator while fetching data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<OrderItem> orderItems =
                                    snapshot.data ?? [];

                                return DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text('Select Order Details'),
                                  value: orderItems.isNotEmpty
                                      ? orderItems[0].itemId
                                      : null,
                                  items: orderItems.map((orderItem) {
                                    return DropdownMenuItem<String>(
                                      value: orderItem.itemId,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.28,
                                              child: Text(orderItem.itemName!),
                                            ),
                                            Text(orderItem.itemQuantity
                                                .toString()),
                                            Text(
                                                orderItem.itemPrice.toString()),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    // TODO: Implement dropdown logic
                                    // fatchCartData
                                  },
                                );
                              }
                            },
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
    );
  }
}
