class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Karibu katika application yetu ya Smart Kilimo",
    image: "assets/logo1.png",
    desc: "Kumbuka kujisajili kama wewe ni mkulima iliuweze kupata uwezo wa kupata taarifa.",
  ),
  OnboardingContents(
    title: "Furahia huduma katika mfumo wetu.",
    image: "assets/logo2.png",
    desc:
        "Unaweza kupata taarifa mbalimbali zinazohusu masuala ya kilimo.",
  ),
  OnboardingContents(
    title: "Karibu kwenye mfumo uwe mkulima wa kisasa",
    image: "assets/logo2.png",
    desc: "karibu ujisajili.",
  ),
];
