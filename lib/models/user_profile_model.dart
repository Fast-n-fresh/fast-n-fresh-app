import 'package:flutter/cupertino.dart';

class UserProfileModel extends ChangeNotifier {
  String name;

  void setName(String name){
    this.name = name;
    notifyListeners();
  }
}