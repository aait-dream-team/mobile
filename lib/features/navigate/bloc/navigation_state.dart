part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationInitialState extends NavigationState {}

class NavigationLoadingState extends NavigationState {}

class NavigationLoadFailedState extends NavigationState {
  final String msg;

  NavigationLoadFailedState({required this.msg});
}

class NavigationSuccessState extends NavigationState {
  final List<List<LatLng>> routePoints;
  final PinPoint fromPin, toPin;
  final NavDetailModel navDetailModel;

  NavigationSuccessState(
      {required this.routePoints,
      required this.navDetailModel,
      required this.fromPin,
      required this.toPin});
}

class NavigationRoutingState extends NavigationState {
  final List<List<LatLng>> legs;
  final PinPoint fromPin, toPin;
  final NavDetailModel navDetailModel;
  final int currentIndex;
  final int currentInnerIndex;
  final LatLng userPointInRoute;
  final LatLng userLocation;
  final int currentIntermidateStopIndex;
  final double direction;
  final bool isFreeLook;

  NavigationRoutingState({
    required this.legs,
    required this.navDetailModel,
    required this.currentIndex,
    required this.currentInnerIndex,
    required this.userPointInRoute,
    required this.userLocation,
    required this.currentIntermidateStopIndex,
    required this.fromPin,
    required this.toPin,
    required this.direction,
    required this.isFreeLook,
  });
}
