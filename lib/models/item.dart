class Item {
  String name;
  double price;
  int quantity;

  Item({this.name, this.price, this.quantity});

  double get total => quantity * price;
}