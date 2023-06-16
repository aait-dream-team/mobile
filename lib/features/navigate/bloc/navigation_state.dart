part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable{}

class NavigationInitialState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NavigationLoadingState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NavigationLoadFailedState extends NavigationState {
  final String msg;

  NavigationLoadFailedState({required this.msg});
  
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
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
      
        @override
        // TODO: implement props
        List<Object?> get props => [routePoints, navDetailModel, fromPin, toPin];
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
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
        legs,
        navDetailModel,
        currentIndex,
        currentInnerIndex,
        userPointInRoute,
        userLocation,
        currentIntermidateStopIndex,
        fromPin,
        toPin,
      ];
}
