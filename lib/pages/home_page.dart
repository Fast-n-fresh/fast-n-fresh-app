import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.logout),
          onPressed: () async {
            prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', false);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UserLoginRegister(),
                ));
          },
        ),
        body: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
