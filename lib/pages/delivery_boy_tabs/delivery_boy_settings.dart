import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/delivery_boy_page.dart';
import 'package:natures_delicacies/models/delivery_boy_profile.dart';
import 'package:natures_delicacies/network/account_utils.dart';
import 'package:provider/provider.dart';
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

  final AsyncMemoizer _profileMemoizer = AsyncMemoizer();

  FToast fToast;

  TextEditingController deliveryBoyNameController = new TextEditingController();
  TextEditingController deliveryBoyEmailController = new TextEditingController();
  TextEditingController deliveryBoyPhoneController = new TextEditingController();

  bool validateDeliveryBoyName = false;
  bool validateDeliveryBoyEmail = false;
  bool validateDeliveryBoyPhone = false;

  Future getProfile() async {
    return this._profileMemoizer.runOnce(() async {
      await accountUtils.getDeliveryBoyProfile().then((value) {
        deliveryBoyProfile = value;

        deliveryBoyNameController.text = deliveryBoyProfile.name;
        deliveryBoyEmailController.text = deliveryBoyProfile.email;
        deliveryBoyPhoneController.text = deliveryBoyProfile.phoneNumber;
      });
    });
  }

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
    double screenWidth = MediaQuery.of(context).size.width;

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
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Update Profile',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Container(
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Enter new details',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: screenWidth,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Center(
                                                child: TextField(
                                                  textInputAction: TextInputAction.next,
                                                  textCapitalization: TextCapitalization.words,
                                                  style: GoogleFonts.montserrat(),
                                                  controller: deliveryBoyNameController,
                                                  decoration: InputDecoration(
                                                    errorText: validateDeliveryBoyName
                                                        ? 'Field can\'t be empty'
                                                        : null,
                                                    errorStyle: GoogleFonts.montserrat(
                                                      color: Theme.of(context).colorScheme.error,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Name',
                                                    hintStyle: GoogleFonts.montserrat(
                                                      color:
                                                          Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: screenWidth,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Center(
                                                child: TextField(
                                                  textInputAction: TextInputAction.next,
                                                  textCapitalization: TextCapitalization.none,
                                                  style: GoogleFonts.montserrat(),
                                                  controller: deliveryBoyEmailController,
                                                  decoration: InputDecoration(
                                                    errorText: validateDeliveryBoyEmail
                                                        ? 'Field can\'t be empty'
                                                        : null,
                                                    errorStyle: GoogleFonts.montserrat(
                                                      color: Theme.of(context).colorScheme.error,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Email',
                                                    hintStyle: GoogleFonts.montserrat(
                                                      color:
                                                          Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: screenWidth,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Center(
                                                child: TextField(
                                                  textInputAction: TextInputAction.done,
                                                  textCapitalization: TextCapitalization.none,
                                                  style: GoogleFonts.montserrat(),
                                                  controller: deliveryBoyPhoneController,
                                                  decoration: InputDecoration(
                                                    errorText: validateDeliveryBoyPhone
                                                        ? 'Field can\'t be empty'
                                                        : null,
                                                    errorStyle: GoogleFonts.montserrat(
                                                      color: Theme.of(context).colorScheme.error,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Phone No.',
                                                    hintStyle: GoogleFonts.montserrat(
                                                      color:
                                                          Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                        String email;
                                        String name;
                                        String phone;

                                        setState(() {
                                          name = deliveryBoyNameController.text;
                                          email = deliveryBoyEmailController.text;
                                          phone = deliveryBoyPhoneController.text;

                                          name.isEmpty
                                              ? validateDeliveryBoyName = true
                                              : validateDeliveryBoyName = false;

                                          email.isEmpty
                                              ? validateDeliveryBoyEmail = true
                                              : validateDeliveryBoyEmail = false;

                                          phone.isEmpty
                                              ? validateDeliveryBoyPhone = true
                                              : validateDeliveryBoyPhone = false;
                                        });

                                        if (email.isNotEmpty &&
                                            name.isNotEmpty &&
                                            phone.isNotEmpty) {
                                          await accountUtils
                                              .updateDeliveryBoy(name, email, phone)
                                              .then((value) async {
                                            if (value == 'Account Updated Successfully!') {
                                              _showToast('Profile Updated!');
                                              Navigator.pop(context);
                                            } else {
                                              _showToast('Error: $value');
                                            }
                                          });
                                          Provider.of<DeliveryBoyPage>(context, listen: false)
                                              .setCurrentPage(0);
                                        }
                                      },
                                      child: Text(
                                        'UPDATE',
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
