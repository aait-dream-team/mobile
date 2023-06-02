import 'package:bus_navigation/features/nav_detail/presentation/widgets/time_icon.dart';
import 'package:flutter/material.dart';

import '../../model/nav_detail_model.dart';

class TrainMode extends StatelessWidget {
  final Leg leg;
  final Color color;
  const TrainMode({super.key, required this.leg, required this.color});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        height: screenHeight * 0.32,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TimeIcon(type: TimeType.start, time: "11:30"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.directions_train),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "${leg.routeShortName}",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2, // Width of the circle's outline
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: TimeIcon(type: TimeType.transit, time: "11:37"),
            ),
          ],
        ),
      ),
    );
  }
}
