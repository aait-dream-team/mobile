import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
import 'package:bus_navigation/features/onBoarding/presentation/screens/onBoarding_page.dart';
import 'package:flutter/material.dart';
import 'package:bus_navigation/features/home/presentation/home_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/search_routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments.dart';
import 'package:bus_navigation/features/routes/presentation/screens/choose_from_map.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
      case RouteHistory.route:
        return MaterialPageRoute(builder: (context) {
          return RoutesPage();
        });
      case OnBoardingPage.route:
        return MaterialPageRoute(builder: (context) {
          return const OnBoardingPage();
        });
      case RoutesPage.route:
        return MaterialPageRoute(builder: (context) {
          return const RoutesPage();
        });
      case SearchPage.route:
        return MaterialPageRoute(builder: (context) {
          if (args  is ScreenArguments){
            return SearchPage(screenArguments: args);
          }
          return const Text('data');
        });
      case MapPage.route:
        return MaterialPageRoute(builder: (context) {
          if (args  is ScreenArguments){
            return MapPage(screenArguments: args);
          }
          return const Text('data');
        });
    }
    return null;
  }
}
