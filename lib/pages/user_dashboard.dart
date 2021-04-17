import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/page_model.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String name;
  Random random = new Random();

  SharedPreferences prefs;

  void setupDetails() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    name = name.substring(0, name.indexOf(' '));
    Provider.of<UserProfileModel>(context, listen: false).setName(name);
  }

  @override
  void initState() {
    super.initState();
    setupDetails();
  }

  @override
  Widget build(BuildContext context) {
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
        index: Provider.of<PageModel>(context, listen: true).currentIndex,
        onTap: (val) {
          Provider.of<PageModel>(context, listen: false).setCurrentPage(val);
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: Consumer<PageModel>(
        builder: (context, model, _) {
          return model.currentPage(model.currentIndex);
        },
      ),
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
