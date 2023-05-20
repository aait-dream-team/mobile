part of 'routes_bloc.dart';

@immutable
abstract class RoutesEvent {}
class RoutesInitialEvent extends RoutesEvent{}
class PointPicked extends RoutesEvent{
  final String from;
  final String to;
  PointPicked({
    required this.from,
    required this.to
  });
}