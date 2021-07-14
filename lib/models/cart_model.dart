import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/models/product.dart';

class CartModel extends ChangeNotifier {
  List<Product> _items = [];

  double get getTotalPrice {
    double total = 0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].total;
    }
    return total;
  }

  int getLength() {
    return _items.length;
  }

  List<Product> getItems() {
    return _items;
  }

  void add(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else if (_items[index].quantity == 1) {
      _items.removeAt(index);
    }
    notifyListeners();
  }
}
