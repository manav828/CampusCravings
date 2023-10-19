// import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/shopDetails/shopProvaider.dart';
// import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/search.dart';
// import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/selectByItem/selectByItem.dart';
// import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/shopDesign.dart';
// import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/slider/slider.dart';
// import 'package:carousel_slider/carousel_controller.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
//
// GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
//
// class ShopOnbording extends StatefulWidget {
//   const ShopOnbording({Key? key}) : super(key: key);
//
//   @override
//   State<ShopOnbording> createState() => _ShopOnbordingState();
// }
//
// class _ShopOnbordingState extends State<ShopOnbording> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       ShopProvaider subItemProvaider =
//           Provider.of<ShopProvaider>(context, listen: false);
//       // subItemProvaider.fatchShopDeatils();
//       shopProvaider?.listenToShopDetails();
//       print('fatching data main dart');
//     });
//   }
//
//   String UserName = '';
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String imageLink = '';
//
//   //for slider
//   List imageList = [
//     {'id': 1, 'image_path': 'assets/4.png'},
//     {'id': 2, 'image_path': 'assets/3.png'},
//     {'id': 3, 'image_path': 'assets/2.png'},
//   ];
//   final CarouselController carouselController = CarouselController();
//   int currentIndex = 0;
//
//   //icon slider
//   List iconsImage = [
//     'assets/pizza1.png',
//     'assets/burger.png',
//     'assets/pizza1.png',
//     'assets/burger.png',
//     'assets/pizza.png',
//     'assets/burger.png',
//   ];
//
//   ShopProvaider? shopProvaider;
//
//   @override
//   Widget build(BuildContext context) {
//     shopProvaider = Provider.of<ShopProvaider>(context);
//
//     return Scaffold(
//       backgroundColor: Color(0xfff3f5f7),
//       key: _scaffoldState,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 45.0, left: 10, right: 10, bottom: 25),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Delivery App',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Search(),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
//                 child: ImgSlider(),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//
//               SelectByItem(),
//
//               SizedBox(
//                 height: 20,
//               ),
//
//               Column(
//                 children: shopProvaider!.getShopDetails.map((e) {
//                   return ShopDesign(
//                     shopName: e.shopName,
//                     shopUrl: e.imageUrl,
//                     id: e.itemId,
//                     adminPermission: e.adminPremision,
//                   );
//                 }).toList(),
//               ),
//
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //     width: 384,
//               //     height: 290,
//               //     decoration: ShapeDecoration(
//               //         color: Colors.white,
//               //         shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.circular(24),
//               //         ),
//               //         shadows: [
//               //           BoxShadow(
//               //             color: Color(0x0C000000),
//               //             blurRadius: 20,
//               //             offset: Offset(0, 2),
//               //             spreadRadius: 0,
//               //           ),
//               //         ]),
//               //     child: Column(
//               //       children: [
//               //         Stack(
//               //           children: [
//               //             Container(
//               //               // width: 200,
//               //               height: 210,
//               //               decoration: ShapeDecoration(
//               //                 image: DecorationImage(
//               //                   image: AssetImage("assets/main.avif"),
//               //                   fit: BoxFit.fill,
//               //                 ),
//               //                 shape: RoundedRectangleBorder(
//               //                   borderRadius: BorderRadius.only(
//               //                     topRight: Radius.circular(24),
//               //                     topLeft: Radius.circular(24),
//               //                   ),
//               //                 ),
//               //               ),
//               //             ),
//               //             Align(
//               //               alignment: Alignment.centerRight,
//               //               child: Padding(
//               //                 padding: const EdgeInsets.only(right: 8.0),
//               //                 child: IconButton(
//               //                   onPressed: () {
//               //                     setState(() {
//               //
//               //                     });
//               //                   },
//               //                   icon: Icon(
//               //                     Icons.favorite_border,
//               //                     color: Colors.red,
//               //                   ),
//               //                 ),
//               //               ),
//               //             )
//               //           ],
//               //         ),
//               //         Padding(
//               //           padding: const EdgeInsets.only(top: 10.0, left: 10),
//               //           child: Align(
//               //             alignment: Alignment.centerLeft,
//               //             child: Text(
//               //               'Sultan Kacchi Biryani',
//               //               textAlign: TextAlign.left,
//               //               style: TextStyle(
//               //                 color: Color(0xFF1C1C1C),
//               //                 fontSize: 23,
//               //                 fontFamily: 'Metropolis',
//               //                 fontWeight: FontWeight.w600,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //         Padding(
//               //           padding: const EdgeInsets.only(top: 5.0, left: 10),
//               //           child: Align(
//               //             alignment: Alignment.centerLeft,
//               //             child: Text(
//               //               'Biryani, Desserts, Kacchi',
//               //               textAlign: TextAlign.center,
//               //               style: TextStyle(
//               //                 color: Color(0xFF4F4F4F),
//               //                 fontSize: 13,
//               //                 fontFamily: 'Metropolis',
//               //                 fontWeight: FontWeight.w400,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/shopDetails/shopModel.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/shopDetails/shopProvaider.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/search.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/selectByItem/selectByItem.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/shopDesign.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/widget/slider/slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ShopOnbording extends StatefulWidget {
  const ShopOnbording({Key? key}) : super(key: key);

  @override
  State<ShopOnbording> createState() => _ShopOnbordingState();
}

class _ShopOnbordingState extends State<ShopOnbording> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopProvaider subItemProvaider =
          Provider.of<ShopProvaider>(context, listen: false);
      shopProvaider?.listenToShopDetails();
      print('fetching data main dart');
    });
  }

  String UserName = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String imageLink = '';

  // For slider
  List imageList = [
    {'id': 1, 'image_path': 'assets/4.png'},
    {'id': 2, 'image_path': 'assets/3.png'},
    {'id': 3, 'image_path': 'assets/2.png'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  ShopProvaider? shopProvaider;

  bool showApproved = true;
  List<ShopModel> filteredShops = [];
  // Update the filtered shops based on the search query
  void _onSearchTextChanged(String query) {
    print(query);
    setState(() {
      filteredShops = shopProvaider!.getShopDetails
          .where((shop) =>
              shop.shopName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    shopProvaider = Provider.of<ShopProvaider>(context);

    // Filter the shop list based on adminPermission
    List<ShopModel> filteredShops = shopProvaider!.getShopDetails
        .where((shop) => shop.adminPremision == showApproved)
        .toList();

    return Scaffold(
      backgroundColor: Color(0xfff3f5f7),
      key: _scaffoldState,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 45.0, left: 10, right: 10, bottom: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delivery App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Search(
                onSearch: (query) {
                  _onSearchTextChanged(
                      query); // Call the method to filter shops based on the query
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                child: ImgSlider(),
              ),
              SizedBox(
                height: 20,
              ),
              SelectByItem(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showApproved = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: showApproved ? Colors.blue : Colors.grey,
                    ),
                    child: Text('Approved Shops'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showApproved = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: showApproved ? Colors.grey : Colors.blue,
                    ),
                    child: Text('Request Shops'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: filteredShops.map((e) {
                  return ShopDesign(
                    shopName: e.shopName,
                    shopUrl: e.imageUrl,
                    id: e.itemId,
                    adminPermission: e.adminPremision,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
