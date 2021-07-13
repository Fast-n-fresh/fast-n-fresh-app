import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key key}) : super(key: key);

  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text("Settings"),
      ),
    );
  }
}
