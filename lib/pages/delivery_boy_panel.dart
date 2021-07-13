import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/delivery_boy_page_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_register.dart';

class DeliveryBoyPanel extends StatefulWidget {
  const DeliveryBoyPanel({Key key}) : super(key: key);

  @override
  _DeliveryBoyPanelState createState() => _DeliveryBoyPanelState();
}

class _DeliveryBoyPanelState extends State<DeliveryBoyPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isDeliveryBoyLoggedIn', false);
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
      bottomNavigationBar: CurvedNavigationBar(
        items: tabs,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.easeInOut,
        index: Provider.of<DeliveryBoyPageModel>(context, listen: true).currentIndex,
        onTap: (val) {
          Provider.of<DeliveryBoyPageModel>(context, listen: false).setCurrentPage(val);
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: Consumer<DeliveryBoyPageModel>(
        builder: (context, model, _) {
          return model.currentPage(model.currentIndex);
        },
      ),
    );
  }
}

List<Widget> tabs = [
  Icon(
    Icons.assignment_ind,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.delivery_dining,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.settings,
    color: Colors.grey[200],
  ),
];
