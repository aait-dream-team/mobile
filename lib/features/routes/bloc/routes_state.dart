part of 'routes_bloc.dart';

@immutable
abstract class RoutesState {}

class RoutesInitial extends RoutesState {

}

class RoutesLoading extends RoutesState {}

class RoutesLoaded extends RoutesState {}
class RoutesPinPoint extends RoutesState {
      final String from;
      final String to;

      RoutesPinPoint({
        required this.from,
        required this.to
      });
      
}


