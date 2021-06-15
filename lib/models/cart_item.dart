class CartItem {
  String name;
  double price;
  int quantity;
  String imgUrl;

  CartItem({this.name, this.price, this.quantity, this.imgUrl});

  double get total => quantity * price;
}
