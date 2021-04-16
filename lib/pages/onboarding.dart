import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/onboarding_model.dart';
import 'package:natures_delicacies/pages/user_login_register.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SvgPicture.asset(
                          onboardingContent[i].image,
                          height: 300,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          onboardingContent[i].title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          onboardingContent[i].description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.grey,
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
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 1.25,
                ),
              ),
              onPressed: () async {
                if (currentindex == onboardingContent.length - 1) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('firstTime', false);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => UserLoginRegister(),
                      transitionDuration: Duration(milliseconds: 1000),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
