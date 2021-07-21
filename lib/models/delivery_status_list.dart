class DeliveryStatusList {
  String message;
  List<PendingDeliveryStatus> deliveryStatus;

  DeliveryStatusList({this.message, this.deliveryStatus});

  DeliveryStatusList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['deliveryStatus'] != null) {
      deliveryStatus = [];
      json['deliveryStatus'].forEach((v) {
        deliveryStatus.add(new PendingDeliveryStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.deliveryStatus != null) {
      data['deliveryStatus'] = this.deliveryStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingDeliveryStatus {
  String deliveryBoy;
  List<String> pendingOrders;

  PendingDeliveryStatus({this.deliveryBoy, this.pendingOrders});

  PendingDeliveryStatus.fromJson(Map<String, dynamic> json) {
    deliveryBoy = json['deliveryBoy'];
    pendingOrders = json['pendingOrders'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryBoy'] = this.deliveryBoy;
    data['pendingOrders'] = this.pendingOrders;
    return data;
  }
}
