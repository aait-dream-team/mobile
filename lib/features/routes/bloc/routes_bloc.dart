import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  RoutesBloc() : super(RoutesInitial()) {
    on<RoutesEvent>((event, emit) {
      // TODO: implement event handler
      if (event is PointPicked){
        // print(event.to);
        // print(event.from);
        print('from ${event.from}, to: ${event.to}');
        emit(RoutesPinPoint(from: event.from, to: event.to));
      }
    });
  }
}
