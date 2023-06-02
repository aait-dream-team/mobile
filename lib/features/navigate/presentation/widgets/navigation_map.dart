import 'dart:math';

import 'package:bus_navigation/features/navigate/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

class NavigateMapWidget extends StatelessWidget {
  final List<String> polylineString;
  // Create a map controller
  final MapController _mapController = MapController();

  // Create a list of polylines for each leg of the route
  final List<Polyline> _routePolylines = [];

  NavigateMapWidget({super.key, required this.polylineString});

  Color _randomColor() {
    var random = Random();
    // Generate a random integer between 0 and 255 for each color channel
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);

    // Create a color object with full opacity and the random values
    return Color.fromARGB(170, r, g, b);
  }

  LatLngBounds _createPolylinesAndBounds(List<List<LatLng>> routeData) {
    // Initialize the bounds with the first point of the route
    double minLat = routeData[0][0].latitude;
    double maxLat = routeData[0][0].latitude;
    double minLng = routeData[0][0].longitude;
    double maxLng = routeData[0][0].longitude;

    // Iterate over each leg of the route
    for (int i = 0; i < routeData.length; i++) {
      // Iterate over each point of the leg
      for (LatLng point in routeData[i]) {
        // Update the bounds with the minimum and maximum latitude and longitude values
        minLat = min(minLat, point.latitude);
        maxLat = max(maxLat, point.latitude);
        minLng = min(minLng, point.longitude);
        maxLng = max(maxLng, point.longitude);
      }
    }

    // Create a bounds object with the minimum and maximum values
    return LatLngBounds(
      LatLng(minLat - 0.01, minLng - 0.01),
      LatLng(maxLat + 0.01, maxLng + 0.01),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<List<LatLng>> polylinePoints = parsePoints(polylineString);
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: ((context, state) {
      if (state is NavigationSuccessState) {
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(9.0229687, 38.7747978), // Initial center location
            zoom: 11.0,
            onMapReady: () {
              // Fit the bounds when the map is created
              _mapController.fitBounds(_createPolylinesAndBounds(state.legs));
            },
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                tileProvider: FMTC.instance('mapStore').getTileProvider()),
            PolylineLayer(
              polylines: parsePoints(polylineString)
                  .map((e) => Polyline(
                        color: _randomColor(),
                        strokeWidth: 6.0,
                        points: e,
                      ))
                  .cast<Polyline>()
                  .toList(),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }));
  }

  static List<List<LatLng>> parsePoints(List<String> polylineStrings) {
    PolylinePoints polylinePoints = PolylinePoints();

    return polylineStrings
        .map((e) => polylinePoints
            .decodePolyline(e)
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList())
        .toList();
  }
}
