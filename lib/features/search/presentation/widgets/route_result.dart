import 'package:bus_navigation/core/utils/colors.dart';
import 'package:bus_navigation/features/search/models/RouteResultModel.dart';

import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          // First column: departure in minutes
          SizedBox(
            width: 100,
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
                        '${result.departureInMinutes}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: largeFontSize,
                        ),
                      ),
                      Text(
                        'min',
                        style: TextStyle(
                          fontSize: mediumFontSize,
                        ),
                      ),
                    ],
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
                                            Text(transport.routeNumber),
                                          const SizedBox(width: 8),
                                        ],
                                      ))
                                  .toList()
                                ..add(Row(children: [
                                  Text('${result.totalDuration} min')
                                ])))
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
                                  Text('${result.totalDuration} min'),
                                ],
                    ),
                  // Second row: departure time, duration, arrival time and walking time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Chip(
                        label: Text(
                            '${result.departureTime.hour}:${result.departureTime.minute}'),
                        backgroundColor: AppColors.greenAccent,
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: mediumFontSize),
                      ),
                      if (showArrivalAndWalkingTime)
                        Text('${result.totalDuration} min'),
                      if (showArrivalAndWalkingTime)
                        Chip(
                          label: Text(
                              '${result.arrivalTime.hour}:${result.arrivalTime.minute}'),
                          backgroundColor: AppColors.blueAccent,
                          labelStyle: TextStyle(
                              color: AppColors.white, fontSize: mediumFontSize),
                        ),
                      if (showArrivalAndWalkingTime)
                        Row(
                          children: [
                            const Icon(Icons.directions_walk),
                            Text('${result.walkingTime} min'),
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
