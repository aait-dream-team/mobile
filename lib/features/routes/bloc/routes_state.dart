part of 'routes_bloc.dart';

@immutable
abstract class RoutesState {}

class RoutesInitial extends RoutesState {

}

class RoutesLoading extends RoutesState {}

class RoutesLoaded extends RoutesState {}
class RoutesPinPoint extends RoutesState {
      final PinPoint from;
      final PinPoint to;

      RoutesPinPoint({
        required this.from,
        required this.to
      });
      
}


