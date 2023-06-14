import 'dart:ffi';

import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/save_locations/model/location.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:bus_navigation/features/save_locations/provider/location_provider.dart';
import 'package:latlong2/latlong.dart';

class LocationRepository {
  final LocationDataProvider dataProvider;

  LocationRepository({
    required this.dataProvider,
  });

  Future<List<PinLocation>> getAllLocations() async {
    final data = await dataProvider.getAllLocations();
    List<PinLocation> result = [];
    for (LocationModel loc in data) {
      result.add(PinLocation(
          id: loc.id,
          location: PinPoint(
              location: LatLng(double.parse(loc.lat), double.parse(loc.long)),
              name: loc.name),
          name: loc.savedName,
          date: loc.date));
    }
    return result;
  }

  Future<void> addLocation(LocationModel location) async {
    await dataProvider.addLocation(location);
  }

  List<LocationModel> getUniqueLocations(List<LocationModel> locations) {
    List<LocationModel> uniqueRoutes = [];
    Set<String> names = {};
    for (LocationModel location in locations) {
      if (!names.contains(location.savedName)) {
        uniqueRoutes.add(location);
        names.add(location.savedName);
      }
    }
    return uniqueRoutes;
  }
  Future<void> deleteLocation(int id) async{
    await dataProvider.deleteLocation(id);
  }
}
