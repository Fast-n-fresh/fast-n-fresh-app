import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart_item.dart';
import 'package:natures_delicacies/models/cart_model.dart';
import 'package:natures_delicacies/models/categories_model.dart';
import 'package:natures_delicacies/models/user_page_model.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/pages/item_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = new Random();
  int activeCategory = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.050,
                left: screenWidth * 0.050,
                top: screenHeight * 0.040,
                bottom: screenHeight * 0.00,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {},
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<UserPageModel>(context, listen: false).setCurrentPage(3);
                          },
                          child: Consumer<UserProfileModel>(
                            builder: (context, model, child) => CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                "https://ui-avatars.com/api/?size=60&name=${model.name}&background=FF5252&format=png&color=FFFFFF",
                              ),
                              onBackgroundImageError: (exception, stackTrace) =>
                                  AssetImage('./lib/images/avatar.png'),
                              backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    child: Consumer<UserProfileModel>(
                      builder: (context, model, child) {
                        return Text(
                          'Hi ${model.fname},',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    child: Text(
                      'What would you like to order today?',
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.025, horizontal: screenWidth * 0.025),
                    child: Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          activeCategory = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: activeCategory == index
                              ? Theme.of(context).colorScheme.primaryVariant
                              : Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[200],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(categories[index].imageUrl),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    categories[index].name,
                                    style: GoogleFonts.montserrat(
                                      color: activeCategory == index ? Colors.white : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  key: UniqueKey(),
                  itemCount: items.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                ItemDetails(index: index),
                            transitionDuration: Duration(milliseconds: 1000),
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
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                offset: Offset(1, 4),
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: 'image ' + items[index].name,
                                  child: Center(
                                    child: Image.asset(
                                      items[index].imgUrl,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Container(
                                    child: Text(
                                      items[index].name,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "\u20B9 " + items[index].price.toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            Text(
                                              "per " + items[index].unit,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              bool flag = false;
                                              for (int i = 0;
                                                  i <
                                                      Provider.of<CartModel>(context, listen: false)
                                                          .getLength();
                                                  i++) {
                                                if (items[index] ==
                                                    Provider.of<CartModel>(context, listen: false)
                                                        .getItems()[i]) {
                                                  flag = true;
                                                  Provider.of<CartModel>(context, listen: false)
                                                      .getItems()[i]
                                                      .quantity++;
                                                  break;
                                                }
                                              }
                                              if (!flag) {
                                                Provider.of<CartModel>(context, listen: false)
                                                    .add(items[index]);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<CategoriesModel> categories = [
  CategoriesModel(imageUrl: './lib/images/all.png', name: 'All'),
  CategoriesModel(imageUrl: './lib/images/vegetables.png', name: 'Vegetables'),
  CategoriesModel(imageUrl: './lib/images/fruits.png', name: 'Fruits'),
  CategoriesModel(imageUrl: './lib/images/vegetables.png', name: 'Cut Vegetables'),
  CategoriesModel(imageUrl: './lib/images/fruits.png', name: 'Cut Fruits'),
];

List<CartItem> items = [
  CartItem(
    name: "Banana",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/banana.png',
    unit: 'piece',
  ),
  CartItem(
    name: "Apple",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/apple.png',
    unit: 'kg',
  ),
  CartItem(
    name: "Mango",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/mango.png',
    unit: 'kg',
  ),
  CartItem(
    name: "Grapes",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/grapes.png',
    unit: 'kg',
  ),
  CartItem(
    name: "Pear",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/pear.png',
    unit: 'kg',
  ),
  CartItem(
    name: "South African Apple",
    price: 20.0,
    quantity: 1,
    imgUrl: './lib/images/apple.png',
    unit: 'kg',
  ),
];
