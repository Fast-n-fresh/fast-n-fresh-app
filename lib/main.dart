import 'package:flutter/material.dart';
import 'package:natures_delicacies/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nature\'s Delicacies',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          buttonColor: Color(0xFFB40284A)
      ),
      home: SplashScreen(),
    );
  }
}