import 'package:flutter/material.dart';

class DeliveryboySettings extends StatefulWidget {
  const DeliveryboySettings({Key key}) : super(key: key);

  @override
  _DeliveryboySettingsState createState() => _DeliveryboySettingsState();
}

class _DeliveryboySettingsState extends State<DeliveryboySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text('Settings'),
      ),
    );
  }
}
