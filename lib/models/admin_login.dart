class AdminLogin {
  String email;
  String password;

  AdminLogin({this.email, this.password});

  factory AdminLogin.fromJson(Map<String, dynamic> json) {
    return AdminLogin(
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
