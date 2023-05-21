import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  static const String route = '/MapChoice';

  final ScreenArguments screenArguments;

  MapPage({
    required this.screenArguments
  });
  @override
  _MapPageState createState() => _MapPageState(screenArguments: this.screenArguments);
}

class _MapPageState extends State<MapPage> {

  final ScreenArguments screenArguments;

  _MapPageState({
    required this.screenArguments
  });

  // Create a map controller
  MapController _mapController = MapController();

  // Create a pin icon
  Icon _pinIcon = Icon(
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
        onPressed: () {
          screenArguments.func(_centerLocation, 'Pin Location');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}