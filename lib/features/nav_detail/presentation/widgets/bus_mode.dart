import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/time_icon.dart';
import 'package:flutter/material.dart';

class BusMode extends StatelessWidget {
  final Leg leg;
  const BusMode({super.key, required this.leg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TimeIcon(
              type: TimeType.start,
              time: "${leg.startTime.hour}: ${leg.startTime.minute}"),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Icon(Icons.directions_bus),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'A2S',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 2, // Width of the line
                  height: 100, // Height of the line
                  color: Colors.black,
                ), // Space between line and circle
                Container(
                  width: 20, // Diameter of the circle
                  height: 20, // Diameter of the circle
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          TimeIcon(
              type: TimeType.transit,
              time: "${leg.endTime.hour}: ${leg.endTime.minute}"),
          Divider(),
        ],
      ),
    );
  }
}
