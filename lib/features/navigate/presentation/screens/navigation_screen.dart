import 'package:bus_navigation/features/navigate/bloc/navigation_bloc.dart';
import 'package:bus_navigation/features/navigate/data_provider/navigation_data_provider.dart';
import 'package:bus_navigation/features/navigate/repository/navigation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/navigation_map.dart';

class NavigationPage extends StatefulWidget {
  final NavigationRepository repository =
      NavigationRepository(dataProvider: NavigationDataProvider());

  NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NavigationBloc(repository: widget.repository)
          ..add(LoadNavigationEvent()),
          child: NavigateMapWidget(),);
  }
}