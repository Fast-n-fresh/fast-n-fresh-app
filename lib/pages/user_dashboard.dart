import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
import 'package:natures_delicacies/pages/widgets/home_page.dart';
import 'package:natures_delicacies/pages/widgets/my_cart.dart';
import 'package:natures_delicacies/pages/widgets/orders.dart';
import 'package:natures_delicacies/pages/widgets/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String name;
  Random random = new Random();

  SharedPreferences prefs;
  int _currentTab;

  void setupDetails() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    name = name.substring(0, name.indexOf(' '));
  }

  @override
  void initState() {
    super.initState();
    _currentTab = 0;
    setupDetails();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(
        name: name,
      ),
      Orders(),
      MyCart(),
      UserProfile(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () async {
          prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => UserLoginRegister(),
            ),
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: tabs,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.easeInOut,
        index: _currentTab,
        onTap: (val) {
          setState(() {
            _currentTab = val;
          });
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: pages[_currentTab],
    );
  }
}

List<Widget> tabs = [
  Icon(
    Icons.home_outlined,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.shopping_bag_outlined,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.shopping_cart_outlined,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.person_outline,
    color: Colors.grey[200],
  ),
];
