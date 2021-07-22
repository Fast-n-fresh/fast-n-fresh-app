class AdminProfile {
  String message;
  Admin admin;

  AdminProfile({this.message, this.admin});

  AdminProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.admin != null) {
      data['admin'] = this.admin.toJson();
    }
    return data;
  }
}

class Admin {
  String id;
  String name;
  String email;

  Admin({
    this.id,
    this.name,
    this.email,
  });

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
