class DeliveryBoyProfile {
  String message;
  DeliveryBoy deliveryBoy;

  DeliveryBoyProfile({this.message, this.deliveryBoy});

  DeliveryBoyProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    deliveryBoy =
        json['deliveryBoy'] != null ? new DeliveryBoy.fromJson(json['deliveryBoy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.deliveryBoy != null) {
      data['deliveryBoy'] = this.deliveryBoy.toJson();
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
