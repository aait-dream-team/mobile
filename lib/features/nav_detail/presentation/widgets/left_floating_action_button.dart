import 'package:flutter/material.dart';

class LeftFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const LeftFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = -scaffoldGeometry.floatingActionButtonSize.width / 200;
    final double y = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        16;
    return Offset(10, y);
  }

  @override
  String toString() => 'LeftFloatingActionButtonLocation';
}

class LeftFloatingActionButtonExample extends StatelessWidget {
  const LeftFloatingActionButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your desired action here
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: const LeftFloatingActionButtonLocation(),
    );
  }
}
