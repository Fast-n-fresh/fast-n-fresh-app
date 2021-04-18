import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/categories_model.dart';
import 'package:natures_delicacies/models/page_model.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = new Random();
  int activeCategory = 0;
  String greetingMessage = ' ';

  @override
  void initState() {
    super.initState();
    greetingMessage = greetings[random.nextInt(greetings.length)];
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.050,
            vertical: screenHeight * 0.025,
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
                        Provider.of<PageModel>(context, listen: false).setCurrentPage(3);
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('./lib/images/avatar.png'),
                        radius: 30,
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
                      'Hi ${model.name},',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                child: Text(
                  greetingMessage,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.025,
                    horizontal: screenWidth * 0.025),
                child: Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
                            : Colors.grey[200],
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
                                child: Image.asset(categories[index].imagePath),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  categories[index].title,
                                  style: GoogleFonts.montserrat(
                                    color: activeCategory == index
                                        ? Colors.white
                                        : Colors.black,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> greetings = [
  'Hope you are having a great day.',
  'Are you ready to order some fresh grocery?',
  'What would you like to order today?',
  'Let\'s order some healthy grocery!'
];

List<CategoriesModel> categories = [
  CategoriesModel(imagePath: './lib/images/all.png', title: 'All'),
  CategoriesModel(
      imagePath: './lib/images/vegetables.png', title: 'Vegetables'),
  CategoriesModel(imagePath: './lib/images/fruits.png', title: 'Fruits'),
  CategoriesModel(
      imagePath: './lib/images/vegetables.png', title: 'Cut Vegetables'),
  CategoriesModel(imagePath: './lib/images/fruits.png', title: 'Cut Fruits'),
];
