import 'package:bus_navigation/features/onBoarding/presentation/widgets/onBoarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/onBoardingModel.dart';

class OnBoardingPage extends StatefulWidget {
  static const String route = "/onBoardingPage";
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  // void initState() async {
  //   super.initState();
  //   // initialize the counter to a saved value, if available
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.setInt('initScreen', 1);
  // }

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
      pages: [
        OnboardingModel(
          title: 'Fast, Fluid and Secure',
          description: 'Enjoy the best of the world in the palm of your hands.',
          image: 'assets/onBoarding/image0.png',
          bgColor: Colors.indigo,
        ),
        OnboardingModel(
          title: 'Connect with your friends.',
          description: 'Connect with your friends anytime anywhere.',
          image: 'assets/onBoarding/image1.png',
          bgColor: const Color(0xff1eb090),
        ),
        OnboardingModel(
          title: 'Bookmark your favourites',
          description:
              'Bookmark your favourite quotes to read at a leisure time.',
          image: 'assets/onBoarding/image2.png',
          bgColor: const Color(0xfffeae4f),
        ),
        OnboardingModel(
          title: 'Follow creators',
          description: 'Follow your favourite creators to stay in the loop.',
          image: 'assets/onBoarding/image3.png',
          bgColor: Colors.purple,
        ),
      ],
    );
  }
}
