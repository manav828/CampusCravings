import 'package:charueats_delivery/BottomNavigation/Home/widget/search.dart';
import 'package:charueats_delivery/BottomNavigation/Home/widget/selectByItem.dart';
import 'package:charueats_delivery/BottomNavigation/Home/widget/shopDesign.dart';
import 'package:charueats_delivery/BottomNavigation/Home/widget/slider/slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../firebase/shopDetails/shopProvaider.dart';
import '../../firebase/shopDetails/shopProvaider.dart';
import '../../splash_screen/splash_screen.dart';
import '../../user_onbording/login_check.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopProvaider subItemProvaider =
          Provider.of<ShopProvaider>(context, listen: false);
      // subItemProvaider.fatchShopDeatils();
      shopProvaider?.listenToShopDetails();
      print('fatching data main dart');
    });
  }

  String UserName = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String imageLink = '';

  _fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    print(firebaseUser);

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User Data')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        UserName = ds.get('UserName');
        imageLink = ds.get('ImageUrl');
      }).catchError((e) {
        print(e);
      });
    }
  }

  //for slider
  List imageList = [
    {'id': 1, 'image_path': 'assets/4.png'},
    {'id': 2, 'image_path': 'assets/3.png'},
    {'id': 3, 'image_path': 'assets/2.png'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  //icon slider
  List iconsImage = [
    'assets/pizza1.png',
    'assets/burger.png',
    'assets/pizza1.png',
    'assets/burger.png',
    'assets/pizza.png',
    'assets/burger.png',
  ];
  // final List<IconData> icons = [
  //   Icons.ac_unit,
  //   Icons.access_alarm,
  //   Icons.accessibility,
  //   Icons.account_balance,
  //   Icons.account_box,
  //   Icons.account_circle,
  //   Icons.adb,
  //   Icons.add,
  //   Icons.add_alarm,
  //   Icons.add_alert,
  //   Icons.add_box,
  //   Icons.add_circle,
  //   Icons.add_location,
  //   Icons.add_photo_alternate,
  //   Icons.airplanemode_active,
  // ];
  ShopProvaider? shopProvaider;

  @override
  Widget build(BuildContext context) {
    shopProvaider = Provider.of<ShopProvaider>(context);

    return Scaffold(
      backgroundColor: Color(0xfff3f5f7),
      key: _scaffoldState,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,

          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: Text(UserName.toString()),
                  // accountEmail: Text(phoneNumber.toString()),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                  accountEmail: null,
                );
              },
              // child:
            ),

            ListTile(
              leading: Icon(Icons.heart_broken_sharp),
              // leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.history_edu_outlined),
              title: Text('History'),
              onTap: () => null,
            ),
            // ListTile(
            //   leading: Icon(Icons.share),
            //   title: Text('Share'),
            //   onTap: () => null,
            // ),
            // ListTile(
            //   leading: Icon(Icons.notifications),
            //   title: Text('Request'),
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.document_scanner),
              title: Text('Policies'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.logout),
              onTap: () async {
                _auth.signOut();
                await FirebaseAuth.instance.signOut();
                await SharedPreferencesHelper.setLoggedIn(false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldState.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xFFF1414F),
                      ),
                    ),
                    Text(
                      'Delivery App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    FutureBuilder(
                      future: _fetch(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              // color: _isClicked ? Colors.green : Colors.transparent,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                imageLink,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Search(),
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

              Column(
                children: shopProvaider!.getShopDetails.map((e) {
                  return ShopDesign(
                    shopName: e.shopName,
                    shopUrl: e.imageUrl,
                    id: e.itemId,
                  );
                }).toList(),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: 384,
              //     height: 290,
              //     decoration: ShapeDecoration(
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(24),
              //         ),
              //         shadows: [
              //           BoxShadow(
              //             color: Color(0x0C000000),
              //             blurRadius: 20,
              //             offset: Offset(0, 2),
              //             spreadRadius: 0,
              //           ),
              //         ]),
              //     child: Column(
              //       children: [
              //         Stack(
              //           children: [
              //             Container(
              //               // width: 200,
              //               height: 210,
              //               decoration: ShapeDecoration(
              //                 image: DecorationImage(
              //                   image: AssetImage("assets/main.avif"),
              //                   fit: BoxFit.fill,
              //                 ),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(24),
              //                     topLeft: Radius.circular(24),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Align(
              //               alignment: Alignment.centerRight,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(right: 8.0),
              //                 child: IconButton(
              //                   onPressed: () {
              //                     setState(() {
              //
              //                     });
              //                   },
              //                   icon: Icon(
              //                     Icons.favorite_border,
              //                     color: Colors.red,
              //                   ),
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 10.0, left: 10),
              //           child: Align(
              //             alignment: Alignment.centerLeft,
              //             child: Text(
              //               'Sultan Kacchi Biryani',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(
              //                 color: Color(0xFF1C1C1C),
              //                 fontSize: 23,
              //                 fontFamily: 'Metropolis',
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 5.0, left: 10),
              //           child: Align(
              //             alignment: Alignment.centerLeft,
              //             child: Text(
              //               'Biryani, Desserts, Kacchi',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 color: Color(0xFF4F4F4F),
              //                 fontSize: 13,
              //                 fontFamily: 'Metropolis',
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
