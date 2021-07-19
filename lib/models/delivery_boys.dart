class DeliveryBoyList {
  String message;
  List<DeliveryBoy> deliveryBoyList;

  DeliveryBoyList({this.message, this.deliveryBoyList});

  DeliveryBoyList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['deliveryBoyList'] != null) {
      deliveryBoyList = [];
      json['deliveryBoyList'].forEach((v) {
        deliveryBoyList.add(new DeliveryBoy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.deliveryBoyList != null) {
      data['deliveryBoyList'] = this.deliveryBoyList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryBoy {
  List<String> pendingOrders;
  String id;
  String name;
  String email;
  String phoneNumber;

  DeliveryBoy({
    this.pendingOrders,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    pendingOrders = json['pendingOrders'].cast<String>();
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pendingOrders'] = this.pendingOrders;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
