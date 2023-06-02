part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class LoadNavigationEvent extends NavigationEvent {
  final List<String> polylineString;

  LoadNavigationEvent({required this.polylineString});
}

class StartNavigationEvent extends NavigationEvent {}

class UpdateUserLocationEvent extends NavigationEvent {
  final LatLng location;

  UpdateUserLocationEvent(this.location);
}
