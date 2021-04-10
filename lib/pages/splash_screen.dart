import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/onboarding.dart';
import 'package:natures_delicacies/pages/user_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTime = prefs.getBool('firstTime');
      if (firstTime == false) {
        Navigator.pushReplacement(
            context,
            PageTransition(
              child: UserLogin(),
              type: PageTransitionType.bottomToTop,
            ));
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: Onboarding(),
            type: PageTransitionType.bottomToTop,
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
