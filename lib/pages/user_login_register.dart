import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natures_delicacies/models/user_login.dart';
import 'package:natures_delicacies/models/user_register.dart';
import 'package:natures_delicacies/network/networking.dart';
import 'package:toast/toast.dart';

class UserLoginRegister extends StatefulWidget {
  @override
  _UserLoginRegisterState createState() => _UserLoginRegisterState();
}

class _UserLoginRegisterState extends State<UserLoginRegister> {
  bool _isLoginPasswordHidden = true;
  bool _isRegisterPasswordHidden = true;
  bool _isRegisterConfirmPasswordHidden = true;
  bool isAdmin = false;

  double _loginOpacity;
  double _registerOpacity;

  var _loginHeight;
  var _loginWidth;
  var _registerHeight;
  var _registerWidth;

  double screenHeight = window.physicalSize.height / window.devicePixelRatio;
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  TextEditingController registerAddressController = TextEditingController();

  NetworkUtils networkUtils = new NetworkUtils();

  @override
  void dispose() {
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerPhoneController.dispose();
    registerUsernameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerAddressController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loginOpacity = 1.0;
    _registerOpacity = 0.0;

    _loginWidth = screenWidth;
    _registerWidth = screenWidth;
    _loginHeight = screenHeight * 0.60;
    _registerHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              opacity: _loginOpacity,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login to your account to start shopping',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: _loginHeight,
                    width: _loginWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.grey[200],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'Login to Continue',
                              style: TextStyle(
                                color: Theme.of(context).buttonColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  child: Icon(
                                    Icons.mail,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: loginEmailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: loginPasswordController,
                                    obscureText: _isLoginPasswordHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      suffix: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isLoginPasswordHidden =
                                                  !_isLoginPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isLoginPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Admin',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Checkbox(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: isAdmin,
                                  onChanged: (value) {
                                    setState(() {
                                      isAdmin = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: TextButton(
                              onPressed: () async {
                                String email;
                                String password;

                                setState(() {
                                  email = loginEmailController.text;
                                  password = loginPasswordController.text;
                                });

                                UserLogin user = new UserLogin(
                                  email: email,
                                  password: password,
                                );

                                if (email.isEmpty || password.isEmpty) {
                                  Toast.show('Empty fields', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else if (!EmailValidator.validate(email)) {
                                  Toast.show('Invalid Email', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else {
                                  await networkUtils
                                      .loginUser(user)
                                      .then((value) async {
                                    if (networkUtils.signInError ==
                                        'no error') {
                                      Toast.show(
                                          'Signed In Successfully', context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Colors.grey[700],
                                          backgroundRadius: 10);
                                    } else {
                                      Toast.show('${networkUtils.signInError}',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Colors.grey[700],
                                          backgroundRadius: 10);
                                    }
                                  });
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _loginHeight = 0.0;
                                    _loginOpacity = 0.0;
                                    _registerHeight = screenHeight * 0.60;
                                    _registerOpacity = 1.0;
                                  });
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: _registerOpacity,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      'Register!',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Sign up to continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: _registerHeight,
                    width: _registerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.grey[200],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'Create a new account',
                              style: TextStyle(
                                color: Theme.of(context).buttonColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          buildTextField(context, 'First Name', Icons.person,
                              TextInputType.name, registerFirstNameController),
                          buildTextField(context, 'Last Name', Icons.person,
                              TextInputType.name, registerLastNameController),
                          buildTextField(context, 'Mobile Number', Icons.phone,
                              TextInputType.phone, registerPhoneController),
                          buildTextField(
                              context,
                              'Username',
                              Icons.alternate_email,
                              TextInputType.name,
                              registerUsernameController),
                          // buildTextField(
                          //     context,
                          //     'Email',
                          //     Icons.mail,
                          //     TextInputType.emailAddress,
                          //     registerEmailController),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  child: Icon(
                                    Icons.email,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: registerEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: registerPasswordController,
                                    obscureText: _isRegisterPasswordHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      suffix: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isRegisterPasswordHidden =
                                                  !_isRegisterPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isRegisterPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller:
                                        registerConfirmPasswordController,
                                    obscureText:
                                        _isRegisterConfirmPasswordHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      suffix: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isRegisterConfirmPasswordHidden =
                                                  !_isRegisterConfirmPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isRegisterConfirmPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buildTextField(
                              context,
                              'Address',
                              Icons.location_on_rounded,
                              TextInputType.streetAddress,
                              registerAddressController),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: TextButton(
                              onPressed: () async {
                                String fname;
                                String lname;
                                String name;
                                String address;
                                String username;
                                String phone;
                                String email;
                                String password;
                                String conf_password;

                                setState(() {
                                  fname = registerFirstNameController.text;
                                  lname = registerLastNameController.text;
                                  name = '$fname $lname';
                                  phone = registerPhoneController.text;
                                  username = registerUsernameController.text;
                                  email = registerEmailController.text;
                                  password = registerPasswordController.text;
                                  conf_password =
                                      registerConfirmPasswordController.text;
                                  address = registerAddressController.text;
                                });

                                UserRegister user = new UserRegister(
                                  username: username,
                                  name: name,
                                  address: address,
                                  email: email,
                                  password: password,
                                  phoneNumber: phone,
                                );

                                if (fname.isEmpty ||
                                    lname.isEmpty ||
                                    phone.isEmpty ||
                                    username.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty ||
                                    conf_password.isEmpty ||
                                    address.isEmpty) {
                                  Toast.show('Empty fields', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else if (!EmailValidator.validate(email)) {
                                  Toast.show('Invalid Email', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else if (phone.length != 10 ||
                                    !isNumeric(phone)) {
                                  Toast.show('Invalid phone number', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else if (password.length < 6) {
                                  Toast.show('Password is too short', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else if (password != conf_password) {
                                  Toast.show('Passwords don\'t match', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.TOP,
                                      backgroundColor: Colors.grey[700],
                                      backgroundRadius: 10);
                                } else {
                                  await networkUtils
                                      .registerUser(user)
                                      .then((value) async {
                                    if (networkUtils.signUpError ==
                                        'no error') {
                                      Toast.show(
                                          'Registered Successfully', context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Colors.grey[700],
                                          backgroundRadius: 10);

                                      setState(() {
                                        _registerHeight = 0.0;
                                        _registerOpacity = 0.0;
                                        _loginHeight = screenHeight * 0.60;
                                        _loginOpacity = 1.0;
                                      });
                                    } else {
                                      Toast.show('${networkUtils.signUpError}',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Colors.grey[700],
                                          backgroundRadius: 10);
                                    }
                                  });
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _registerHeight = 0.0;
                                    _registerOpacity = 0.0;
                                    _loginHeight = screenHeight * 0.60;
                                    _loginOpacity = 1.0;
                                  });
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTextField(BuildContext context, String hint, IconData icon,
      TextInputType type, TextEditingController controller) {
    return Container(
      width: screenWidth,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Icon(
              icon,
              size: 20,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '$hint',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s, onError: (e) => null) != null;
  }
}
