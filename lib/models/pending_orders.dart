class PendingOrdersList {
  String message;
  List<PendingOrders> pendingOrders;

  PendingOrdersList({this.message, this.pendingOrders});

  PendingOrdersList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['pendingOrders'] != null) {
      pendingOrders = [];
      json['pendingOrders'].forEach((v) {
        pendingOrders.add(new PendingOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.pendingOrders != null) {
      data['pendingOrders'] = this.pendingOrders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingOrders {
  String status;
  String id;
  List<Products> products;
  String user;
  String timeStamp;

  PendingOrders({
    this.status,
    this.id,
    this.products,
    this.user,
    this.timeStamp,
  });

  PendingOrders.fromJson(Map<String, dynamic> json) {
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
  String productId;

  Products({this.quantity, this.id, this.productId});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    id = json['_id'];
    productId = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['_id'] = this.id;
    data['product'] = this.productId;
    return data;
  }
}
