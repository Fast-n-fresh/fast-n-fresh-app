import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/admin_login.dart';
import 'package:natures_delicacies/models/admin_profile.dart';
import 'package:natures_delicacies/models/delivery_boy_login.dart';
import 'package:natures_delicacies/models/delivery_boy_profile.dart';
import 'package:natures_delicacies/models/delivery_boy_register.dart';
import 'package:natures_delicacies/models/user_login.dart';
import 'package:natures_delicacies/models/user_profile.dart';
import 'package:natures_delicacies/models/user_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountUtils {
  String name;
  String email;
  String phone;
  String address;
  String username;

  String deliveryBoyName;
  String deliveryBoyEmail;
  String deliveryBoyPhone;
  List deliveryBoyPending;

  String signUpError;
  String signInError;

  String userToken;
  String adminToken;
  String deliveryBoyToken;

  Future<UserRegister> registerUser(UserRegister user) async {
    var headers = {'Content-Type': 'application/json', 'connection': 'keep-alive'};

    return await http
        .post(
      Uri.https(BASE_URL, USER_SIGNUP_URL),
      body: jsonEncode(user.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 401 || json == null) {
        print('error while registering');
        signUpError = 'Error while Registering';
      } else if (response.statusCode == 201) {
        print('registered successfully');
        signUpError = 'no error';
      }

      var extract = jsonDecode(response.body);
      if (response.statusCode == 401) {
        signUpError = extract['e']['message'].toString();
        if (signUpError == null || signUpError == 'null') {
          signUpError = 'Error while Registering';
        }
      } else {
        name = extract['user']['name'].toString();
        email = extract['user']['email'].toString();
        phone = extract['user']['phoneNumber'].toString();
        address = extract['user']['address'].toString();
        username = extract['user']['username'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phoneNumber', phone);
        prefs.setString('address', address);
        prefs.setString('username', username);
      }

      return UserRegister.fromJson(jsonDecode(response.body));
    });
  }

  Future<UserLogin> loginUser(UserLogin user) async {
    var headers = {'Content-Type': 'application/json'};

    return await http
        .post(Uri.https(BASE_URL, USER_SIGNIN_URL),
            body: jsonEncode(user.toJson()), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 401) {
        print('unable to login');
        signInError = 'Unable to login';
      } else if (response.statusCode == 200) {
        print('signed in successfully');
        signInError = 'no error';

        var extract = jsonDecode(response.body);

        name = extract['user']['name'].toString();
        email = extract['user']['email'].toString();
        phone = extract['user']['phoneNumber'].toString();
        address = extract['user']['address'].toString();
        username = extract['user']['username'].toString();
        userToken = extract['token'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', name);
        print(name);
        prefs.setString('email', email);
        prefs.setString('phoneNumber', phone);
        prefs.setString('address', address);
        prefs.setString('username', username);
        prefs.setString('token', userToken);
      }

      return UserLogin.fromJson(jsonDecode(response.body));
    });
  }

  Future<AdminLogin> loginAdmin(AdminLogin admin) async {
    var headers = {'Content-Type': 'application/json'};

    return await http
        .post(Uri.https(BASE_URL, ADMIN_SIGNIN_URL),
            body: jsonEncode(admin.toJson()), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 401) {
        print('unable to login');
        signInError = 'Unable to login';
      } else if (response.statusCode == 200) {
        print('signed in successfully');
        signInError = 'no error';

        var extract = jsonDecode(response.body);
        adminToken = extract['token'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', adminToken);
      }

      return AdminLogin.fromJson(jsonDecode(response.body));
    });
  }

  Future<DeliveryBoyLogin> loginDeliveryBoy(DeliveryBoyLogin deliveryBoy) async {
    var headers = {'Content-Type': 'application/json'};

    return await http
        .post(Uri.https(BASE_URL, DELIVERY_BOY_SIGNIN_URL),
            body: jsonEncode(deliveryBoy.toJson()), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 401) {
        print('unable to login');
        signInError = 'Unable to login';
      } else if (response.statusCode == 200) {
        print('signed in successfully');
        signInError = 'no error';

        var extract = jsonDecode(response.body);
        deliveryBoyToken = extract['token'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', deliveryBoyToken);
      }

      return DeliveryBoyLogin.fromJson(jsonDecode(response.body));
    });
  }

  Future<UserRegister> registerDeliveryBoy(DeliveryBoyRegister deliveryBoy) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
      'connection': 'keep-alive'
    };

    return await http
        .post(
      Uri.https(BASE_URL, DELIVERY_BOY_SIGNUP_URL),
      body: jsonEncode(deliveryBoy.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 401 || json == null) {
        print('error while registering');
        signUpError = 'Error while Registering';
      } else if (response.statusCode == 201) {
        print('registered successfully');
        signUpError = 'no error';
      }

      var extract = jsonDecode(response.body);
      if (response.statusCode == 401) {
        signUpError = extract['e']['message'].toString();
        if (signUpError == null || signUpError == 'null') {
          signUpError = 'Error while Registering';
        }
      } else {
        deliveryBoyName = extract['deliveryBoy']['name'].toString();
        deliveryBoyEmail = extract['deliveryBoy']['email'].toString();
        deliveryBoyPhone = extract['deliveryBoy']['phoneNumber'].toString();
        extract['deliveryBoy']['pendingOrders'].forEach((order) => deliveryBoyPending.add(order));
      }

      return UserRegister.fromJson(jsonDecode(response.body));
    });
  }

  Future<DeliveryBoy> getDeliveryBoyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String deliveryBoyToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $deliveryBoyToken',
    };

    DeliveryBoyProfile deliveryBoyProfile;

    final response =
        await http.get(Uri.https(BASE_URL, DELIVERY_BOY_PROFILE_URL), headers: headers);

    if (response.statusCode == 200) {
      deliveryBoyProfile = DeliveryBoyProfile.fromJson(jsonDecode(response.body));
    } else {
      throw new Exception('Couldn\'t fetch profile');
    }
    return deliveryBoyProfile.deliveryBoy;
  }

  Future<Admin> getAdminProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
    };

    AdminProfile adminProfile;

    final response = await http.get(Uri.https(BASE_URL, ADMIN_PROFILE_URL), headers: headers);

    if (response.statusCode == 200) {
      adminProfile = AdminProfile.fromJson(jsonDecode(response.body));
    } else {
      throw new Exception('Couldn\'t fetch profile');
    }
    return adminProfile.admin;
  }

  Future<User> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $userToken',
    };

    UserProfile userProfile;

    final response = await http.get(Uri.https(BASE_URL, USER_PROFILE_URL), headers: headers);

    if (response.statusCode == 200) {
      userProfile = UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw new Exception('Couldn\'t fetch profile');
    }
    return userProfile.user;
  }

  Future deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $userToken',
    };

    final response = await http.delete(
      Uri.https(BASE_URL, USER_DELETE_URL),
      headers: headers,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Deleted Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }

  Future deleteAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
    };

    final response = await http.delete(
      Uri.https(BASE_URL, ADMIN_DELETE_URL),
      headers: headers,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Deleted Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }

  Future deleteDeliveryBoy(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "email": email,
    });

    final response = await http.delete(
      Uri.https(BASE_URL, DELIVERY_BOY_DELETE_URL),
      headers: headers,
      body: body,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Deleted Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }

  Future updateAdmin(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "name": name,
      "email": email,
    });

    final response = await http.patch(
      Uri.https(BASE_URL, ADMIN_UPDATE_PROFILE_URL),
      headers: headers,
      body: body,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Updated Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }

  Future updateUser(String name, String email, String username) async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "name": name,
      "email": email,
      "username": username,
    });

    final response = await http.patch(
      Uri.https(BASE_URL, USER_UPDATE_PROFILE_URL),
      headers: headers,
      body: body,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Updated Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }

  Future updateDeliveryBoy(String name, String email, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    String deliveryBoyToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $deliveryBoyToken',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "name": name,
      "email": email,
      "phoneNumber": phone,
    });

    final response = await http.patch(
      Uri.https(BASE_URL, DELIVERY_BOY_UPDATE_PROFILE_URL),
      headers: headers,
      body: body,
    );

    var extract = jsonDecode(response.body);

    String message;
    if (response.statusCode == 200) {
      message = 'Account Updated Successfully!';
    } else {
      message = extract['e'];
    }

    return message;
  }
}
