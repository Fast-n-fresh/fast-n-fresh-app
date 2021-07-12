import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/admin_panel.dart';
import 'package:natures_delicacies/pages/delivery_boy_panel.dart';
import 'package:natures_delicacies/pages/login_register.dart';
import 'package:natures_delicacies/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_panel.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;

  @override
  void initState() {
    super.initState();

    timer = new Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTime = (prefs.getBool('firstTime') ?? true);
      bool isUserLoggedIn = (prefs.getBool('isLoggedIn') ?? false);
      bool isAdminLoggedIn = (prefs.getBool('isAdminLoggedIn') ?? false);
      bool isDeliveryBoyLoggedIn = (prefs.getBool('isDeliveryBoyLoggedIn') ?? false);
      if (isUserLoggedIn) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => UserPanel(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            },
          ),
        );
      } else if (isAdminLoggedIn) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AdminPanel(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            },
          ),
        );
      } else if (isDeliveryBoyLoggedIn) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DeliveryBoyPanel(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            },
          ),
        );
      } else if (firstTime == false) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LoginRegister(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Onboarding(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Container(
            height: screenWidth * 0.8,
            child: Image.asset(
              './lib/images/logo.png',
              gaplessPlayback: true,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
