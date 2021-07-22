import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/pages/delivery_boy_tabs/assigned_orders.dart';
import 'package:natures_delicacies/pages/delivery_boy_tabs/delivery_boy_settings.dart';
import 'package:natures_delicacies/pages/delivery_boy_tabs/delivery_status.dart';

class DeliveryBoyPage extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    AssignedOrders(),
    DeliveryStatus(),
    DeliveryBoySettings(),
  ];

  void setCurrentPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget currentPage(int index) {
    return pages[index];
  }
}
