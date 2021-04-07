import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:natures_delicacies/models/onboarding_model.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingContent.length,
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
    );
  }
}
