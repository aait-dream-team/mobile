part of 'locations_bloc.dart';

@immutable
abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class FetchSavedLocations extends LocationsState {
  final List<PinLocation> locations;

  FetchSavedLocations({required this.locations});
}
