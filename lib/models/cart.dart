import 'package:flutter/cupertino.dart';
import 'package:natures_delicacies/models/product.dart';

class Cart extends ChangeNotifier {
  List<Product> _products = [];

  double get getTotalPrice {
    double total = 0;
    for (int i = 0; i < _products.length; i++) {
      total += _products[i].total;
    }
    return total;
  }

  int getLength() {
    return _products.length;
  }

  List<Product> getProducts() {
    return _products;
  }

  void add(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void remove(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    for (int i = 0; i < _products.length; i++) {
      _products.removeAt(i);
    }
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _products[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_products[index].quantity > 1) {
      _products[index].quantity--;
    } else if (_products[index].quantity == 1) {
      _products.removeAt(index);
    }
    notifyListeners();
  }
}
