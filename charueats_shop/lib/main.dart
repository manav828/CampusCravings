import 'package:charueats_shop/provaider/ForUser/user_provaider.dart';
import 'package:charueats_shop/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomNavigation/bottomNav.dart';
import 'BottomNavigation/history/getHistory/historyProvaider.dart';
import 'BottomNavigation/home/addItem.dart';
import 'BottomNavigation/home/home.dart';

import 'BottomNavigation/orders/OrderStatus/orderProvaider.dart';
import 'FromFirebase/MainItems/mainItemProvaider.dart';
import 'FromFirebase/SubItems/subItemProvaider.dart';
import 'Notification/notificationServices.dart';
import 'shop_onbording/phone.dart';
import 'shop_onbording/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(
    // initialRoute: 'mainhome',
    debugShowCheckedModeBanner: true,
    home: MyApp(),
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MainItemProvaider>(
            create: (context) => MainItemProvaider(),
          ),
          ChangeNotifierProvider<UserProvaider>(
            create: (context) => UserProvaider(),
          ),
          ChangeNotifierProvider<SubItemProvaider>(
            create: (context) => SubItemProvaider(),
          ),
          ChangeNotifierProvider<OrderProvaider>(
            create: (context) => OrderProvaider(),
          ),
          ChangeNotifierProvider<HistoryProvaider>(
            create: (context) => HistoryProvaider(),
          ),
        ],
        child: MaterialApp(
          home: SplashScreen(),
          routes: {
            'phone': (context) => MyPhone(),
            'verify': (context) => MyVerify(),
            'bottomNav': (context) => mainHomePageDesign(),
            'mainhome': (context) => MainHome(),
            'splashScreen': (context) => SplashScreen(),
            'addItem': (context) => AddItem(),
          },
        ));
  }
}
