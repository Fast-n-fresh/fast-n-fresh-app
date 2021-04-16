import 'dart:async';

import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/onboarding.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = new Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTime = (prefs.getBool('firstTime') ?? true);
      bool loggedIn = (prefs.getBool('isLoggedIn') ?? false);
      if (loggedIn) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => UserDashboard(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                child: child,
              );
            },
          ),
        );
      } else if (firstTime == false) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => UserLoginRegister(),
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(animation),
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(animation),
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
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset(
              './lib/images/dummy_logo.png',
              gaplessPlayback: true,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
