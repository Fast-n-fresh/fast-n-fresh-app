class DeliveryBoyRegister {
  String name;
  String email;
  String password;
  String phoneNumber;
  List pending;
  //TODO: Modify pending orders field

  DeliveryBoyRegister({this.name, this.email, this.password, this.phoneNumber});

  factory DeliveryBoyRegister.fromJson(Map<String, dynamic> json) {
    return DeliveryBoyRegister(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
