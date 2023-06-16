part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  late final LatLng position;
  late final double zoom;
}

class HomeInitialState extends HomeState {
  @override
  LatLng get position => LatLng(8.9806, 38.7578);
  @override
  double get zoom => 12.1;
  
  @override
  // TODO: implement props
  List<Object?> get props => [position, zoom];
}

class HomeMapState extends HomeState {
  @override
  final LatLng position;
  @override
  final double zoom;

  HomeMapState(this.position, this.zoom);
  
  @override
  // TODO: implement props
  List<Object?> get props => [position, zoom];
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
      {required this.position,
      required this.name,
      required this.zoom,
      required this.pinPosition});
      
        @override
        // TODO: implement props
        List<Object?> get props => [position, name, zoom, pinPosition];
}

class HomePinnedLoadingState extends HomePinnedState {
  HomePinnedLoadingState(
      {required super.position,
      required super.name,
      required super.zoom,
      required super.pinPosition});
}

class HomePinnedMapMovedState extends HomePinnedState {
  HomePinnedMapMovedState(
      {required super.position,
      required super.name,
      required super.zoom,
      required super.pinPosition});
}
