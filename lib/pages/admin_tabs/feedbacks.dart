import 'package:flutter/material.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key key}) : super(key: key);

  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Text("Feedbacks"),
      ),
    );
  }
}
