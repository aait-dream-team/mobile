import 'package:bus_navigation/features/home/bloc/home_bloc.dart';
import 'package:bus_navigation/features/home/presentation/home_page.dart';
import 'package:bus_navigation/features/onBoarding/presentation/screens/onBoarding_page.dart';
import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/search_results/bloc/search_bloc.dart';
import 'package:bus_navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/search_results/data_provider/route_search_data_provider.dart';
import 'features/search_results/repository/route_search_repository.dart';

int? initScreen;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoutesBloc>(
            create: (BuildContext context) => RoutesBloc()),
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
        BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
                repository: RouteSearchRepository(
                    dataProvider: RouteSearchDataProvider())))
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
