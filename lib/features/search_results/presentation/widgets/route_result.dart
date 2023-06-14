import 'dart:math';

import 'package:bus_navigation/core/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/RouteResultModel.dart';

class RouteWidget extends StatelessWidget {
  final RouteSearchResultModel result;

  const RouteWidget({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    // Calculate the font size based on the screen height
    final smallFontSize = size.height * 0.015;
    final mediumFontSize = size.height * 0.025;
    final largeFontSize = size.height * 0.035;

    // Determine if the first row should be visible based on the screen height
    final showFirstRow = size.height > 300;

    // Determine if the icons and route numbers should be visible based on the screen width
    final showIconsAndRouteNumbers = size.width > 200;

    // Determine if the arrival time and walking time should be visible based on the screen width
    final showArrivalAndWalkingTime = size.width > 350;
    // Determine if all the transports should be visible based on the screen width
    final showAllTransports = size.width > 350;

    //Icons to show for each type of transport
    final iconMap = {
      RouteSegmentType.bus: Icons.directions_bus,
      RouteSegmentType.train: Icons.directions_train,
      RouteSegmentType.tram: Icons.directions_subway,
      RouteSegmentType.walking: Icons.nordic_walking
    };

    return Material(
      elevation: 4,
      shadowColor: AppColors.blackAccent.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: Row(
        children: [
          // First column: departure in minutes
          SizedBox(
            width: 110,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Departure in:',
                    style: TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${result.departure.inHours >= 1 ? result.departure.inHours : result.departure.inMinutes}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: largeFontSize,
                        ),
                      ),
                      Text(
                        result.departure.inHours >= 1 ? "hour" : "min",
                        style: TextStyle(
                          fontSize: mediumFontSize,
                        ),
                      ),
                    ],
                  ),
                  // TODO [BIRUK]: use real alerts from OTP
                  if (Random().nextBool())
                    ElevatedButton(
                      onPressed: () {
                        // Show an alert dialog with the list of alerts
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Alerts for this route'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    "result.alerts",
                                    "result.alerts",
                                    "result.alerts",
                                  ]
                                      .map((alert) => const ListTile(
                                            leading: Icon(Icons.ac_unit),
                                            title: Text(
                                                "alert.message alert.message alert.message alert.message alert.message alert.message "),
                                          ))
                                      .toList(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.warning,
                          color: Colors.red, size: 25,), // Change the icon color
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                            side: BorderSide(
                                color: Colors
                                    .black12)), // Add a border to the circle
                        padding: const EdgeInsets.all(9),
                        backgroundColor: Colors.white, // Button color
                      ),
                    )
                ],
              ),
            ),
          ),
          // Second column: transport icons and route numbers
          Expanded(
            child: Center(
              child: Column(
                children: [
                  // First row: transport icons and route numbers
                  if (showFirstRow)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          showAllTransports // Show all transports or only the first one
                              ? (result.transports
                                  .take(3)
                                  .map((transport) => Row(
                                        children: [
                                          if (showIconsAndRouteNumbers)
                                            CircleAvatar(
                                              backgroundColor: AppColors.grey
                                                  .withOpacity(0.1),
                                              child: Icon(
                                                  iconMap[transport.segment],
                                                  color: AppColors.blackAccent),
                                            ),
                                          if (showIconsAndRouteNumbers)
                                            const SizedBox(width: 4),
                                          if (showIconsAndRouteNumbers)
                                            SizedBox(
                                                width: size.width / 10,
                                                child: Text(
                                                  transport.routeNumber,
                                                  overflow: TextOverflow
                                                      .ellipsis, // Set the overflow property to ellipsis or fade
                                                )),
                                          const SizedBox(width: 8),
                                        ],
                                      ))
                                  .toList())
                              : [
                                  Row(
                                    children: [
                                      if (showIconsAndRouteNumbers)
                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.grey.withOpacity(0.1),
                                          child: Icon(
                                              iconMap[
                                                  result.transports[0].segment],
                                              color: AppColors.blackAccent),
                                        ),
                                      if (showIconsAndRouteNumbers)
                                        const SizedBox(width: 4),
                                      if (showIconsAndRouteNumbers)
                                        Text(result.transports[0].routeNumber),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                  Text('${result.totalDuration.inMinutes} min'),
                                ],
                    ),
                  // Second row: departure time, duration, arrival time and walking time
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Chip(
                        label: Text(
                            DateFormat("HH:mm").format(result.departureTime)),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      if (showArrivalAndWalkingTime)
                        Chip(
                          label: Text(
                              DateFormat("HH:mm").format(result.arrivalTime)),
                          backgroundColor: Colors.blue,
                          labelStyle: TextStyle(
                              color: AppColors.white, fontSize: mediumFontSize),
                        ),
                      if (showArrivalAndWalkingTime)
                        Row(
                          children: [
                            const Icon(Icons.directions_walk),
                            Text('${result.walkingTime.inMinutes} min'),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
