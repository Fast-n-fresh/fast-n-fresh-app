import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                    child: CircleAvatar(
                      backgroundImage: AssetImage('./lib/images/avatar.png'),
                      radius: 80,
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
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'Update Password',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    leading: Icon(
                      Icons.lock,
                      color: Colors.grey[800],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Update Location',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.grey[800],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
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
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', false);
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UserLoginRegister(),
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
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
