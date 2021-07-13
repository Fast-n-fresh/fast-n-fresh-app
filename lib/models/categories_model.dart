class CategoriesModel {
  String name;
  String imageUrl;
  String id;

  CategoriesModel({this.id, this.name, this.imageUrl});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
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
