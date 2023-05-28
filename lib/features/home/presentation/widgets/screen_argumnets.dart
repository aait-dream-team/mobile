import 'package:latlong2/latlong.dart';

class ScreenArgumentsHome {
  final String type;
  final LatLng location;
  final String name;
  ScreenArgumentsHome({
    required this.type,
    required this.name,
    required this.location
  });
}