class ProductModel {
  String name;
  int price;
  String unit;
  String imageUrl;
  String description;
  String category;

  ProductModel({
    this.name,
    this.price,
    this.unit,
    this.imageUrl,
    this.description,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      unit: json['metric'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category'],
    );
  }

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
