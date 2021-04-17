import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/models/item.dart';

class CartModel extends ChangeNotifier {
  List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get getTotalPrice {
    double total = 0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].total;
    }
    return total;
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
