import 'package:flutter/material.dart';

class AssignedOrders extends StatefulWidget {
  const AssignedOrders({Key key}) : super(key: key);

  @override
  _AssignedOrdersState createState() => _AssignedOrdersState();
}

class _AssignedOrdersState extends State<AssignedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text('Assigned Orders'),
      ),
    );
  }
}
