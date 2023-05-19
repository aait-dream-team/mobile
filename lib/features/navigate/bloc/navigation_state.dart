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
  final List<List<LatLng>> legs;

  NavigationSuccessState({required this.legs});
}
