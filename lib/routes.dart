import 'package:bus_navigation/features/nav_detail/presentation/screens/detail.dart';
import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
import 'package:bus_navigation/features/onBoarding/presentation/screens/onBoarding_page.dart';
import 'package:flutter/material.dart';

import 'package:bus_navigation/features/home/presentation/home_page.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
      case RouteHistory.route:
        return MaterialPageRoute(builder: (context) {
          return RouteHistory();
        });
      case OnBoardingPage.route:
        return MaterialPageRoute(builder: (context) {
          return const OnBoardingPage();
        });
      case SidePage.route:
        return MaterialPageRoute(builder: (context) {
          return SidePage();
        });
    }
  }
}
