import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:flutter/material.dart';

class WalkMode extends StatelessWidget {
  final Leg leg;
  final Color color;
  const WalkMode({super.key, required this.leg, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: const Center(
        child: Column(children: [Icon(Icons.directions_walk),]),
      ),
    );
  }
}
