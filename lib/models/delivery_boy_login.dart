class DeliveryBoyLogin {
  String email;
  String password;

  DeliveryBoyLogin({this.email, this.password});

  factory DeliveryBoyLogin.fromJson(Map<String, dynamic> json) {
    return DeliveryBoyLogin(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
