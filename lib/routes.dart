import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
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
      case RouteHistory.route:
        return MaterialPageRoute(builder: (context) {
          return RouteHistory();
        });
    }
  }
}
