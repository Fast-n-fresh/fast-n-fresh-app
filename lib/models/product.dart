class Product {
  String name;
  int price;
  String unit;
  String imageUrl;
  String description;
  String category;
  String id;
  int quantity = 0;

  Product({
    this.name,
    this.price,
    this.unit,
    this.imageUrl,
    this.description,
    this.category,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      unit: json['metric'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category'],
      id: json['_id'],
    );
  }

  num get total => quantity * price;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['metric'] = this.unit;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}
