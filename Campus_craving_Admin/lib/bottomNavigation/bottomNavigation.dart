import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/MainHome.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Payment/Payment.dart';
import 'Sales/sales.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  var _pageData = [Sales(), ShopOnbording(), Payment()];
  // NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationServices.firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: _pageData[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red,
        animationDuration: Duration(microseconds: 500),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.history_outlined,
            color: Colors.white,
          )
        ],
        onTap: (index) {
          if (index >= 0 && index < _pageData.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
