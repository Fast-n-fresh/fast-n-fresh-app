class Onboarding {
  String image;
  String title;
  String description;

  Onboarding({this.image, this.title, this.description});
}

List<Onboarding> onboardingContent = [
  Onboarding(
      image: './lib/images/food.svg',
      title: 'Quality Food',
      description: "Get fresh fruits and vegetables"),
  Onboarding(
      image: './lib/images/mobile.svg',
      title: 'Quick Payment',
      description: "Order from the comfort of your home"),
  Onboarding(
      image: './lib/images/delivery.svg',
      title: 'Doorstep Delivery',
      description: 'Fast and safe delivery to your house')
];
