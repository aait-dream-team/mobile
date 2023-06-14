import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async {
      if (event is MapPinChanged) {
        emit(HomePinnedLoadingState(
            position: event.position,
            zoom: event.zoom,
            name: "${event.position.latitude}, ${event.position.longitude}",
            pinPosition: event.pinPosition));
        var name = await getNameFromLatLng(event.pinPosition);
        emit(HomePinnedState(
            position: event.position,
            zoom: event.zoom,
            name: name,
            pinPosition: event.pinPosition));
      } else if (event is MapLoadEvent) {
        emit(HomeInitialState());
      } else if (event is MapMovedWithPin) {
        emit(HomePinnedMapMovedState(
            position: event.position,
            name: event.name,
            zoom: event.zoom,
            pinPosition: event.pinPosition));
      } else if (event is MapMoved) {
        emit(HomeMapState(event.position, event.zoom));
      }
    });
  }
}

Future<String> getNameFromLatLng(LatLng latlng) async {
  print(latlng);
  try{
    List<Placemark> placemarks =
      await placemarkFromCoordinates(latlng.latitude, latlng.longitude, localeIdentifier: "et");
  Placemark place = placemarks[0];
  String locationName =
      "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode} ${place.country}";
  print(locationName);
  return locationName;
  }catch(e){
    return '${latlng.latitude.toString()} | ${latlng.longitude.toString()}, Uknown street, Addis Ababa, Addis Ababa, 1000, Ethiopia}}';
  }
}
