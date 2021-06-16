class CartItem {
  String name;
  double price;
  int quantity;
  String imgUrl;
  String unit;

  CartItem({this.name, this.price, this.quantity, this.imgUrl, this.unit});

  double get total => quantity * price;
}
