import 'package:natures_delicacies/models/product.dart';

class PreviousOrders {
  String message;
  List<PrevOrders> prevOrders;

  PreviousOrders({this.message, this.prevOrders});

  PreviousOrders.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['prevOrders'] != null) {
      prevOrders = [];
      json['prevOrders'].forEach((v) {
        prevOrders.add(new PrevOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.prevOrders != null) {
      data['prevOrders'] = this.prevOrders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrevOrders {
  String status;
  String id;
  List<Products> products;
  String user;
  String timeStamp;

  PrevOrders({
    this.status,
    this.id,
    this.products,
    this.user,
    this.timeStamp,
  });

  PrevOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    user = json['user'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['user'] = this.user;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

class Products {
  int quantity;
  String id;
  Product product;

  Products({this.quantity, this.id, this.product});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    id = json['_id'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['_id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
