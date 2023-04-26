// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:justbuyeight/constants/app_theme.dart';

// ignore: use_key_in_widget_constructors
class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
        titlePadding: const EdgeInsets.only(top: 50),
        bodyAlignment: Alignment.topCenter,
        imageAlignment: Alignment.topCenter,
        safeArea: 0,
        imagePadding: EdgeInsets.zero,
        fullScreen: true,
        titleTextStyle: AppTheme.onboardingTitleTextStyle);

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "We provide hight quality products just for you.",
          body: '',
          image: introImage('assets/images/onboarding1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Your satisfaction is our number on priority",
          body: "",
          image: introImage('assets/images/onboarding2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "Let's full fill your daily need with Justbuy8 Store right now!",
          body: '',
          image: introImage('assets/images/onboarding3.jpg'),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: false,
      onDone: (){},
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text(
        'Getting Stated',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(25.0, 10.0),
        activeColor: Colors.white,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget introImage(String assetName) {
    return Image.asset(
      '$assetName',
      fit: BoxFit.fitHeight,
      height: 1000,
    );
  }
}
