import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Text(
          'Delivery Boy Panel',
        ),
      ),
    );
  }
}
