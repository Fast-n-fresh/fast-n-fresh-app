import 'package:flutter/material.dart';

class DeliveryStatus extends StatefulWidget {
  const DeliveryStatus({Key key}) : super(key: key);

  @override
  _DeliveryStatusState createState() => _DeliveryStatusState();
}

class _DeliveryStatusState extends State<DeliveryStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text('Delivery Status'),
      ),
    );
  }
}
