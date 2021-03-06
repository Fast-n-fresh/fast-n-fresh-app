class UserRegister {
  String name;
  String username;
  String email;
  String password;
  String phoneNumber;
  String address;

  UserRegister(
      {this.name,
      this.username,
      this.email,
      this.password,
      this.phoneNumber,
      this.address});

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
