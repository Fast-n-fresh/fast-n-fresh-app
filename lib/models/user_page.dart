import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/pages/user_tabs/home_page.dart';
import 'package:natures_delicacies/pages/user_tabs/my_cart.dart';
import 'package:natures_delicacies/pages/user_tabs/orders.dart';
import 'package:natures_delicacies/pages/user_tabs/user_settings.dart';

class UserPage extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    HomePage(),
    Orders(),
    MyCart(),
    UserSettings(),
  ];

  void setCurrentPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget currentPage(int index) {
    return pages[index];
  }
}
