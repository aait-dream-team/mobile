import 'package:bus_navigation/core/utils/colors.dart';
import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homepage";

  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> screens = [
    const Center(
      child: Text(
        "Home",
      ),
    ),
    const Center(
      child: Text(
        "Routes",
      ),
    ),
    RouteHistory(),
    const Center(
      child: Text(
        "Settings",
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: AppColors.greyShade300,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ))),
        child: NavigationBar(
          height: 60,
          backgroundColor: AppColors.white12,
          selectedIndex: index,
          onDestinationSelected: (index) => {
            setState(() => this.index = index),
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: AppColors.grey,
              ),
              selectedIcon: const Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.route,
                color: AppColors.grey,
              ),
              selectedIcon: const Icon(
                Icons.route,
              ),
              label: 'Routes',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.history,
                color: AppColors.grey,
              ),
              selectedIcon: const Icon(
                Icons.history,
              ),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color: AppColors.grey,
              ),
              selectedIcon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
