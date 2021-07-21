import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/pages/admin_tabs/admin_feedbacks.dart';
import 'package:natures_delicacies/pages/admin_tabs/admin_settings.dart';
import 'package:natures_delicacies/pages/admin_tabs/assign_orders.dart';
import 'package:natures_delicacies/pages/admin_tabs/create_entitites.dart';
import 'package:natures_delicacies/pages/admin_tabs/pending_deliveries.dart';

class AdminPage extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    CreateEntities(),
    AssignOrders(),
    AdminFeedbacks(),
    PendingDeliveries(),
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
