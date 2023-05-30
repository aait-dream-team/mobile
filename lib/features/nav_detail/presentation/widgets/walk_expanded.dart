import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:flutter/material.dart';

class WalkModeExpanded extends StatelessWidget {
  final Leg leg;
  const WalkModeExpanded({super.key, required this.leg});

  @override
  Widget build(BuildContext context) {
    //  leg.distance;
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("${leg.distance}"), Text("${leg.duration}")],
            ),
          ),
        ],
      ),
    );
  }
}
