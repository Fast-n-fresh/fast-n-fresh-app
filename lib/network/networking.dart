import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/paths.dart';
import 'package:natures_delicacies/models/user_login.dart';
import 'package:natures_delicacies/models/user_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtils {
  String name;
  String email;
  String phone;
  String address;
  String username;

  String signUpError;
  String signInError;

  String userToken;

  Future<UserRegister> registerUser(UserRegister user) async {
    var headers = {
      'Content-Type': 'application/json',
      'connection': 'keep-alive'
    };

    return await http
        .post(
      Uri.https(BASE_URL, USER_SIGNUP_URL),
      // Uri.parse('https://$BASE_URL/$USER_SIGNUP_URL'),
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

      var extract = json.decode(response.body);
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

      return UserRegister.fromJson(json.decode(response.body));
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
      }

      var extract = json.decode(response.body);

      if (response.statusCode == 200) {
        name = extract['user']['name'].toString();
        email = extract['user']['email'].toString();
        phone = extract['user']['phoneNumber'].toString();
        address = extract['user']['address'].toString();
        username = extract['user']['username'].toString();
        userToken = extract['token'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phoneNumber', phone);
        prefs.setString('address', address);
        prefs.setString('username', username);
        prefs.setString('token', userToken);
      }

      return UserLogin.fromJson(json.decode(response.body));
    });
  }
}
