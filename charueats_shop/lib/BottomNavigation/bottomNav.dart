import 'package:charueats_shop/BottomNavigation/statatics/statistics.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../Notification/notificationServices.dart';
import 'history/history.dart';
import 'home/home.dart';
import 'orders/orders.dart';

class mainHomePageDesign extends StatefulWidget {
  @override
  State<mainHomePageDesign> createState() => _State();
}

class _State extends State<mainHomePageDesign> {
  int _currentIndex = 0;
  var _pageData = [MainHome(), OrderDeatils(), ShopOrderHistoryScreen()];
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: _pageData[_currentIndex],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.grey,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       // icon: Icon(Icons.home),
      //       backgroundColor: Colors.white,
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag_outlined),
      //       label: 'Order',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart_outlined),
      //       label: 'Statistics',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history_outlined),
      //       label: 'History',
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       print(index);
      //       _currentIndex = index;
      //       // print(_currentIndex);
      //     });
      //   },
      // ),
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
