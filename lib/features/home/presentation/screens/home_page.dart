import 'package:bus_navigation/features/home/presentation/widgets/floating_search_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/map_widget.dart';

class HomeWidget extends StatefulWidget {
  static const String route = "/home";

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  
  @override
  Widget build(BuildContext context) {
    return const Stack(fit: StackFit.expand, children: [
          MapWidget(),
          FloatingSearchBarWidget()
        ]);
  }
}