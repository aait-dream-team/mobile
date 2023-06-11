part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  late final LatLng position;
  late final double zoom;
}

class HomeInitialState extends HomeState {
  @override
  LatLng get position => LatLng(8.9806, 38.7578);
  @override
  double get zoom => 12.1;
}

class HomeMapState extends HomeState {
  @override
  final LatLng position;
  @override
  final double zoom;

  HomeMapState(this.position, this.zoom);
}

// Map that contains a pin
class HomePinnedState extends HomeState {
  @override
  final LatLng position;
  @override
  final double zoom;
  final LatLng pinPosition;
  final String name;

  HomePinnedState(
      {required this.position, required this.name, required this.zoom, required this.pinPosition});
}
