import 'package:bloc/bloc.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/save_locations/model/location.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:bus_navigation/features/save_locations/repository/location_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationRepository location_repository;
  LocationsBloc({required this.location_repository})
      : super(LocationsInitial()) {
    on<LocationsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SaveLocation) {
        print(event.location);
        print(event.name);
        var saveName = event.name;
        var name = event.location.name;
        var latlng = event.location.location;
        print('before add');
        await location_repository.addLocation(LocationModel(
            id: 0,
            savedName: saveName,
            date: DateTime.now(),
            name: name,
            lat: latlng.latitude.toString(),
            long: latlng.longitude.toString()));
        var locs = await location_repository.getAllLocations();
        print('here 1');
        print(locs);
        emit(FetchSavedLocations(locations: locs));
      } else if (event is FetchLocation) {
        var locs = await location_repository.getAllLocations();
        print('here 2');
        print(locs);
        emit(FetchSavedLocations(locations: locs));
      } else if (event is DeleteLocation) {
        await location_repository.deleteLocation(event.id);
        var locs = await location_repository.getAllLocations();
        emit(FetchSavedLocations(locations: locs));
      }
    });
  }
}
