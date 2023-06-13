part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class LoadNavigationEvent extends NavigationEvent {
  final List<String> polylineString;
  final NavDetailModel navDetailModel;

  LoadNavigationEvent(
      {required this.polylineString, required this.navDetailModel});
}

class StartNavigationEvent extends NavigationEvent {}

class UpdateUserLocationEvent extends NavigationEvent {
  final LatLng location;

  UpdateUserLocationEvent(this.location);
}

class CancelNavigationEvent extends NavigationEvent {}
