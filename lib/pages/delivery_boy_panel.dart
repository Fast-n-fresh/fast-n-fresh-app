import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/delivery_boy_page.dart';
import 'package:provider/provider.dart';

class DeliveryBoyPanel extends StatefulWidget {
  const DeliveryBoyPanel({Key key}) : super(key: key);

  @override
  _DeliveryBoyPanelState createState() => _DeliveryBoyPanelState();
}

class _DeliveryBoyPanelState extends State<DeliveryBoyPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: CurvedNavigationBar(
        items: tabs,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.easeInOut,
        index: Provider.of<DeliveryBoyPage>(context, listen: true).currentIndex,
        onTap: (val) {
          Provider.of<DeliveryBoyPage>(context, listen: false).setCurrentPage(val);
        },
        height: 75,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: Consumer<DeliveryBoyPage>(
        builder: (context, model, _) {
          return model.currentPage(model.currentIndex);
        },
      ),
    );
  }
}

List<Widget> tabs = [
  Icon(
    Icons.assignment_ind,
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
