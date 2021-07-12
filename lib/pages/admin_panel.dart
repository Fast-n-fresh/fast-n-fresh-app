import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/admin_page_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_register.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: CurvedNavigationBar(
        items: tabs,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.easeInOut,
        index: Provider.of<AdminPageModel>(context, listen: true).currentIndex,
        onTap: (val) {
          Provider.of<AdminPageModel>(context, listen: false).setCurrentPage(val);
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isAdminLoggedIn', false);
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => LoginRegister(),
              transitionDuration: Duration(milliseconds: 500),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                return SlideTransition(
                  position:
                      Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        child: Icon(Icons.exit_to_app),
      ),
      body: Consumer<AdminPageModel>(
        builder: (context, model, _) {
          return model.currentPage(model.currentIndex);
        },
      ),
    );
  }
}

List<Widget> tabs = [
  Icon(
    Icons.create,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.assignment_ind,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.question_answer,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.settings,
    color: Colors.grey[200],
  ),
];
