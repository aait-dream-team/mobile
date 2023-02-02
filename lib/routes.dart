import 'package:flutter/material.dart';

import 'package:bus_navigation/features/home/presentation/home_page.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) {
          return const HomePage(title: "intial setup");
        });
    }
  }
}
