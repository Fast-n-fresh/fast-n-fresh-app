import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/delivery_boy_profile.dart';
import 'package:natures_delicacies/network/account_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_register.dart';

class DeliveryBoySettings extends StatefulWidget {
  const DeliveryBoySettings({Key key}) : super(key: key);

  @override
  _DeliveryBoySettingsState createState() => _DeliveryBoySettingsState();
}

class _DeliveryBoySettingsState extends State<DeliveryBoySettings> {
  AccountUtils accountUtils = new AccountUtils();
  DeliveryBoy deliveryBoyProfile;

  Future getProfile() async {
    await accountUtils.getDeliveryBoyProfile().then((value) {
      deliveryBoyProfile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: FutureBuilder(
          future: getProfile(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Loading...',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              case ConnectionState.done:
                print('fetched profile');
            }
            return Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            "https://ui-avatars.com/api/?size=200&name=${deliveryBoyProfile.name}&background=FF5252&format=png&color=FFFFFF",
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              AssetImage('./lib/images/avatar.png'),
                          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${deliveryBoyProfile.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${deliveryBoyProfile.email}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
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
                              'Logout',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.grey[800],
                            ),
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setBool('isDeliveryBoyLoggedIn', false);
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      LoginRegister(),
                                  transitionDuration: Duration(milliseconds: 500),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    animation =
                                        CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                                    return SlideTransition(
                                      position:
                                          Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
