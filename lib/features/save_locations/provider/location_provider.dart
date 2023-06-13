
import 'package:bus_navigation/core/local_db/local_db.dart';
import 'package:bus_navigation/features/save_locations/model/location.dart';
class LocationDataProvider {
  static LocalDB db = LocalDB.instance;

  Future<List<LocationModel>> getAllLocations() async {
    var data = await db.getLocations();
    return await _convertRoute(data);
  }

  Future<void> addLocation(LocationModel location) async {
    await db.insertLocation(location.toMap());
  }

  Future<void> addLocations(List<LocationModel> location) async {
    for (var i = 0; i < location.length; i++) {
      await addLocation(location[i]);
    }
  }

  Future<List<LocationModel>> _convertRoute(data) async {
    List<LocationModel> result = [];

    data.forEach((element) {
      print(element);
      print(element['id'].runtimeType);
      var item = LocationModel.fromMap(element);
      result.add(item);
    });
    return result;
  }
  Future<void> deleteLocation(int id) async {
    await db.deleteLocation(id);
  }
}
