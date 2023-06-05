import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  static const String route = '/MapChoice';

  final ScreenArgumentsRoutesArgs screenArguments;

  const MapPage({super.key, required this.screenArguments});
  @override
  _MapPageState createState() =>
      _MapPageState(screenArguments: screenArguments);
}

class _MapPageState extends State<MapPage> {
  final ScreenArgumentsRoutesArgs screenArguments;

  _MapPageState({required this.screenArguments});

  // Create a map controller
  final MapController _mapController = MapController();

  // Create a pin icon
  final Icon _pinIcon = const Icon(
    Icons.location_pin,
    size: 40,
    color: Colors.red,
  );

  // Create a variable to store the center location
  late LatLng _centerLocation;

  @override
  void initState() {
    super.initState();
    // Initialize the center location with some default value
    _centerLocation = LatLng(8.999764, 38.754095);
  }

// 8.999764, 38.754095
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _centerLocation, // Initial center location
              zoom: 13.0,
              onPositionChanged: (position, hasGesture) {
                // Update the center location when the map is moved
                if (hasGesture) {
                  setState(() {
                    _centerLocation = position.center!;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  tileProvider: FMTC.instance('mapStore').getTileProvider()),
            ],
          ),
          Center(
            child: _pinIcon, // Show the pin icon at the center
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //         var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
          // var first = addresses.first;
          // print("${first.featureName} : ${first.addressLine}");
          List<Placemark> placemarks = await placemarkFromCoordinates(
              _centerLocation.latitude, _centerLocation.longitude);
          Placemark place = placemarks[0];
          String locationName =
              "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode} ${place.country}";
          print(locationName);
          screenArguments.func(_centerLocation, locationName);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
