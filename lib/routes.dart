import 'package:bus_navigation/features/nav_detail/presentation/screens/detail.dart';
import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
import 'package:bus_navigation/features/onBoarding/presentation/screens/onBoarding_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_argument.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';
import 'package:flutter/material.dart';
import 'package:bus_navigation/features/home/presentation/home_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/search_routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes_args.dart';
import 'package:bus_navigation/features/routes/presentation/screens/choose_from_map.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) {
          return HomePage(
            screenArgument: ScreenArgument(),
          );
        });
      case RouteHistory.route:
        return MaterialPageRoute(builder: (context) {
          return RouteHistory();
        });
      case OnBoardingPage.route:
        return MaterialPageRoute(builder: (context) {
          return const OnBoardingPage();
        });
      case RoutesPage.route:
        return MaterialPageRoute(builder: (context) {
          if (args is ScreenArgumentsRoutes) {
            return HomePage(
              index: 1,
              screenArgument: args,
            );
          }
          return const HomePage(
            index: 1,
          );
          //  RoutesPage();
        });
      case SearchPage.route:
        return MaterialPageRoute(builder: (context) {
          if (args is ScreenArgumentsRoutesArgs) {
            return SearchPage(screenArguments: args);
          }
          return const Text('data');
        });
      case MapPage.route:
        return MaterialPageRoute(builder: (context) {
          if (args is ScreenArgumentsRoutesArgs) {
            return MapPage(screenArguments: args);
          }
          return const Text('data');
        });
      case SidePage.route:
        return MaterialPageRoute(builder: (context) {
          if (args is List) {
            return SidePage(
                navDetailModel: args[1], routeSearchResultModel: args[0], fromPin: args[2], toPin: args[3],);
          }
          print(args);
          return const Text("Error");
        });
    }
    return null;
  }
}
