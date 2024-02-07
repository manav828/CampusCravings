import 'package:charueats_delivery/splash_screen/splash_screen.dart';
import 'package:charueats_delivery/user_onbording/number_auth.dart';
import 'package:charueats_delivery/user_onbording/number_verify.dart';
import 'package:charueats_delivery/user_onbording/user_provaider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BottomNavigation/Cart/cartList/cartProvaider.dart';
import 'BottomNavigation/Home/MainHome.dart';
import 'BottomNavigation/Home/mainItemScreen/getShopItems/shopMainItemsProvaider.dart';
import 'BottomNavigation/Home/mainItemScreen/subItemsScreen/getShopSubItems/shopSubItemProvaider.dart';
import 'BottomNavigation/Home/widget/slider/sliderProvaider.dart';
import 'BottomNavigation/Order/OrderStatus/orderProvaider.dart';
import 'BottomNavigation/history/getHistory/historyProvaider.dart';
import 'firebase/shopDetails/shopProvaider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
          // ChangeNotifierProvider<MainItemProvaider>(
          //   create: (context) => MainItemProvaider(),
          // ),
          ChangeNotifierProvider<UserProvaider>(
            create: (context) => UserProvaider(),
          ),
          ChangeNotifierProvider<ShopProvaider>(
            create: (context) => ShopProvaider(),
          ),
          ChangeNotifierProvider<ShopItemsProvaider>(
            create: (context) => ShopItemsProvaider(),
          ),
          ChangeNotifierProvider<ShopSubItemProvaider>(
            create: (context) => ShopSubItemProvaider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider<OrderProvaider>(
            create: (context) => OrderProvaider(),
          ),
          ChangeNotifierProvider<SliderProvaider>(
            create: (context) => SliderProvaider(),
          ),
          ChangeNotifierProvider<HistoryProvaider>(
            create: (context) => HistoryProvaider(),
          ),
        ],
        child: MaterialApp(
          home: SplashScreen(),
          routes: {
            'phone': (context) => Number_Auth(),
            'verify': (context) => Number_verify(),
            // 'bottomNav': (context) => BottomNav(),
            'mainhome': (context) => MainHome(),
            'splashScreen': (context) => SplashScreen(),
          },
        ));
  }
}
