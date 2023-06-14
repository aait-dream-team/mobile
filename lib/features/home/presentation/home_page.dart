import 'package:bus_navigation/core/utils/colors.dart';
import 'package:bus_navigation/features/history/presentation/screens/history_page.dart';
import 'package:bus_navigation/features/home/presentation/screens/home_page.dart';

import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_argument.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homepage";
  final int index;
  final ScreenArgument? screenArgument;
  const HomePage({
    this.index = 0,
    this.screenArgument,
    super.key,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState(index: index, screenArgument: screenArgument);
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final ScreenArgument? screenArgument;
  _HomePageState({
    required this.index,
    this.screenArgument,
  });
  // final HomeBloc _homeBloc = HomeBloc()..add(MapLoadEvent());

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      // Providing the bloc at this level so that the map state doesn't reset
      // when navigating between states
      // BlocProvider.value(value: _homeBloc, child: const HomeWidget()),
      const HomeWidget(),
      // SearchResults(),
      // BlocProvider.value(value: _routesBloc, child: const RoutesPage()),
      screenArgument is ScreenArgumentsRoutes
          ? RoutesPage(
              screenArgumentsRoutes: screenArgument as ScreenArgumentsRoutes,
            )
          : const RoutesPage(),
      RouteHistory(),
      Center(child: Text("Settings"),)
    ];
    return Scaffold(
      body:  screens[index],
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
            
          ],
        ),
      ),
    );
  }
}
