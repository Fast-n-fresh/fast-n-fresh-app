import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/pages/widgets/home_page.dart';
import 'package:natures_delicacies/pages/widgets/my_cart.dart';
import 'package:natures_delicacies/pages/widgets/orders.dart';
import 'package:natures_delicacies/pages/widgets/user_profile.dart';

class PageModel extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    HomePage(),
    Orders(),
    MyCart(),
    UserProfile(),
  ];

  void setCurrentPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget currentPage(int index) {
    return pages[index];
  }
}
