import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/user_login.dart';
import 'package:natures_delicacies/models/user_register.dart';
import 'package:natures_delicacies/network/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'user_dashboard.dart';

class UserLoginRegister extends StatefulWidget {
  @override
  _UserLoginRegisterState createState() => _UserLoginRegisterState();
}

class _UserLoginRegisterState extends State<UserLoginRegister> {
  bool _isLoginPasswordHidden = true;
  bool _isRegisterPasswordHidden = true;
  bool _isRegisterConfirmPasswordHidden = true;

  bool isAdmin = false;
  bool isDeliveryBoy = false;

  bool isLoginLoading = false;
  bool isRegisterLoading = false;

  double _loginOpacity;
  double _registerOpacity;

  var _loginHeight;
  var _loginWidth;
  var _registerHeight;
  var _registerWidth;

  double screenHeight = window.physicalSize.height / window.devicePixelRatio;
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;

  bool loginEmailValidate = false;
  bool loginPasswordValidate = false;
  bool registerFirstNameValidate = false;
  bool registerLastNameValidate = false;
  bool registerPhoneValidate = false;
  bool registerUsernameValidate = false;
  bool registerEmailValidate = false;
  bool registerPasswordValidate = false;
  bool registerConfirmPasswordValidate = false;
  bool registerAddressValidate = false;

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
  SharedPreferences prefs;

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
                      style: GoogleFonts.poppins(
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
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
                    duration: Duration(milliseconds: 750),
                    curve: Curves.easeInOut,
                    height: _registerHeight,
                    width: _registerWidth,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x20000000),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, -4),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
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
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).buttonColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          buildTextField(
                            context,
                            'First Name',
                            Icons.person,
                            TextInputType.name,
                            registerFirstNameController,
                            TextCapitalization.words,
                            registerFirstNameValidate,
                          ),
                          buildTextField(
                            context,
                            'Last Name',
                            Icons.person,
                            TextInputType.name,
                            registerLastNameController,
                            TextCapitalization.words,
                            registerLastNameValidate,
                          ),
                          buildTextField(
                            context,
                            'Mobile Number',
                            Icons.phone,
                            TextInputType.phone,
                            registerPhoneController,
                            TextCapitalization.none,
                            registerPhoneValidate,
                          ),
                          buildTextField(
                            context,
                            'Username',
                            Icons.alternate_email,
                            TextInputType.name,
                            registerUsernameController,
                            TextCapitalization.words,
                            registerUsernameValidate,
                          ),
                          buildTextField(
                            context,
                            'Email',
                            Icons.mail,
                            TextInputType.emailAddress,
                            registerEmailController,
                            TextCapitalization.none,
                            registerEmailValidate,
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller: registerPasswordController,
                                    obscureText: _isRegisterPasswordHidden,
                                    decoration: InputDecoration(
                                      errorText: registerPasswordValidate
                                          ? 'Field can\'t be empty'
                                          : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.montserrat(
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller:
                                        registerConfirmPasswordController,
                                    obscureText:
                                        _isRegisterConfirmPasswordHidden,
                                    decoration: InputDecoration(
                                      errorText: registerConfirmPasswordValidate
                                          ? 'Field can\'t be empty'
                                          : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                            registerAddressController,
                            TextCapitalization.sentences,
                            registerAddressValidate,
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: isRegisterLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      String fname;
                                      String lname;
                                      String name;
                                      String address;
                                      String username;
                                      String phone;
                                      String email;
                                      String password;
                                      String confirmPassword;

                                      setState(() {
                                        isRegisterLoading = true;
                                        fname =
                                            registerFirstNameController.text;
                                        lname = registerLastNameController.text;
                                        name = '$fname $lname';
                                        phone = registerPhoneController.text;
                                        username =
                                            registerUsernameController.text;
                                        email = registerEmailController.text;
                                        password =
                                            registerPasswordController.text;
                                        confirmPassword =
                                            registerConfirmPasswordController
                                                .text;
                                        address =
                                            registerAddressController.text;

                                        fname.isEmpty
                                            ? registerFirstNameValidate = true
                                            : registerFirstNameValidate = false;
                                        lname.isEmpty
                                            ? registerLastNameValidate = true
                                            : registerLastNameValidate = false;
                                        phone.isEmpty
                                            ? registerPhoneValidate = true
                                            : registerPhoneValidate = false;
                                        email.isEmpty
                                            ? registerEmailValidate = true
                                            : registerEmailValidate = false;
                                        username.isEmpty
                                            ? registerUsernameValidate = true
                                            : registerUsernameValidate = false;
                                        password.isEmpty
                                            ? registerPasswordValidate = true
                                            : registerPasswordValidate = false;
                                        confirmPassword.isEmpty
                                            ? registerConfirmPasswordValidate =
                                                true
                                            : registerConfirmPasswordValidate =
                                                false;
                                        address.isEmpty
                                            ? registerAddressValidate = true
                                            : registerAddressValidate = false;
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
                                          confirmPassword.isEmpty ||
                                          address.isEmpty) {
                                        setState(() {
                                          isRegisterLoading = false;
                                        });
                                        print('Empty Fields');
                                      } else if (!EmailValidator.validate(
                                          email)) {
                                        setState(() {
                                          isRegisterLoading = false;
                                        });
                                        Toast.show(
                                          'Invalid Email',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          backgroundRadius: 10,
                                        );
                                      } else if (phone.length != 10 ||
                                          !isNumeric(phone)) {
                                        setState(() {
                                          isRegisterLoading = false;
                                        });
                                        Toast.show(
                                          'Invalid phone number',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          backgroundRadius: 10,
                                        );
                                      } else if (password.length < 6) {
                                        setState(() {
                                          isRegisterLoading = false;
                                        });
                                        Toast.show(
                                          'Password is too short',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          backgroundRadius: 10,
                                        );
                                      } else if (password != confirmPassword) {
                                        setState(() {
                                          isRegisterLoading = false;
                                        });
                                        Toast.show(
                                          'Passwords don\'t match',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          backgroundRadius: 10,
                                        );
                                      } else {
                                        await networkUtils
                                            .registerUser(user)
                                            .then((value) async {
                                          if (networkUtils.signUpError ==
                                              'no error') {
                                            Toast.show(
                                              'Registered Successfully',
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.TOP,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              backgroundRadius: 10,
                                            );

                                            setState(() {
                                              isRegisterLoading = false;
                                              _registerHeight = 0.0;
                                              _registerOpacity = 0.0;
                                              _loginHeight =
                                                  screenHeight * 0.60;
                                              _loginOpacity = 1.0;
                                            });
                                          } else {
                                            setState(() {
                                              isRegisterLoading = false;
                                            });
                                            Toast.show(
                                              '${networkUtils.signUpError}',
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.TOP,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              backgroundRadius: 10,
                                            );
                                          }
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).buttonColor,
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
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                ),
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
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
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
                      style: GoogleFonts.poppins(
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
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
                    duration: Duration(milliseconds: 750),
                    curve: Curves.easeInOut,
                    height: _loginHeight,
                    width: _loginWidth,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x20000000),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, -4),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
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
                              style: GoogleFonts.poppins(
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
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller: loginEmailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      errorText: loginEmailValidate
                                          ? 'Field can\'t be empty'
                                          : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color:
                                            Theme.of(context).colorScheme.error,
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
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: loginPasswordController,
                                    obscureText: _isLoginPasswordHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: loginPasswordValidate
                                          ? 'Field can\'t be empty'
                                          : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Delivery Boy',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    Checkbox(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: isDeliveryBoy,
                                      onChanged: (value) {
                                        setState(() {
                                          isDeliveryBoy = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Admin',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    Checkbox(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: isAdmin,
                                      onChanged: (value) {
                                        setState(() {
                                          isAdmin = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: isLoginLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      String email;
                                      String password;

                                      setState(() {
                                        isLoginLoading = true;
                                        email = loginEmailController.text;
                                        password = loginPasswordController.text;

                                        email.isEmpty
                                            ? loginEmailValidate = true
                                            : loginEmailValidate = false;
                                        password.isEmpty
                                            ? loginPasswordValidate = true
                                            : loginPasswordValidate = false;
                                      });

                                      if (isDeliveryBoy == false &&
                                          isAdmin == false) {
                                        UserLogin user = new UserLogin(
                                          email: email,
                                          password: password,
                                        );

                                        if (email.isEmpty || password.isEmpty) {
                                          print('Empty Fields');
                                          setState(() {
                                            isLoginLoading = false;
                                          });
                                        } else if (!EmailValidator.validate(
                                            email)) {
                                          setState(() {
                                            isLoginLoading = false;
                                          });
                                          Toast.show(
                                            'Invalid Email',
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.TOP,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            backgroundRadius: 10,
                                          );
                                        } else {
                                          await networkUtils
                                              .loginUser(user)
                                              .then((value) async {
                                            if (networkUtils.signInError ==
                                                'no error') {
                                              Toast.show(
                                                'Signed In Successfully',
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.TOP,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                backgroundRadius: 10,
                                              );
                                              prefs = await SharedPreferences
                                                  .getInstance();
                                              prefs.setBool('isLoggedIn', true);
                                              setState(() {
                                                isLoginLoading = false;
                                              });

                                              Navigator.of(context)
                                                  .pushReplacement(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      UserDashboard(),
                                                  transitionDuration: Duration(
                                                      milliseconds: 1000),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    animation = CurvedAnimation(
                                                        parent: animation,
                                                        curve:
                                                            Curves.easeInOut);
                                                    return SlideTransition(
                                                      position: Tween(
                                                              begin: Offset(
                                                                  0.0, 1.0),
                                                              end: Offset(
                                                                  0.0, 0.0))
                                                          .animate(animation),
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                isLoginLoading = false;
                                              });

                                              Toast.show(
                                                '${networkUtils.signInError}',
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.TOP,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                backgroundRadius: 10,
                                              );
                                            }
                                          });
                                        }
                                      } else if (isDeliveryBoy == true &&
                                          isAdmin == true) {
                                        setState(() {
                                          isLoginLoading = false;
                                        });
                                        Toast.show(
                                          'Cannot be both Admin and Delivery Boy',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          backgroundRadius: 10,
                                          gravity: Toast.TOP,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).buttonColor,
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
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                ),
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
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }

  Container buildTextField(
    BuildContext context,
    String hint,
    IconData icon,
    TextInputType type,
    TextEditingController controller,
    TextCapitalization caps,
    bool validate,
  ) {
    return Container(
      width: screenWidth,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
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
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: TextField(
              textCapitalization: caps,
              style: GoogleFonts.montserrat(),
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                errorText: validate ? 'Field can\'t be empty' : null,
                errorStyle: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.error,
                ),
                border: InputBorder.none,
                hintText: '$hint',
                hintStyle: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.onSurface,
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
