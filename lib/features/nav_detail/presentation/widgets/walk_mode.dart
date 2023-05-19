import 'package:bus_navigation/core/utils/utils.dart';
import 'package:flutter/material.dart';

class WalkMode extends StatelessWidget {
  const WalkMode({super.key});

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(
      color: Colors.grey,
      width: 0.5,
    );
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          right: borderSide,
          bottom: borderSide,
        ),
      ),
      child: const Icon(Icons.directions_walk_outlined),
    );
  }
}

class WalkModeExpanded extends StatelessWidget {
  const WalkModeExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("430 m"),
        Text("6 min (+2 min waiting)"),
      ],
    );
  }
}
