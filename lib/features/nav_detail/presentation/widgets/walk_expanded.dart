import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:flutter/material.dart';

class WalkModeExpanded extends StatelessWidget {
  final Leg leg;
  final int index;
  final int currentIndex;
  // final Color color;
  const WalkModeExpanded({super.key, required this.leg, required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    if (index > currentIndex){
      decoration = const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    else if(index < currentIndex){
      decoration = const BoxDecoration(
          color: Color.fromARGB(255, 213, 210, 210),
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    else{
      decoration = const BoxDecoration(
          color: Color.fromARGB(255, 105, 211, 109),
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    //  leg.distance;
    return Container(
      height: 30,
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${leg.distance} m "),
                Text("${leg.duration} min")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
