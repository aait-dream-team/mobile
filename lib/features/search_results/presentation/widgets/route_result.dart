import 'dart:math';

import 'package:collection/collection.dart';
import 'package:bus_navigation/core/utils/colors.dart';
import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/RouteResultModel.dart';

class RouteWidget extends StatelessWidget {
  final RouteSearchResultModel result;
  final NavDetailModel navDetailModel;

  const RouteWidget(
      {Key? key, required this.result, required this.navDetailModel})
      : super(key: key);

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

    var alerts = navDetailModel.legs
        .map((e) => e.alerts)
        .whereNotNull()
        .expand((element) => element)
        .toList();

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
            height: 117,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  if (alerts.isNotEmpty)
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
                                  children: alerts
                                      .map((alert) => ListTile(
                                          leading: const Icon(Icons.ac_unit),
                                          title: Text(alert.alertText)))
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
                          color: Colors.red), // Change the icon color
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                            side: BorderSide(
                                color:
                                    Colors.red)), // Add a border to the circle
                        padding: const EdgeInsets.all(9),
                        backgroundColor: Colors.white, // Button color
                      ),
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Chip(
                        label: Text(
                            DateFormat("HH:mm").format(result.departureTime)),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: mediumFontSize),
                      ),
                      if (showArrivalAndWalkingTime)
                        Text('${result.totalDuration.inMinutes} min'),
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
