import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/admin_page.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: CurvedNavigationBar(
        items: tabs,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.easeInOut,
        index: Provider.of<AdminPage>(context, listen: true).currentIndex,
        onTap: (val) {
          Provider.of<AdminPage>(context, listen: false).setCurrentPage(val);
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: Consumer<AdminPage>(
        builder: (context, model, _) {
          return model.currentPage(model.currentIndex);
        },
      ),
    );
  }
}

List<Widget> tabs = [
  Icon(
    Icons.create,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.assignment_ind,
    color: Colors.grey[200],
  ),
  Icon(
    Icons.question_answer,
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
