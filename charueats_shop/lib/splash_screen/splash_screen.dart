import 'package:charueats_shop/Notification/notificationServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../BottomNavigation/bottomNav.dart';
import '../BottomNavigation/home/home.dart';
import '../shop_onbording/phone.dart';
import '../shop_onbording/sharedPref.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  NotificationServices notificationServices = NotificationServices();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();

    _animationController.forward().whenComplete(() async {
      bool isLoggedIn = await SharedPreferencesHelper.isLoggedIn;
      if (isLoggedIn == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => mainHomePageDesign()),
        );
      } else {
        notificationServices.requestNotificationServices();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MyPhone()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
          width: _animation.value * 40000, // Adjust the end width as needed
          height: _animation.value * 40000, // Adjust the end height as needed
          child: Image.asset('assets/logo1.png'),
        ),
      ),
    );
  }
}
