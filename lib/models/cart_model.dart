import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/models/cart_item.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  double get getTotalPrice {
    double total = 0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].total;
    }
    return total;
  }

  void add(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
