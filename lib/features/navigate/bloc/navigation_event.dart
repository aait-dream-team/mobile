part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class LoadNavigationEvent extends NavigationEvent {
  final List<String> polylineString;
  final NavDetailModel navDetailModel;
  final PinPoint fromPin, toPin;

  LoadNavigationEvent(
      {required this.polylineString,
      required this.navDetailModel,
      required this.fromPin,
      required this.toPin});
}

class StartNavigationEvent extends NavigationEvent {}

class UpdateUserLocationEvent extends NavigationEvent {
  final LatLng location;

  UpdateUserLocationEvent(this.location);
}

class CancelNavigationEvent extends NavigationEvent {}
