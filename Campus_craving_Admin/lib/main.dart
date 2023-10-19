import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Splash_Screen/Splash_screen.dart';
import 'bottomNavigation/Payment/Payment.dart';
import 'bottomNavigation/Sales/povaiders/salesProvaider.dart';
import 'bottomNavigation/Sales/sales.dart';
import 'bottomNavigation/bottomNavigation.dart';
import 'bottomNavigation/shopOnbording/Home/MainHome.dart';
import 'bottomNavigation/shopOnbording/Home/mainItemScreen/getShopItems/shopMainItemsProvaider.dart';
import 'bottomNavigation/shopOnbording/Home/mainItemScreen/subItemsScreen/getShopSubItems/shopSubItemProvaider.dart';
import 'bottomNavigation/shopOnbording/Home/shopDetails/shopProvaider.dart';
import 'bottomNavigation/shopOnbording/Home/widget/slider/imageProvaider/imageProvaider.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(
    // initialRoute: 'mainhome',
    debugShowCheckedModeBanner: true,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShopProvaider>(
          create: (context) => ShopProvaider(),
        ),
        ChangeNotifierProvider<ShopItemsProvaider>(
          create: (context) => ShopItemsProvaider(),
        ),
        ChangeNotifierProvider<ShopSubItemProvaider>(
          create: (context) => ShopSubItemProvaider(),
        ),
        ChangeNotifierProvider<ImageUrlProvider>(
          create: (context) => ImageUrlProvider(),
        ),
        ChangeNotifierProvider<ShopOrderProvider>(
          create: (context) => ShopOrderProvider(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        routes: {
          'Sales': (context) => Sales(),
          'BottomNav': (context) => BottomNav(),
          'ShopOnbording': (context) => ShopOnbording(),
          'Payment': (context) => Payment(),
        },
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider<MainItemProvaider>(
//         //   create: (context) => MainItemProvaider(),
//         // ),
//       ],
//       child: MaterialApp(
//         home: Sales(),
//         routes: {
//           'Sales': (context) => Sales(),
//           'ShopOnbording': (context) => ShopOnbording(),
//           'Payment': (context) => Payment(),
//         },
//       ));
// }
