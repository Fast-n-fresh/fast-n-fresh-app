import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/product_category.dart';
import 'package:natures_delicacies/models/user_page.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/network/order_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../item_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = new Random();
  int activeCategoryIndex = 0;
  String activeCategoryName;

  OrderUtils orderUtils = new OrderUtils();
  List<ProductCategory> categories;
  List<Product> products;

  final AsyncMemoizer _categoryMemoizer = AsyncMemoizer();

  Future getCategories() {
    return this._categoryMemoizer.runOnce(() async {
      await orderUtils.getCategories().then((value) {
        categories = value;
        activeCategoryName = categories[0].name;
      });
    });
  }

  Future getProducts() async {
    await orderUtils
        .getProducts(activeCategoryName == null ? 'All' : activeCategoryName)
        .then((value) {
      products = value;
    });
  }

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
                right: screenWidth * 0.030,
                left: screenWidth * 0.030,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<UserProfileModel>(
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
                              Text(
                                'What would you like to order today?',
                                style: GoogleFonts.montserrat(
                                  color: Theme.of(context).colorScheme.onBackground,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<UserPage>(context, listen: false).setCurrentPage(3);
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
                FutureBuilder(
                  future: getCategories(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Container(
                          height: 80,
                          child: ListView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.5),
                              child: Shimmer.fromColors(
                                key: UniqueKey(),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: 120,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      case ConnectionState.done:
                        print('fetched categories');
                    }
                    return Container(
                      height: 80,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              activeCategoryIndex = index;
                              activeCategoryName = categories[index].name;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: activeCategoryIndex == index
                                  ? Theme.of(context).colorScheme.primaryVariant
                                  : Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey[200],
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(categories[index].imageUrl),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        categories[index].name,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: activeCategoryIndex == index
                                              ? Colors.white
                                              : Colors.black,
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
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: getProducts(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Expanded(
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
                            itemCount: 8,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Shimmer.fromColors(
                                key: UniqueKey(),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: GridTile(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    case ConnectionState.done:
                      print('fetched products');
                  }
                  return Expanded(
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
                        itemCount: products.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ItemDetails(index: index, products: products),
                                  transitionDuration: Duration(milliseconds: 1000),
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
                                        tag: 'image ' + products[index].name,
                                        child: Center(
                                          child: Image.network(
                                            products[index].imageUrl,
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
                                            products[index].name,
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
                                                    "\u20B9 " + products[index].price.toString(),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                  Text(
                                                    "per " + products[index].unit,
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
                                                            Provider.of<Cart>(context,
                                                                    listen: false)
                                                                .getLength();
                                                        i++) {
                                                      if (products[index].name ==
                                                          Provider.of<Cart>(context, listen: false)
                                                              .getProducts()[i]
                                                              .name) {
                                                        flag = true;
                                                        Provider.of<Cart>(context, listen: false)
                                                            .getProducts()[i]
                                                            .quantity++;
                                                        break;
                                                      }
                                                    }
                                                    if (!flag) {
                                                      Provider.of<Cart>(context, listen: false)
                                                          .add(products[index]);
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
                  );
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
