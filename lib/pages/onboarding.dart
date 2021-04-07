import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:natures_delicacies/models/onboarding_model.dart';
import 'package:natures_delicacies/pages/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentindex = 0;

  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingContent.length,
              onPageChanged: (int index) {
                setState(() {
                  currentindex = index;
                });
              },
              itemBuilder: (context, i) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          onboardingContent[i].image,
                          height: 300,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          onboardingContent[i].title,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          onboardingContent[i].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingContent.length,
                (index) => buildDots(index, context),
              ),
            ),
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: EdgeInsets.all(40),
            child: TextButton(
              child: Text(
                currentindex == onboardingContent.length - 1
                    ? 'Continue'
                    : 'Next',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (currentindex == onboardingContent.length - 1) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('firstTime', false);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => UserLogin()));
                } else {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.linearToEaseOut);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentindex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
