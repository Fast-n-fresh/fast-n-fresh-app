import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/pages/admin_tabs/admin_settings.dart';
import 'package:natures_delicacies/pages/admin_tabs/assign_orders.dart';
import 'package:natures_delicacies/pages/admin_tabs/create_products.dart';
import 'package:natures_delicacies/pages/admin_tabs/feedbacks.dart';

class AdminPage extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    CreateProducts(),
    AssignOrders(),
    Feedbacks(),
    AdminSettings(),
  ];

  void setCurrentPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget currentPage(int index) {
    return pages[index];
  }
}