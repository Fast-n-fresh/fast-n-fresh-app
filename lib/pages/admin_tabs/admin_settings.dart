import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/admin_page.dart';
import 'package:natures_delicacies/models/admin_profile.dart';
import 'package:natures_delicacies/network/account_utils.dart';
import 'package:natures_delicacies/network/order_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_register.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key key}) : super(key: key);

  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  AccountUtils accountUtils = new AccountUtils();
  OrderUtils orderUtils = new OrderUtils();
  FToast fToast;

  bool toggleRebuild;

  final AsyncMemoizer _profileMemoizer = AsyncMemoizer();

  Admin adminProfile;

  TextEditingController deliveryBoyController = new TextEditingController();
  TextEditingController productController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController adminNameController = new TextEditingController();
  TextEditingController adminEmailController = new TextEditingController();

  bool validateDeliveryBoyEmail = false;
  bool validateProduct = false;
  bool validateCategory = false;
  bool validateAdminName = false;
  bool validateAdminEmail = false;

  @override
  void dispose() {
    super.dispose();
    deliveryBoyController.dispose();
    productController.dispose();
    categoryController.dispose();
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

  Future getProfile() async {
    return this._profileMemoizer.runOnce(() async {
      await accountUtils.getAdminProfile().then((value) {
        adminProfile = value;
        adminNameController.text = adminProfile.name;
        adminEmailController.text = adminProfile.email;
      });
    });
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
                            "https://ui-avatars.com/api/?size=200&name=Admin&background=FF5252&format=png&color=FFFFFF",
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
                        '${adminProfile.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${adminProfile.email}',
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
                                                  controller: adminNameController,
                                                  decoration: InputDecoration(
                                                    errorText: validateAdminName
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
                                                  textInputAction: TextInputAction.done,
                                                  textCapitalization: TextCapitalization.none,
                                                  style: GoogleFonts.montserrat(),
                                                  controller: adminEmailController,
                                                  decoration: InputDecoration(
                                                    errorText: validateAdminEmail
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

                                        setState(() {
                                          name = adminNameController.text;
                                          email = adminEmailController.text;

                                          name.isEmpty
                                              ? validateAdminName = true
                                              : validateAdminName = false;

                                          email.isEmpty
                                              ? validateAdminEmail = true
                                              : validateAdminEmail = false;
                                        });

                                        if (email.isNotEmpty && name.isNotEmpty) {
                                          await accountUtils
                                              .updateAdmin(name, email)
                                              .then((value) async {
                                            if (value == 'Account Updated Successfully!') {
                                              _showToast('Profile Updated!');
                                              Navigator.pop(context);
                                            } else {
                                              _showToast('Error: $value');
                                            }
                                          });
                                          Provider.of<AdminPage>(context, listen: false)
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
                              'Delete Product',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            leading: Icon(
                              Icons.shopping_cart,
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
                                  content: Container(
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'The selected product and all details related to it will be permanently deleted. \nAre you sure you want to delete this product?',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              color: Colors.grey[600],
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
                                                  controller: productController,
                                                  decoration: InputDecoration(
                                                    errorText: validateProduct
                                                        ? 'Field can\'t be empty'
                                                        : null,
                                                    errorStyle: GoogleFonts.montserrat(
                                                      color: Theme.of(context).colorScheme.error,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Product ID',
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
                                        String productId;

                                        setState(() {
                                          productId = productController.text;

                                          productId.isEmpty
                                              ? validateProduct = true
                                              : validateProduct = false;
                                        });

                                        if (productId.isNotEmpty) {
                                          await orderUtils
                                              .deleteProduct(productId)
                                              .then((value) async {
                                            if (value == 'Product Deleted Successfully!') {
                                              _showToast('Product Deleted!');
                                              Navigator.pop(context);
                                            } else {
                                              _showToast('Error: $value');
                                            }
                                          });
                                        }
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
                          ListTile(
                            title: Text(
                              'Delete Category',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            leading: Icon(
                              Icons.category,
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
                                  content: Container(
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'The selected category and all details related to it will be permanently deleted. \nAre you sure you want to delete this category?',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              color: Colors.grey[600],
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
                                                  controller: categoryController,
                                                  decoration: InputDecoration(
                                                    errorText: validateCategory
                                                        ? 'Field can\'t be empty'
                                                        : null,
                                                    errorStyle: GoogleFonts.montserrat(
                                                      color: Theme.of(context).colorScheme.error,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Category ID',
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
                                        String categoryId;

                                        setState(() {
                                          categoryId = categoryController.text;

                                          categoryId.isEmpty
                                              ? validateCategory = true
                                              : validateCategory = false;
                                        });

                                        if (categoryId.isNotEmpty) {
                                          await orderUtils
                                              .deleteCategory(categoryId)
                                              .then((value) async {
                                            if (value == 'Category Deleted Successfully!') {
                                              _showToast('Category Deleted!');
                                              Navigator.pop(context);
                                            } else {
                                              _showToast('Error: $value');
                                            }
                                          });
                                        }
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
                          ListTile(
                            title: Text(
                              'Remove Delivery Boy',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            leading: Icon(
                              Icons.delivery_dining,
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
                                  content: Container(
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'The selected account and all details related to it will be permanently deleted. \nAre you sure you want to delete this account?',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              color: Colors.grey[600],
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
                                                  textCapitalization: TextCapitalization.words,
                                                  style: GoogleFonts.montserrat(),
                                                  controller: deliveryBoyController,
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

                                        setState(() {
                                          email = deliveryBoyController.text;

                                          email.isEmpty
                                              ? validateDeliveryBoyEmail = true
                                              : validateDeliveryBoyEmail = false;
                                        });

                                        if (email.isNotEmpty) {
                                          await accountUtils
                                              .deleteDeliveryBoy(email)
                                              .then((value) async {
                                            if (value == 'Account Deleted Successfully!') {
                                              SharedPreferences prefs =
                                                  await SharedPreferences.getInstance();
                                              prefs.setBool('isDeliveryBoyLoggedIn', false);
                                              _showToast('Account Deleted!');
                                              Navigator.pop(context);
                                            } else {
                                              _showToast('Error: $value');
                                            }
                                          });
                                        }
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
                                        await accountUtils.deleteAdmin().then((value) async {
                                          if (value == 'Account Deleted Successfully!') {
                                            SharedPreferences prefs =
                                                await SharedPreferences.getInstance();
                                            prefs.setBool('isAdminLoggedIn', false);
                                            _showToast('Account Deleted!');
                                            Navigator.of(context).pushReplacement(
                                              PageRouteBuilder(
                                                pageBuilder:
                                                    (context, animation, secondaryAnimation) =>
                                                        LoginRegister(),
                                                transitionDuration: Duration(milliseconds: 500),
                                                transitionsBuilder: (context, animation,
                                                    secondaryAnimation, child) {
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
                              prefs.setBool('isAdminLoggedIn', false);
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
