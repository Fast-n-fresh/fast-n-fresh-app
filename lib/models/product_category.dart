class ProductCategory {
  String name;
  String imageUrl;
  String id;

  ProductCategory({this.id, this.name, this.imageUrl});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['name'],
      imageUrl: json['imageUrl'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['_id'] = this.id;
    return data;
  }
}
