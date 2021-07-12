import 'package:flutter/material.dart';

class AssignOrders extends StatefulWidget {
  const AssignOrders({Key key}) : super(key: key);

  @override
  _AssignOrdersState createState() => _AssignOrdersState();
}

class _AssignOrdersState extends State<AssignOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text("Assign Orders"),
      ),
    );
  }
}
