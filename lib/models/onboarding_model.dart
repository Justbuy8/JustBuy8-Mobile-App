import 'package:justbuyeight/constants/app_images.dart';

class OnboardingModel {
  final String title;
  final String image;

  OnboardingModel({
    required this.title,
    required this.image,
  });
}

List<OnboardingModel> contents = [
  OnboardingModel(
    title: "We provide high quality products just for you.",
    image: ImageAssets.onboarding1,
  ),
  OnboardingModel(
    title: "Your satisfaction is our number one priority.",
    image: ImageAssets.onboarding2,
  ),
  OnboardingModel(
    title: "Let's fulfill your daily need with JustBuy8 Store right now!",
    image: ImageAssets.onboarding3,
  ),
];
