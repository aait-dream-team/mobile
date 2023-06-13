part of 'routes_bloc.dart';

@immutable
abstract class RoutesEvent {}

class RoutesInitialEvent extends RoutesEvent {}

class PointPicked extends RoutesEvent {
  final PinPoint from;
  final PinPoint to;
  final DateTime datetime;
  final bool isDepartureTime;
  PointPicked(
      {required this.from,
      required this.to,
      required this.datetime,
      required this.isDepartureTime});
}

class FetchRecentRoute extends RoutesEvent {}
