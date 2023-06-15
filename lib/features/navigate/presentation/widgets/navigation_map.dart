import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/navigate/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class NavigateMapWidget extends StatelessWidget {
  static List<Color> routeColors = [
    const Color.fromARGB(255, 14, 129, 222),
    const Color.fromARGB(255, 41, 159, 159),
    const Color.fromARGB(255, 5, 112, 58),
    const Color.fromARGB(255, 26, 193, 110),
    const Color.fromARGB(255, 146, 235, 43),
    const Color.fromARGB(255, 170, 255, 0),
  ];
  // Create a map controller
  final MapController _mapController = MapController();

  final NavDetailModel navDetailModel;

  NavigateMapWidget({super.key, required this.navDetailModel});

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
    // create a listener for NavigationBloc here

    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationRoutingState && !state.isFreeLook) {
          _mapController.move(state.userPointInRoute, 15.0);
        }
      },
      child: BlocConsumer<NavigationBloc, NavigationState>(
          listenWhen: (previous, current) =>
              (current is NavigationRoutingState &&
                  previous is! NavigationRoutingState),
          listener: (context, state) async {
            if (state is NavigationRoutingState) {
              var isLocationEnabled =
                  await Geolocator.isLocationServiceEnabled();
              if (!isLocationEnabled) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Enable Location Services"),
                      content: const Text('Please enable location services.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Settings'),
                          onPressed: () {
                            AppSettings.openLocationSettings();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          builder: ((context, state) {
            if (state is NavigationSuccessState) {
              print(state.navDetailModel.legs
                  .map((e) => e.intermidateStops ?? [])
                  .expand((element) => element)
                  .toList());
              return SafeArea(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(
                        9.0229687, 38.7747978), // Initial center location
                    zoom: 11.0,
                    onMapReady: () {
                      // Fit the bounds when the map is created
                      _mapController.fitBounds(
                          _createPolylinesAndBounds(state.routePoints));
                    },
                  ),
                  children: [
                    TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        tileProvider:
                            FMTC.instance('mapStore').getTileProvider()),
                    PolylineLayer(
                      polylines: state.routePoints
                          .asMap()
                          .entries
                          .map((e) => Polyline(
                                color: routeColors[
                                    min(e.key, routeColors.length - 1)],
                                strokeWidth: 7.0,
                                points: e.value,
                              ))
                          .cast<Polyline>()
                          .toList(),
                    ),
                    MarkerLayer(
                      markers: state.navDetailModel.legs
                          .map((e) => e.intermidateStops ?? [])
                          .expand((element) => element)
                          .map((e) => Marker(
                              point: e.location,
                              builder: (context) =>
                                  const Icon(Icons.donut_small)))
                          .toList(),
                    )
                  ],
                ),
              );
            } else if (state is NavigationRoutingState) {
              var oldLegs = [];
              if (state.currentIndex > 0) {
                oldLegs = state.legs.sublist(0, state.currentIndex);
              }
              if (state.currentInnerIndex > 0) {
                oldLegs.add(state.legs[state.currentIndex]
                    .sublist(0, state.currentInnerIndex + 1));
              }
              var newLegs = [];
              if (state.currentInnerIndex <
                  state.legs[state.currentIndex].length - 1) {
                newLegs = [
                  state.legs[state.currentIndex].sublist(
                      state.currentInnerIndex,
                      state.legs[state.currentIndex].length)
                ];
              }
              if (state.currentIndex < state.legs.length - 1) {
                newLegs.addAll(state.legs
                    .sublist(state.currentIndex + 1, state.legs.length));
              }
              Geolocator.getPositionStream(
                      locationSettings: AndroidSettings(
                        // intervalDuration: const Duration(seconds: 1),
                        accuracy: LocationAccuracy.bestForNavigation
                      ))
                  .listen((event) {
                    
                print(event.heading);
                var location = LatLng(event.latitude, event.longitude);
                var direction = event.heading;
                BlocProvider.of<NavigationBloc>(context).add(
                    UpdateUserLocationEvent(
                        location: location, direction: direction, isFreeLook: state.isFreeLook));
              });
              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: state.userPointInRoute,
                  zoom: 15.0,
                  onPointerDown: (p0, lt) {
                    BlocProvider.of<NavigationBloc>(context).add(
                    UpdateUserLocationEvent(
                        location: state.userLocation, direction: state.direction, isFreeLook: true));
                  },
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                      tileProvider:
                          FMTC.instance('mapStore').getTileProvider()),
                  PolylineLayer(
                    polylines: [
                      oldLegs.map((e) => Polyline(
                            color: const Color.fromARGB(255, 64, 70, 75),
                            strokeWidth: 8.0,
                            points: e,
                          )),
                      newLegs.map((e) => Polyline(
                            color: const Color.fromARGB(255, 14, 129, 222),
                            strokeWidth: 8.0,
                            points: e,
                          ))
                    ].expand((element) => element).toList(),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          point: state.userLocation,
                          builder: (context) => const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 0, 255, 8),
                              ),
                          width: 42),
                      Marker(
                          point: state.userPointInRoute,
                          builder: (context) => const Icon(Icons.location_on,
                              color: Color.fromARGB(255, 233, 42, 29)),
                          width: 40)
                    ],
                  ),
                  MarkerLayer(
                    markers: state.navDetailModel.legs
                        .map((e) => e.intermidateStops ?? [])
                        .expand((element) => element)
                        .map((e) => Marker(
                            point: e.location,
                            builder: (context) => const Icon(Icons.bus_alert)))
                        .toList(),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
