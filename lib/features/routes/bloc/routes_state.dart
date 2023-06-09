part of 'routes_bloc.dart';

@immutable
abstract class RoutesState {
  final List<RecentRouteModel> routes;

  const RoutesState({required this.routes});
}

class RoutesInitial extends RoutesState {
  const RoutesInitial({required super.routes});
}

class RoutesLoading extends RoutesState {
  const RoutesLoading({required super.routes});
}

class RoutesLoaded extends RoutesState {
  const RoutesLoaded({required super.routes});
}

class RoutesPinPoint extends RoutesState {
  final PinPoint from;
  final PinPoint to;

  const RoutesPinPoint({required this.from, required this.to, required super.routes});
}
