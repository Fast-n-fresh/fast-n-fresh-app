class UserProfile {
  String message;
  User user;

  UserProfile({this.message, this.user});

  UserProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['UserProfile'] != null ? new User.fromJson(json['UserProfile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['UserProfile'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  List<String> prevOrders;
  String id;
  String name;
  String username;
  String email;
  String phoneNumber;
  String address;

  User({
    this.prevOrders,
    this.id,
    this.name,
    this.username,
    this.email,
    this.phoneNumber,
    this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    prevOrders = json['prevOrders'].cast<String>();
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prevOrders'] = this.prevOrders;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
