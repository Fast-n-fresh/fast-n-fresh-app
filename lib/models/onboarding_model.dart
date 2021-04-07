class OnboardingModel {
  String image;
  String title;
  String description;

  OnboardingModel({this.image, this.title, this.description});
}

List<OnboardingModel> onboardingContent = [
  OnboardingModel(
      image: './lib/images/food.svg',
      title: 'Quality Food',
      description: "Get fresh fruits and vegetables"),
  OnboardingModel(
      image: './lib/images/mobile.svg',
      title: 'Quick Payment',
      description: "Order from the comfort of your home"),
  OnboardingModel(
      image: './lib/images/delivery.svg',
      title: 'Doorstep Delivery',
      description: 'Fast and safe delivery to your house')
];
