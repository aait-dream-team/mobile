import 'package:bus_navigation/features/home/presentation/home_page.dart';
import 'package:bus_navigation/features/onBoarding/presentation/screens/onBoarding_page.dart';
import 'package:bus_navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  await FlutterMapTileCaching.initialise();
  await FMTC.instance('mapStore').manage.createAsync();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your xapplication.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: RouteHistory.route,
      onGenerateRoute: PageRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null
          ? OnBoardingPage.route
          : HomePage.route,

      // home: const OnBoardingPage(),
    );
  }
}
