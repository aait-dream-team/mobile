import 'package:bus_navigation/features/onBoarding/presentation/widgets/onBoarding_widget.dart';
import 'package:flutter/material.dart';

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
          title: 'Your All-in-One Urban Exploration Companion"',
          description:
              'Discover, Connect, and Traverse your city effortlessly with our all-in-one public transport companion.',
          image: 'assets/onBoarding/image0.png',
          bgColor: Colors.indigo,
        ),
        OnboardingModel(
          title: 'Effortless Navigation through Bus, Train, and Walking Routes',
          description:
              'Seamlessly search, connect, and navigate through bus, train, and walking routes for a hassle-free urban exploration.',
          image: 'assets/onBoarding/image1.jpg',
          bgColor: const Color(0xFFFEF9EB),
        ),
      ],
    );
  }
}
