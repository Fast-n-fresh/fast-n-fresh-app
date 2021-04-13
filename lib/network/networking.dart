import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/constants/consts.dart';
import 'package:natures_delicacies/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtils {
  String name;
  String email;
  String phone;
  String address;
  String username;

  String signUpError;

  Future<User> registerUser(User user) async {
    var headers = {'Content-Type': 'application/json', 'connection': 'keep-alive'};
    return await http
        .post(
      Uri.parse('$BASE_URL/$USER_SIGNUP_URL'),
      body: jsonEncode(user.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 401 || json == null) {
        throw new Exception('Error while registering!');
      }

      var extract = json.decode(response.body);
      if (response.statusCode == 401) {
        signUpError = extract['e'].toString();
      } else {
        name = extract['user']['name'].toString();
        name = extract['user']['email'].toString();
        name = extract['user']['phoneNumber'].toString();
        name = extract['user']['address'].toString();
        name = extract['user']['username'].toString();
      }

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('name', name);
      prefs.setString('email', email);
      prefs.setString('phoneNumber', phone);
      prefs.setString('address', address);
      prefs.setString('username', username);

      return User.fromJson(json.decode(response.body));
    });
  }
}
