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
    image: "assets/images/onboarding1.jpg",
  ),
  OnboardingModel(
    title: "Your satisfaction is our number one priority.",
    image: "assets/images/onboarding2.jpg",
  ),
  OnboardingModel(
    title: "Let's fulfill your daily need with JustBuy8 Store right now!",
    image: "assets/images/onboarding3.jpg",
  ),
];
