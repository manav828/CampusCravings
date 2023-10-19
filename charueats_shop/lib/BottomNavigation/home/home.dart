// import 'dart:async';
//
// import 'package:charueats_shop/BottomNavigation/home/sub%20Items/subItemMain.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../FromFirebase/MainItems/mainItemProvaider.dart';
// import '../../shop_onbording/sharedPref.dart';
// import '../../splash_screen/splash_screen.dart';
// import 'homeSingleItem.dart';
//
// class MainHome extends StatefulWidget {
//   const MainHome({Key? key}) : super(key: key);
//
//   @override
//   State<MainHome> createState() => _MainHomeState();
// }
//
// class _MainHomeState extends State<MainHome> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // MainItemProvaider mainItemProvaider = Provider.of(context, listen: false);
//     // mainItemProvaider.fatchMainItems();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       MainItemProvaider mainItemProvaider =
//           Provider.of<MainItemProvaider>(context, listen: false);
//       mainItemProvaider.fatchMainItems();
//     });
//   }
//
//   String OwnerName = '';
//   String imageLink = '';
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   _fetch() async {
//     final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
//     print(firebaseUser);
//
//     if (firebaseUser != null) {
//       await FirebaseFirestore.instance
//           .collection('ShopData')
//           .doc(firebaseUser)
//           .get()
//           .then((ds) {
//         OwnerName = ds.get('OwnerName');
//         imageLink = ds.get('ImageUrl');
//       }).catchError((e) {
//         print(e);
//       });
//     }
//   }
//
//   //
//   // void listenToAdminPermission() {
//   //   final firebaseUser = FirebaseAuth.instance.currentUser;
//   //
//   //   if (firebaseUser == null) return;
//   //
//   //   _adminPermissionSubscription = FirebaseFirestore.instance
//   //       .collection('User Data')
//   //       .doc(firebaseUser.uid)
//   //       .snapshots()
//   //       .listen((userSnapshot) {
//   //     if (userSnapshot.exists) {
//   //       final isAdmin = userSnapshot.get('AdminPermission') == true;
//   //
//   //       // Update your UI based on the isAdmin value
//   //       setState(() {
//   //         isUserAdmin =
//   //             isAdmin; // Assuming isUserAdmin is a boolean variable in your class
//   //       });
//   //     }
//   //   });
//   // }
//   //
//   // bool isShopOpen = false; // Initialize the shop status as open
//   // // Function to update the shop status in Firestore
//   // void _updateShopStatus(bool newStatus) async {
//   //   final firebaseUser = FirebaseAuth.instance.currentUser;
//   //   if (firebaseUser != null) {
//   //     final shopDoc = FirebaseFirestore.instance
//   //         .collection('ShopData')
//   //         .doc(firebaseUser.uid);
//   //     await shopDoc.update({'isShopOpen': newStatus});
//   //     setState(() {
//   //       isShopOpen = newStatus;
//   //     });
//   //   }
//   // }
//
//   bool isShopOpen = false; // Initialize the shop status as closed
//   bool isAdmin = false; // Initialize the admin status as false
//   StreamSubscription<DocumentSnapshot>? _adminPermissionSubscription;
//
// // Function to update the shop status in Firestore
//   void _updateShopStatus(bool newStatus) async {
//     listenToAdminPermission();
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//
//     if (firebaseUser != null && isAdmin) {
//       final shopDoc = FirebaseFirestore.instance
//           .collection('ShopData')
//           .doc(firebaseUser.uid);
//       await shopDoc.update({'isShopOpen': newStatus});
//       setState(() {
//         isShopOpen = newStatus;
//       });
//     } else {
//       // Handle the case where the user is not an admin or not logged in
//       print('User is not an admin or not logged in.');
//     }
//   }
//
// // Function to listen to changes in AdminPermission
//   void listenToAdminPermission() {
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//
//     if (firebaseUser == null) return;
//
//     _adminPermissionSubscription = FirebaseFirestore.instance
//         .collection('User Data')
//         .doc(firebaseUser.uid)
//         .snapshots()
//         .listen((userSnapshot) {
//       if (userSnapshot.exists) {
//         final userData = userSnapshot.data() as Map<String, dynamic>;
//         final isAdmin = userData['AdminPermission'] == true;
//
//         // Update your UI based on the isAdmin value
//         setState(() {
//           isAdmin; // Update your UI or set the isAdmin state variable here
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _adminPermissionSubscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: ListView(
//           // Remove padding
//           padding: EdgeInsets.zero,
//
//           children: [
//             FutureBuilder(
//               future: _fetch(),
//               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                 return UserAccountsDrawerHeader(
//                   accountName: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(OwnerName.toString()),
//                       SizedBox(
//                           width:
//                               10), // Add some spacing between the name and toggle button
//                       Padding(
//                         padding: const EdgeInsets.only(right: 10.0),
//                         child: Transform.scale(
//                           scale:
//                               1.5, // Adjust the scale factor to increase the size
//                           child: Switch(
//                             value: isShopOpen,
//                             onChanged: (newValue) {
//                               _updateShopStatus(newValue);
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // accountEmail: Text(phoneNumber.toString()),
//                   currentAccountPicture: CircleAvatar(
//                     child: ClipOval(
//                       child: Image.network(
//                         imageLink,
//                         fit: BoxFit.cover,
//                         width: 90,
//                         height: 90,
//                       ),
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(
//                             'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
//                   ),
//                   accountEmail: null,
//                 );
//               },
//               // child:
//             ),
//
//             ListTile(
//               leading: Icon(Icons.heart_broken_sharp),
//               // leading: Icon(Icons.favorite),
//               title: Text('Favorites'),
//               onTap: () => null,
//             ),
//             ListTile(
//               leading: Icon(Icons.history_edu_outlined),
//               title: Text('History'),
//               onTap: () => null,
//             ),
//             // ListTile(
//             //   leading: Icon(Icons.share),
//             //   title: Text('Share'),
//             //   onTap: () => null,
//             // ),
//             // ListTile(
//             //   leading: Icon(Icons.notifications),
//             //   title: Text('Request'),
//             // ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () => null,
//             ),
//             ListTile(
//               leading: Icon(Icons.document_scanner),
//               title: Text('Policies'),
//               onTap: () => null,
//             ),
//             Divider(),
//             ListTile(
//               title: Text('Exit'),
//               leading: Icon(Icons.logout),
//               onTap: () async {
//                 _auth.signOut();
//                 await FirebaseAuth.instance.signOut();
//                 await SharedPreferencesHelper.setLoggedIn(false);
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => SplashScreen()),
//                   (route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: Text("Home"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 Navigator.pushNamed(context, 'addItem');
//               },
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: IconButton(
//           //     icon: Icon(Icons.delete_outline),
//           //     onPressed: () async {
//           //       await FirebaseAuth.instance.signOut();
//           //       await SharedPreferencesHelper.setLoggedIn(false);
//           //       Navigator.pushAndRemoveUntil(
//           //         context,
//           //         MaterialPageRoute(builder: (context) => SplashScreen()),
//           //         (route) => false,
//           //       );
//           //       // Navigator.pushNamed(context, 'addItem');
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: Consumer<MainItemProvaider>(
//           builder: (context, mainItemProvaider, child) {
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 11,
//                 mainAxisSpacing: 11,
//               ), // Total number of items
//               itemBuilder: (context, index) {
//                 return HomeSingleItem(
//                   imageUrl: mainItemProvaider.getMainItemsList[index].imageUrl,
//                   MainItemName:
//                       mainItemProvaider.getMainItemsList[index].itemName,
//                   itemId: mainItemProvaider.getMainItemsList[index].itemId,
//                   onDelete: () {
//                     mainItemProvaider.deleteMainItem(
//                         mainItemProvaider.getMainItemsList[index].itemId!);
//                   },
//                 );
//               },
//               itemCount: mainItemProvaider.getMainItemsList.length,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:charueats_shop/BottomNavigation/home/sub%20Items/subItemMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../FromFirebase/MainItems/mainItemProvaider.dart';
import '../../shop_onbording/sharedPref.dart';
import '../../splash_screen/splash_screen.dart';
import 'addItem.dart';
import 'homeSingleItem.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      MainItemProvaider mainItemProvaider =
          Provider.of<MainItemProvaider>(context, listen: false);
      mainItemProvaider.fatchMainItems();
    });
    listenToAdminPermission();
  }

  String OwnerName = '';
  String shopName = '';
  String imageLink = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  _fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    print(firebaseUser);

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        shopName = ds.get('ShopName');
        OwnerName = ds.get('OwnerName');
        imageLink = ds.get('ImageUrl');
      }).catchError((e) {
        print(e);
      });
    }
  }

  bool isShopOpen = false;
  bool? adminPermission;
  StreamSubscription<DocumentSnapshot>? _adminPermissionSubscription;

  void _updateShopStatus(bool newStatus) async {
    listenToAdminPermission();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    print(adminPermission);
    if (firebaseUser != null) {
      if (adminPermission!) {
        final shopDoc = FirebaseFirestore.instance
            .collection('ShopData')
            .doc(firebaseUser.uid);
        await shopDoc.update({'isShopOpen': newStatus});
        setState(() {
          isShopOpen = newStatus;
        });
      }
    } else {
      // Handle the case where user is not logged in
      print('User is not logged in.');
    }
  }

  void listenToAdminPermission() {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return;

    _adminPermissionSubscription = FirebaseFirestore.instance
        .collection('ShopData')
        .doc(firebaseUser.uid)
        .snapshots()
        .listen((userSnapshot) {
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        adminPermission = userData['AdminPermission'] == true;

        print(adminPermission);
        // Update your UI based on adminPermission
        setState(() {
          adminPermission; // Update your UI or set the adminPermission state variable here
        });
      }
    });
  }

  void _showAdminApprovalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Admin Approval Required'),
          content: Text(
            'Your request cannot be processed because you do not have admin approval. Please wait for approval.',
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _adminPermissionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(OwnerName.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Transform.scale(
                          scale: 1.5,
                          child: Switch(
                            value: isShopOpen,
                            onChanged: (newValue) {
                              if (adminPermission!) {
                                _updateShopStatus(newValue);
                              } else {
                                _showAdminApprovalDialog(); // Show a dialog when admin permission is false
                              }
                            }, // Disable switch if adminPermission is false
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                      ),
                    ),
                  ),
                  accountEmail: null,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.heart_broken_sharp),
              title: Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.history_edu_outlined),
              title: Text('History'),
              onTap: () => null,
            ),
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                // await _fetch();
                Navigator.pushNamed(context, 'addItem');
              },
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Consumer<MainItemProvaider>(
          builder: (context, mainItemProvaider, child) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
              ),
              itemBuilder: (context, index) {
                return HomeSingleItem(
                  imageUrl: mainItemProvaider.getMainItemsList[index].imageUrl,
                  MainItemName:
                      mainItemProvaider.getMainItemsList[index].itemName,
                  itemId: mainItemProvaider.getMainItemsList[index].itemId,
                  onDelete: () {
                    mainItemProvaider.deleteMainItem(
                        mainItemProvaider.getMainItemsList[index].itemId!);
                  },
                );
              },
              itemCount: mainItemProvaider.getMainItemsList.length,
            );
          },
        ),
      ),
    );
  }
}
