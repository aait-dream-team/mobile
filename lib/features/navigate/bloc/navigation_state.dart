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

  NavigationSuccessState({required this.routePoints});
}

class NavigationRoutingState extends NavigationState {
  final List<List<LatLng>> legs;
  final int currentIndex;
  final int currentInnerIndex;
  final LatLng userPointInRoute;
  final LatLng userLocation;

  NavigationRoutingState(
      {required this.legs,
      required this.currentIndex,
      required this.currentInnerIndex,
      required this.userPointInRoute,
      required this.userLocation});
}
