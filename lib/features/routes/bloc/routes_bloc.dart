import 'package:bloc/bloc.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';
import 'package:bus_navigation/features/routes/repository/recent_route_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final RecentRouteRepository recentRouteRepository;
  List<RecentRouteModel> routes = [];

  RoutesBloc({required this.recentRouteRepository})
      : super(const RoutesInitial(routes: [])) {
    on<RoutesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is PointPicked) {
        // final data = await recentRouteRepository.getAllRoutes();
        // print('data: ');
        // print(data);
        if (event.from.name != '') {
          recentRouteRepository.addRecentRoute(RecentRouteModel(
              name: event.from.name,
              lat: event.from.location.latitude.toString(),
              long: event.from.location.longitude.toString(),
              date: event.datetime));
        }
        if (event.to.name != '') {
          recentRouteRepository.addRecentRoute(RecentRouteModel(
              name: event.to.name,
              lat: event.to.location.latitude.toString(),
              long: event.to.location.longitude.toString(),
              date: event.datetime));
        }
        emit(RoutesPinPoint(
            from: event.from,
            to: event.to,
            datetime: event.datetime,
            routes: routes,
            isDepartureTime: event.isDepartureTime));
      } else if (event is FetchRecentRoute) {
        emit(RoutesLoading(routes: routes));
        routes = await recentRouteRepository.getAllRoutes();
        emit(RoutesLoaded(routes: routes));
      }
    });
  }
}
