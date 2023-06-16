part of 'routes_bloc.dart';

@immutable
abstract class RoutesState extends Equatable {
  final List<RecentRouteModel> routes;

  const RoutesState({required this.routes});
}

class RoutesInitial extends RoutesState {
  const RoutesInitial({required super.routes});
  
  @override
  // TODO: implement props
  List<Object?> get props => [routes];
}

class RoutesLoading extends RoutesState {
  const RoutesLoading({required super.routes});
  
  @override
  // TODO: implement props
  List<Object?> get props => [routes];
}

class RoutesLoaded extends RoutesState {
  const RoutesLoaded({required super.routes});
  
  @override
  // TODO: implement props
  List<Object?> get props => [routes];
}

class RoutesPinPoint extends RoutesState {
  final PinPoint from;
  final PinPoint to;
  final DateTime datetime;
  final bool isDepartureTime;

  const RoutesPinPoint(
      {required this.from,
      required this.to,
      required super.routes,
      required this.datetime,
      required this.isDepartureTime});
      
        @override
        // TODO: implement props
        List<Object?> get props => [from, to, datetime, isDepartureTime];
}
