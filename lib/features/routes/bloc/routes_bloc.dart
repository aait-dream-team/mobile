import 'package:bloc/bloc.dart';
import 'package:bus_navigation/features/routes/model/pin.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../model/pin.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  RoutesBloc() : super(RoutesInitial()) {
    on<RoutesEvent>((event, emit) {
      // TODO: implement event handler
      if (event is PointPicked){
        // print('from ${event.from.name}|${event.from.location}, to: ${event.to.name}|${event.to.location}');
        emit(RoutesPinPoint(from: event.from, to: event.to));
      }
    });
  }
}
