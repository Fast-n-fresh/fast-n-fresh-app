import 'package:natures_delicacies/models/product.dart';

class AssignedOrdersList {
  String message;
  List<Orders> orders;

  AssignedOrdersList({this.message, this.orders});

  AssignedOrdersList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String status;
  String id;
  List<Products> products;
  String user;
  String timeStamp;
  String deliveryBoy;

  Orders({this.status, this.id, this.products, this.user, this.timeStamp, this.deliveryBoy});

  Orders.fromJson(Map<String, dynamic> json) {
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
    deliveryBoy = json['deliveryBoy'];
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
    data['deliveryBoy'] = this.deliveryBoy;
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
