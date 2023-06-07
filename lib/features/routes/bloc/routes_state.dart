part of 'routes_bloc.dart';

@immutable
abstract class RoutesState {
  final List<RecentRouteModel> routes;

  RoutesState({required this.routes});
}

class RoutesInitial extends RoutesState {
  RoutesInitial({required super.routes});
}

class RoutesLoading extends RoutesState {
  RoutesLoading({required super.routes});
}

class RoutesLoaded extends RoutesState {
  RoutesLoaded({required super.routes});
}

class RoutesPinPoint extends RoutesState {
  final PinPoint from;
  final PinPoint to;

  RoutesPinPoint({required this.from, required this.to, required super.routes});
}
