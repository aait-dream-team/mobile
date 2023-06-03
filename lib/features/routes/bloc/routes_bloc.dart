import 'package:bloc/bloc.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';
import 'package:bus_navigation/features/routes/repository/recent_route_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/pin.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final RecentRouteRepository recentRouteRepository;


  RoutesBloc({required this.recentRouteRepository}) : super(RoutesInitial()) {
    on<RoutesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is PointPicked){
        if (event.from.name != ''){
          print(event.from.name);
          await recentRouteRepository.addRecentRoute(RecentRouteModel(name: event.from.name, lat: event.from.location.latitude.toString(), long: event.from.location.longitude.toString()));
        }
        if (event.to.name != ''){
          print(event.to.name);
        }
        // print('from ${event.from.name}|${event.from.location}, to: ${event.to.name}|${event.to.location}');
        emit(RoutesPinPoint(from: event.from, to: event.to));
      }
    });
  }
}
