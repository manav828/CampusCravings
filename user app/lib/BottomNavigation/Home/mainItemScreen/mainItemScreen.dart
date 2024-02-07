import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'getShopItems/shopMainItemsProvaider.dart';
import 'gridShopPage.dart';

class MainItemScreen extends StatefulWidget {
  // const MainItemScreen({Key? key}) : super(key: key);
  MainItemScreen({this.shopName, this.shopId, this.shopUrl});
  String? shopName;
  String? shopId;
  String? shopUrl;
  @override
  State<MainItemScreen> createState() => _MainItemScreenState();
}

class _MainItemScreenState extends State<MainItemScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopItemsProvaider shopItemsProvaider =
          Provider.of<ShopItemsProvaider>(context, listen: false);
      print('called items');
      // shopItemsProvaider.fatchMainItems(widget.shopId!);
      shopItemsProvaider.listenToShopMainDetails(widget.shopId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f5f7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: Color(0xFFF1414F),
                    ),
                  ),
                  Text(
                    widget.shopName!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                          // color: Color(0xFFF1414F),
                          // width: 2.0,
                          ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.shopUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Consumer<ShopItemsProvaider>(
                builder: (context, shopItemsProvaider, child) {
                  return Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        return GridShopPage(
                          mainItemImage: shopItemsProvaider
                              .getShopItemsList[index].mainImageUrl,
                          mainItemName: shopItemsProvaider
                              .getShopItemsList[index].mainItemName,
                          mainItemId: shopItemsProvaider
                              .getShopItemsList[index].mainItemId,
                          shopName: widget.shopName,
                          shopId: widget.shopId,
                        );
                      },
                      itemCount: shopItemsProvaider.getShopItemsList.length,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'getShopItems/shopMainItemsProvaider.dart';
// import 'gridShopPage.dart';
//
// class MainItemScreen extends StatefulWidget {
//   MainItemScreen({this.shopName, this.shopId, this.shopUrl});
//   String? shopName;
//   String? shopId;
//   String? shopUrl;
//   @override
//   State<MainItemScreen> createState() => _MainItemScreenState();
// }
//
// class _MainItemScreenState extends State<MainItemScreen> {
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       ShopItemsProvaider shopItemsProvaider =
//           Provider.of<ShopItemsProvaider>(context, listen: false);
//       print('called items');
//       shopItemsProvaider.listenToShopMainDetails(widget.shopId!);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff3f5f7),
//       appBar: AppBar(
//         title: Text(widget.shopName!),
//       ),
//       body: Column(
//         children: [
//           // Your existing content here
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Consumer<ShopItemsProvaider>(
//                 builder: (context, shopItemsProvaider, child) {
//                   return Container(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 15,
//                         mainAxisSpacing: 15,
//                         childAspectRatio: 0.9,
//                       ),
//                       itemBuilder: (context, index) {
//                         return GridShopPage(
//                           mainItemImage: shopItemsProvaider
//                               .getShopItemsList[index].mainImageUrl,
//                           mainItemName: shopItemsProvaider
//                               .getShopItemsList[index].mainItemName,
//                           mainItemId: shopItemsProvaider
//                               .getShopItemsList[index].mainItemId,
//                           shopName: widget.shopName,
//                           shopId: widget.shopId,
//                         );
//                       },
//                       itemCount: shopItemsProvaider.getShopItemsList.length,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag_outlined),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart_outlined),
//             label: 'Orders',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history_outlined),
//             label: 'History',
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../Cart/cart.dart';
// import '../../Order/orders.dart';
// import '../../history/history.dart';
// import 'getShopItems/shopMainItemsProvaider.dart';
// import 'gridShopPage.dart';
//
// class MainItemScreen extends StatefulWidget {
//   // const MainItemScreen({Key? key}) : super(key: key);
//   MainItemScreen({this.shopName, this.shopId, this.shopUrl});
//   String? shopName;
//   String? shopId;
//   String? shopUrl;
//   @override
//   State<MainItemScreen> createState() => _MainItemScreenState();
// }
//
// class _MainItemScreenState extends State<MainItemScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       ShopItemsProvaider shopItemsProvaider =
//           Provider.of<ShopItemsProvaider>(context, listen: false);
//       print('called items');
//       // shopItemsProvaider.fatchMainItems(widget.shopId!);
//       shopItemsProvaider.listenToShopMainDetails(widget.shopId!);
//     });
//   }
//
//   Widget buildMainContent(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.keyboard_arrow_left_sharp,
//                   color: Color(0xFFF1414F),
//                 ),
//               ),
//               Text(
//                 widget.shopName!,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(100)),
//                   border: Border.all(
//                       // color: Color(0xFFF1414F),
//                       // width: 2.0,
//                       ),
//                 ),
//                 child: ClipOval(
//                   child: Image.network(
//                     widget.shopUrl!,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Consumer<ShopItemsProvaider>(
//               builder: (context, shopItemsProvaider, child) {
//                 return Container(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 15,
//                       mainAxisSpacing: 15,
//                       childAspectRatio: 0.9,
//                     ),
//                     itemBuilder: (context, index) {
//                       return GridShopPage(
//                         mainItemImage: shopItemsProvaider
//                             .getShopItemsList[index].mainImageUrl,
//                         mainItemName: shopItemsProvaider
//                             .getShopItemsList[index].mainItemName,
//                         mainItemId: shopItemsProvaider
//                             .getShopItemsList[index].mainItemId,
//                         shopName: widget.shopName,
//                         shopId: widget.shopId,
//                       );
//                     },
//                     itemCount: shopItemsProvaider.getShopItemsList.length,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   int _currentIndex = 0;
//   // Initialize _pageData as an empty list
//   var _pageData = [];
//
//   // Constructor
//   _MainItemScreenState() {
//     // Initialize _pageData here, after the constructor has been called
//     _pageData = [
//       buildMainContent(context),
//       CartScreen(),
//       OrderDeatils(),
//       UserOrderHistory(),
//     ];
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff3f5f7),
//       body: _pageData[_currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.white,
//         color: Colors.red,
//         animationDuration: Duration(milliseconds: 300),
//         items: [
//           Icon(
//             Icons.home,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.shopping_bag_outlined,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.bar_chart_outlined,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.history_outlined,
//             color: Colors.white,
//           )
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
