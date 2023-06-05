import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async {
      if (event is MapPinChanged) {
        emit(HomePinnedState(
            position: event.position,
            zoom: event.zoom,
            name: event.name,
            pinPosition: event.pinPosition));
      } else if (event is MapLoadEvent) {
        emit(HomeInitialState());
      } else if (event is MapMoved) {
        emit(HomeMapState(event.position, event.zoom));
      }
    });
  }
}
