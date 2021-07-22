import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/network/account_utils.dart';
import 'package:natures_delicacies/pages/login_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  AccountUtils accountUtils = new AccountUtils();

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[700],
      ),
      child: Text(
        message,
        style: GoogleFonts.raleway(color: Colors.white),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Consumer<UserProfileModel>(
                      builder: (context, model, child) => CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                          "https://ui-avatars.com/api/?size=200&name=${model.name}&background=FF5252&format=png&color=FFFFFF",
                        ),
                        onBackgroundImageError: (exception, stackTrace) =>
                            AssetImage('./lib/images/avatar.png'),
                        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<UserProfileModel>(
                    builder: (context, model, child) {
                      return Text(
                        '${model.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  Consumer<UserProfileModel>(
                    builder: (context, model, child) {
                      return Text(
                        '${model.username}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Expanded(
                child: SingleChildScrollView(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(
                          'Update Profile',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.grey[800],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[800],
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        title: Text(
                          'Delete Account',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Are you sure?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'This account and all details related to it will be permanently deleted. \nAre you sure you want to delete this account?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: Text(
                                    'CANCEL',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await accountUtils.deleteUser().then((value) async {
                                      if (value == 'Account Deleted Successfully!') {
                                        SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                        prefs.setBool('isLoggedIn', false);
                                        Navigator.of(context).pushReplacement(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) =>
                                                LoginRegister(),
                                            transitionDuration: Duration(milliseconds: 500),
                                            transitionsBuilder:
                                                (context, animation, secondaryAnimation, child) {
                                              animation = CurvedAnimation(
                                                  parent: animation, curve: Curves.easeInOut);
                                              return SlideTransition(
                                                position: Tween(
                                                        begin: Offset(0.0, 1.0),
                                                        end: Offset(0.0, 0.0))
                                                    .animate(animation),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        _showToast('Error: $value');
                                      }
                                    });
                                  },
                                  child: Text(
                                    'DELETE',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Colors.grey[800],
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        title: Text(
                          'Logout',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.grey[800],
                        ),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', false);
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  LoginRegister(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                animation =
                                    CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                                return SlideTransition(
                                  position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                                      .animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
