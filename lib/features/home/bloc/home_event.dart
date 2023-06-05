part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class MapLoadEvent extends HomeEvent {}

class MapMoved extends HomeEvent {
  final LatLng position;
  final double zoom;

  MapMoved({required this.position, required this.zoom});
}

class MapPinChanged extends HomeEvent {
  final LatLng position;
  final double zoom;
  final LatLng pinPosition;
  final String name;

  MapPinChanged({required this.position,required this.name, required this.zoom, required this.pinPosition});
}

class BackButtonPressed extends HomeEvent {}
